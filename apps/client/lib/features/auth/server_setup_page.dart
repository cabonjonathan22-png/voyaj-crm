import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import 'auth_layout.dart';

/// Premier lancement : adresse du serveur Voyaj.
class ServerSetupPage extends ConsumerStatefulWidget {
  const ServerSetupPage({super.key});

  @override
  ConsumerState<ServerSetupPage> createState() => _ServerSetupPageState();
}

class _ServerSetupPageState extends ConsumerState<ServerSetupPage> {
  late final _url = TextEditingController(
    text: ref.read(serverUrlProvider)?.toString() ?? 'http://localhost:8080',
  );
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final Uri uri;
    try {
      uri = ApiClient.normalizeServerUrl(_url.text);
    } on FormatException {
      setState(() => _error = l10n.setupInvalidUrl);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ApiClient.health(uri);
      await ref.read(authProvider.notifier).setServer(uri);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AuthLayout(
      title: l10n.setupTitle,
      subtitle: l10n.setupSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VTextField(
            controller: _url,
            label: l10n.setupUrlLabel,
            hint: l10n.setupUrlHint,
            prefixIcon: LucideIcons.server,
            error: _error,
            autofocus: true,
            keyboardType: TextInputType.url,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: VSpace.x4),
          VButton.primary(
            label: l10n.setupContinue,
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
