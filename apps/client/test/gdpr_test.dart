import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/features/admin/gdpr_page.dart';

import 'support/crm_seed.dart';

void main() {
  test('contacts sans contact depuis N mois', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await seedCrm(db);
    final contacts = await db.select(db.contacts).get();
    final activities = await db.select(db.activities).get();
    final now = DateTime.now();

    // Fiches récentes : rien à réexaminer.
    expect(
      inactiveContacts(
        contacts: contacts,
        activities: activities,
        months: 12,
        now: now,
      ),
      isEmpty,
    );
    // Dans 4 ans, toutes les fiches sont anciennes.
    final later = inactiveContacts(
      contacts: contacts,
      activities: activities,
      months: 36,
      now: now.add(const Duration(days: 4 * 365)),
    );
    expect(later, hasLength(contacts.length));
    // La plus ancienne d'abord ; un contact avec une activité récente est
    // plus loin dans la liste.
    final ct1 = later.indexWhere((e) => e.contact.id == sid('ct-1'));
    expect(later[ct1].lastTouch.isAfter(later.first.lastTouch), isTrue);
  });
}
