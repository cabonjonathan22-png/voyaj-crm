import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import 'auth_layout.dart';
import 'auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();
  bool _obscure = true;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = context.l10n.loginMissingFields);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(authProvider.notifier).login(_email.text, _password.text);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final auth = ref.watch(authProvider);
    final server = ref.watch(serverUrlProvider);
    final notice = auth is AuthSignedOut ? auth.message : null;

    return AuthLayout(
      title: l10n.loginTitle,
      subtitle: l10n.loginSubtitle,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.server, size: 13, color: c.textSubtle),
          const SizedBox(width: VSpace.x1_5),
          Flexible(
            child: Text(
              server?.toString() ?? '',
              overflow: TextOverflow.ellipsis,
              style: context.text.small.copyWith(color: c.textSubtle),
            ),
          ),
          const SizedBox(width: VSpace.x2),
          VButton.ghost(
            label: l10n.changeServer,
            size: VButtonSize.sm,
            onPressed: () => ref.read(authProvider.notifier).changeServer(),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (notice != null) ...[
              VBanner(
                message: notice,
                tone: VTone.warning,
                icon: LucideIcons.info,
              ),
              const SizedBox(height: VSpace.x4),
            ],
            VTextField(
              controller: _email,
              label: l10n.emailLabel,
              hint: 'prenom.nom@exemple.fr',
              prefixIcon: LucideIcons.mail,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: VSpace.x3),
            VTextField(
              controller: _password,
              focusNode: _passwordFocus,
              label: l10n.passwordLabel,
              prefixIcon: LucideIcons.lock,
              obscure: _obscure,
              autofillHints: const [AutofillHints.password],
              error: _error,
              onSubmitted: (_) => _submit(),
              suffix: VIconButton(
                icon: _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                size: VButtonSize.sm,
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            const SizedBox(height: VSpace.x5),
            VButton.primary(
              label: l10n.loginButton,
              loading: _busy,
              expand: true,
              size: VButtonSize.lg,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
