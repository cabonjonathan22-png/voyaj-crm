import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import '../billing/billing_data.dart';
import 'settings_page.dart';

/// Paramètres de facturation : identité du vendeur (mentions légales),
/// conditions, plan de comptes et Chorus Pro.
class BillingSection extends ConsumerWidget {
  const BillingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    if (!ref.watch(permissionProvider(Permission.billingSettings))) {
      return SettingsScroll(
        children: [VBanner(message: l10n.billingSettingsForbidden)],
      );
    }
    if (ref.watch(billingApiProvider) == null) {
      return SettingsScroll(
        children: [VBanner(message: l10n.billingSettingsOffline)],
      );
    }
    return ref
        .watch(billingSettingsProvider)
        .when(
          loading: () => const Center(child: VSpinner()),
          error: (e, _) => SettingsScroll(
            children: [
              VBanner(
                message: e is ApiFailure ? e.message : '$e',
                tone: VTone.danger,
              ),
            ],
          ),
          data: (settings) => _BillingForm(settings: settings),
        );
  }
}

/// Champ texte des paramètres (clé JSON).
typedef _TextSetting = (String key, String label, String? hint);

class _BillingForm extends ConsumerStatefulWidget {
  const _BillingForm({required this.settings});

  final BillingSettings settings;

  @override
  ConsumerState<_BillingForm> createState() => _BillingFormState();
}

class _BillingFormState extends ConsumerState<_BillingForm> {
  late final Map<String, Object?> _json = widget.settings.toJson();
  final _controllers = <String, TextEditingController>{};
  late bool _chorusEnabled = widget.settings.chorusEnabled;
  late bool _chorusSandbox = widget.settings.chorusSandbox;
  Map<String, String> _errors = const {};
  bool _saving = false;

  static const _accountKeys = ['customer', 'sales', 'bank'];

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(String key) =>
      _controllers.putIfAbsent(key, () {
        final Object? value = key.startsWith('accounts.')
            ? widget.settings.accounts[key.substring(9)]
            : _json[key];
        return TextEditingController(text: value == null ? '' : '$value');
      });

  Widget _field(_TextSetting setting, {int maxLines = 1, bool secret = false}) {
    final (key, label, hint) = setting;
    return VTextField(
      controller: _controller(key),
      label: label,
      hint: hint,
      maxLines: maxLines,
      obscure: secret,
      error: _errors[key],
    );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    String? text(String key) {
      final value = _controllers[key]?.text.trim();
      return value == null || value.isEmpty ? null : value;
    }

    final json = {..._json};
    for (final key in _controllers.keys) {
      if (!key.startsWith('accounts.')) json[key] = text(key);
    }
    json['legal_name'] = text('legal_name') ?? '';
    for (final key in ['payment_terms', 'late_penalties']) {
      json[key] = text(key) ?? _json[key];
    }
    final errors = <String, String>{};
    for (final key in ['payment_days', 'quote_validity_days']) {
      final n = int.tryParse(text(key) ?? '');
      if (n == null) errors[key] = l10n.formInvalidNumber;
      json[key] = n;
    }
    if (errors.isNotEmpty) {
      setState(() => _errors = errors);
      return;
    }
    json['accounts'] = {
      ...widget.settings.accounts,
      for (final key in _accountKeys) key: text('accounts.$key'),
    }..removeWhere((_, v) => v == null);
    json['chorus_enabled'] = _chorusEnabled;
    json['chorus_sandbox'] = _chorusSandbox;

    setState(() {
      _saving = true;
      _errors = const {};
    });
    try {
      await ref
          .read(billingApiProvider)!
          .saveSettings(BillingSettings.fromJson(json));
      _controllers['chorus_password']?.clear();
      _controllers['piste_client_secret']?.clear();
      ref.read(toastProvider).success(l10n.billingSettingsSaved);
      ref.invalidate(billingSettingsProvider);
    } on ApiFailure catch (e) {
      setState(
        () => _errors = {for (final i in e.issues) _snake(i.field): i.message},
      );
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  static String _snake(String field) =>
      field.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget grid(List<Widget> children) => Wrap(
      spacing: VSpace.x3,
      runSpacing: VSpace.x3,
      children: [
        for (final child in children) SizedBox(width: 320, child: child),
      ],
    );

    return SettingsScroll(
      children: [
        VCard(
          title: l10n.billingSeller,
          description: l10n.billingSellerHelp,
          child: grid([
            _field(('legal_name', l10n.billingLegalName, null)),
            _field(('legal_form', l10n.billingLegalForm, 'SAS')),
            _field(('siren', l10n.orgSiren, null)),
            _field(('siret', l10n.orgSiret, null)),
            _field(('vat_number', l10n.billingVatNumber, 'FR…')),
            _field(('rcs', l10n.billingRcs, 'Rodez')),
            _field(('capital', l10n.billingCapital, '10 000 €')),
            _field(('address', l10n.orgAddress, null), maxLines: 2),
            _field(('postal_code', l10n.orgPostalCode, null)),
            _field(('city', l10n.orgCity, null)),
            _field(('email', l10n.orgEmail, null)),
            _field(('phone', l10n.orgPhone, null)),
            _field(('iban', l10n.billingIban, null)),
            _field(('bic', l10n.billingBic, null)),
          ]),
        ),
        VCard(
          title: l10n.billingConditions,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              grid([
                _field(('payment_days', l10n.billingPaymentDays, '30')),
                _field((
                  'quote_validity_days',
                  l10n.billingQuoteValidityDays,
                  '30',
                )),
              ]),
              const SizedBox(height: VSpace.x3),
              _field(('payment_terms', l10n.billingPaymentTerms, null)),
              const SizedBox(height: VSpace.x3),
              _field((
                'late_penalties',
                l10n.billingLatePenalties,
                null,
              ), maxLines: 3),
              const SizedBox(height: VSpace.x3),
              _field((
                'vat_exemption_reason',
                l10n.billingVatExemption,
                l10n.billingVatExemptionHint,
              )),
              const SizedBox(height: VSpace.x3),
              _field(('footer', l10n.billingFooter, null), maxLines: 2),
            ],
          ),
        ),
        VCard(
          title: l10n.billingAccounts,
          description: l10n.billingAccountsHelp,
          child: grid([
            _field((
              'accounts.customer',
              l10n.billingAccountCustomer,
              '411000',
            )),
            _field(('accounts.sales', l10n.billingAccountSales, '706000')),
            _field(('accounts.bank', l10n.billingAccountBank, '512000')),
          ]),
        ),
        VCard(
          title: l10n.chorusTitle,
          description: l10n.chorusHelp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingRow(
                label: l10n.chorusEnabled,
                control: Switch(
                  value: _chorusEnabled,
                  onChanged: (v) => setState(() => _chorusEnabled = v),
                ),
              ),
              SettingRow(
                label: l10n.chorusSandbox,
                description: l10n.chorusSandboxHelp,
                control: Switch(
                  value: _chorusSandbox,
                  onChanged: (v) => setState(() => _chorusSandbox = v),
                ),
              ),
              const SizedBox(height: VSpace.x2),
              grid([
                _field(('chorus_login', l10n.chorusLogin, null)),
                _field((
                  'chorus_password',
                  l10n.chorusPassword,
                  widget.settings.chorusConfigured
                      ? l10n.secretUnchanged
                      : null,
                ), secret: true),
                _field(('piste_client_id', l10n.pisteClientId, null)),
                _field((
                  'piste_client_secret',
                  l10n.pisteClientSecret,
                  widget.settings.chorusConfigured
                      ? l10n.secretUnchanged
                      : null,
                ), secret: true),
              ]),
              const SizedBox(height: VSpace.x2),
              Align(
                alignment: Alignment.centerLeft,
                child: VBadge(
                  widget.settings.chorusConfigured
                      ? l10n.chorusConfigured
                      : l10n.chorusNotConfigured,
                  tone: widget.settings.chorusConfigured
                      ? VTone.success
                      : VTone.neutral,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: VButton.primary(
            label: l10n.save,
            icon: LucideIcons.save,
            loading: _saving,
            onPressed: () => unawaited(_save()),
          ),
        ),
      ],
    );
  }
}
