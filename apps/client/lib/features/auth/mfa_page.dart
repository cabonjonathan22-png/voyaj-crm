import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import 'auth_layout.dart';
import 'auth_state.dart';

/// Seconde étape de connexion : code TOTP ou code de secours.
class MfaPage extends ConsumerStatefulWidget {
  const MfaPage({super.key});

  @override
  ConsumerState<MfaPage> createState() => _MfaPageState();
}

class _MfaPageState extends ConsumerState<MfaPage> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_code.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(authProvider.notifier).verifyMfa(_code.text);
    } on ApiFailure catch (e) {
      if (mounted) {
        setState(() => _error = e.message);
        _code.clear();
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = ref.watch(authProvider);
    return AuthLayout(
      title: l10n.mfaTitle,
      subtitle: l10n.mfaSubtitle,
      footer: Center(
        child: VButton.ghost(
          label: l10n.mfaBack,
          icon: LucideIcons.arrowLeft,
          onPressed: () => ref.read(authProvider.notifier).cancelMfa(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (auth is AuthMfaRequired) ...[
            Text(auth.email, style: context.text.bodyStrong),
            const SizedBox(height: VSpace.x3),
          ],
          VTextField(
            controller: _code,
            label: l10n.mfaCodeLabel,
            hint: '123 456',
            prefixIcon: LucideIcons.keyRound,
            autofocus: true,
            monospace: true,
            error: _error,
            autofillHints: const [AutofillHints.oneTimeCode],
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: VSpace.x4),
          VButton.primary(
            label: l10n.mfaVerify,
            loading: _busy,
            expand: true,
            size: VButtonSize.lg,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
