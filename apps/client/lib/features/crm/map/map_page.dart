import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/router.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';

/// Fonds de carte OpenStreetMap (désactivés dans les tests : pas de
/// réseau).
final mapTilesEnabledProvider = Provider<bool>((ref) => true);

/// Centre de la France métropolitaine.
const _france = LatLng(46.6, 2.4);

/// Carte des organisations (couleur = statut commercial).
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final Set<String> _hiddenStatuses = {};
  String? _kind;
  OrganisationRow? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final organisations = ref.watch(organisationsProvider).value ?? const [];
    final located = [
      for (final o in organisations)
        if (o.latitude != null && o.longitude != null) o,
    ];
    final shown = [
      for (final o in located)
        if (!_hiddenStatuses.contains(o.status) &&
            (_kind == null || o.kind == _kind))
          o,
    ];
    final counts = <String, int>{};
    for (final o in located) {
      counts.update(o.status, (n) => n + 1, ifAbsent: () => 1);
    }
    final points = [for (final o in shown) LatLng(o.latitude!, o.longitude!)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navMap,
          subtitle: l10n.mapSubtitle(
            shown.length,
            organisations.length - located.length,
          ),
          icon: LucideIcons.map,
          actions: [
            VSelect<String?>(
              value: _kind,
              width: 240,
              options: [
                VSelectOption(null, l10n.mapAllKinds),
                for (final k in OrganisationKind.values)
                  VSelectOption(k.key, k.label, icon: kindIcon(k)),
              ],
              onChanged: (v) => setState(() => _kind = v),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VSpace.x6,
            vertical: VSpace.x2,
          ),
          child: Wrap(
            spacing: VSpace.x2,
            runSpacing: VSpace.x1_5,
            children: [
              for (final status in OrganisationStatus.values)
                Opacity(
                  opacity: _hiddenStatuses.contains(status.key) ? 0.4 : 1,
                  child: VChip(
                    '${status.label} (${counts[status.key] ?? 0})',
                    color: c.toneColor(statusTone(status)),
                    onPressed: () => setState(() {
                      if (!_hiddenStatuses.remove(status.key)) {
                        _hiddenStatuses.add(status.key);
                      }
                    }),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ClipRect(
            child: Stack(
              children: [
                FlutterMap(
                  key: ValueKey(_kind),
                  options: MapOptions(
                    initialCenter: _france,
                    initialZoom: 5.5,
                    minZoom: 3,
                    maxZoom: 18,
                    initialCameraFit: points.length > 1
                        ? CameraFit.bounds(
                            bounds: LatLngBounds.fromPoints(points),
                            padding: const EdgeInsets.all(48),
                            maxZoom: 12,
                          )
                        : null,
                    backgroundColor: c.backgroundSubtle,
                    onTap: (_, _) => setState(() => _selected = null),
                  ),
                  children: [
                    if (ref.watch(mapTilesEnabledProvider))
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'fr.voyaj.crm',
                      ),
                    MarkerLayer(
                      markers: [
                        for (final o in shown)
                          Marker(
                            point: LatLng(o.latitude!, o.longitude!),
                            width: 18,
                            height: 18,
                            child: _Pin(
                              color: c.toneColor(
                                statusTone(
                                  enumByKey(
                                    OrganisationStatus.values,
                                    o.status,
                                  ),
                                ),
                              ),
                              selected: _selected?.id == o.id,
                              label: o.name,
                              onTap: () => setState(() => _selected = o),
                            ),
                          ),
                      ],
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap',
                          onTap: () => unawaited(
                            launchUrl(
                              Uri.parse(
                                'https://www.openstreetmap.org/copyright',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_selected != null)
                  Positioned(
                    left: VSpace.x4,
                    bottom: VSpace.x4,
                    width: 320,
                    child: VCard(
                      title: _selected!.name,
                      description: [
                        enumByKey(
                          OrganisationKind.values,
                          _selected!.kind,
                        )?.label,
                        _selected!.city,
                      ].whereType<String>().join(' · '),
                      actions: [
                        VIconButton(
                          icon: LucideIcons.x,
                          tooltip: l10n.close,
                          size: VButtonSize.sm,
                          onPressed: () => setState(() => _selected = null),
                        ),
                      ],
                      child: Row(
                        children: [
                          VBadge(
                            enumByKey(
                                  OrganisationStatus.values,
                                  _selected!.status,
                                )?.label ??
                                _selected!.status,
                            tone: statusTone(
                              enumByKey(
                                OrganisationStatus.values,
                                _selected!.status,
                              ),
                            ),
                          ),
                          const Spacer(),
                          VButton.primary(
                            label: l10n.open,
                            icon: LucideIcons.externalLink,
                            size: VButtonSize.sm,
                            onPressed: () => context.go(
                              '${Routes.organisations}/${_selected!.id}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (located.isEmpty)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(VSpace.x4),
                      decoration: BoxDecoration(
                        color: c.surfaceRaised,
                        borderRadius: VRadius.mdAll,
                        border: Border.all(color: c.border),
                      ),
                      child: Text(l10n.mapEmpty, style: t.body),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin({
    required this.color,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Tooltip(
      message: label,
      child: Pressable(
        onPressed: onTap,
        semanticLabel: label,
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected || s.hovered ? c.text : c.surface,
              width: selected ? 3 : 2,
            ),
            boxShadow: VShadows.sm(dark: c.isDark),
          ),
        ),
      ),
    );
  }
}
