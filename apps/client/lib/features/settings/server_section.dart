import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import '../auth/auth_controller.dart';
import 'settings_page.dart';

final _healthProvider = FutureProvider.autoDispose<Map<String, dynamic>?>((
  ref,
) async {
  final url = ref.watch(serverUrlProvider);
  if (url == null) return null;
  return ApiClient.health(url);
});

class ServerSection extends ConsumerWidget {
  const ServerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final url = ref.watch(serverUrlProvider);
    final health = ref.watch(_healthProvider);
    final clock = ref.watch(localClockProvider);

    return SettingsScroll(
      children: [
        VCard(
          title: l10n.serverTitle,
          description: l10n.serverDescription,
          child: Column(
            children: [
              SettingRow(
                label: l10n.serverAddress,
                description: url?.toString(),
                control: VButton(
                  label: l10n.changeServer,
                  icon: LucideIcons.arrowLeftRight,
                  onPressed: () async {
                    final ok = await confirm(
                      context,
                      title: l10n.changeServer,
                      message: l10n.changeServerMessage,
                      confirmLabel: l10n.changeServer,
                    );
                    if (ok) {
                      await ref.read(authProvider.notifier).changeServer();
                    }
                  },
                ),
              ),
              SettingRow(
                label: l10n.serverStatus,
                description: switch (health) {
                  AsyncData(:final value) => l10n.serverVersion(
                    '${value?['version'] ?? '?'}',
                  ),
                  AsyncError(:final error) =>
                    error is ApiFailure ? error.message : l10n.genericError,
                  _ => '…',
                },
                control: switch (health) {
                  AsyncData() => VBadge(l10n.syncOnline, tone: VTone.success),
                  AsyncError() => VBadge(l10n.syncOffline, tone: VTone.danger),
                  _ => const VSpinner(size: 14),
                },
              ),
            ],
          ),
        ),
        VCard(
          title: l10n.deviceTitle,
          description: l10n.deviceDescription,
          child: Column(
            children: [
              SettingRow(
                label: l10n.deviceId,
                control: SelectableText(
                  clock.deviceId,
                  style: context.text.mono,
                ),
              ),
              SettingRow(
                label: l10n.appVersionLabel,
                control: Text(appVersion, style: context.text.body),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
