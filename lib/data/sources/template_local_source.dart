import 'package:sqflite/sqflite.dart';

import '../models/template_item.dart';
import '../storage/app_database.dart';

class TemplateLocalSource {
  final AppDatabase appDatabase;

  TemplateLocalSource({required this.appDatabase});

  Future<void> upsertTemplates(List<TemplateItem> items) async {
    if (items.isEmpty) return;
    final db = await appDatabase.database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final item in items) {
        batch.insert(
          'templates',
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  Future<List<TemplateItem>> getTemplates({required int offset, required int limit}) async {
    final db = await appDatabase.database;
    final rows = await db.query(
      'templates',
      limit: limit,
      offset: offset,
      orderBy: 'rowid ASC',
    );
    return rows.map(TemplateItem.fromMap).toList();
  }

  Future<void> clearTemplates() async {
    final db = await appDatabase.database;
    await db.delete('templates');
  }
}
