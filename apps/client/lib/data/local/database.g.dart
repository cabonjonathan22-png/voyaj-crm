// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TagsTable extends Tags with TableInfo<$TagsTable, TagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    color,
    description,
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagRow extends DataClass implements Insertable<TagRow> {
  final String id;
  final String name;
  final String color;
  final String? description;
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  const TagRow({
    required this.id,
    required this.name,
    required this.color,
    this.description,
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      description: serializer.fromJson<String?>(json['description']),
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'description': serializer.toJson<String?>(description),
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TagRow copyWith({
    String? id,
    String? name,
    String? color,
    Value<String?> description = const Value.absent(),
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TagRow(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    description: description.present ? description.value : this.description,
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TagRow copyWithCompanion(TagsCompanion data) {
    return TagRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      description: data.description.present
          ? data.description.value
          : this.description,
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    color,
    description,
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.description == this.description &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt);
}

class TagsCompanion extends UpdateCompanion<TagRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  final Value<String?> description;
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.description = const Value.absent(),
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String name,
    required String color,
    this.description = const Value.absent(),
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       color = Value(color),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TagRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? description,
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (description != null) 'description': description,
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? color,
    Value<String?>? description,
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrganisationsTable extends Organisations
    with TableInfo<$OrganisationsTable, OrganisationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganisationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _collectedAtMeta = const VerificationMeta(
    'collectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> collectedAt = GeneratedColumn<DateTime>(
    'collected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sirenMeta = const VerificationMeta('siren');
  @override
  late final GeneratedColumn<String> siren = GeneratedColumn<String>(
    'siren',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _siretMeta = const VerificationMeta('siret');
  @override
  late final GeneratedColumn<String> siret = GeneratedColumn<String>(
    'siret',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inseeCodeMeta = const VerificationMeta(
    'inseeCode',
  );
  @override
  late final GeneratedColumn<String> inseeCode = GeneratedColumn<String>(
    'insee_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _populationMeta = const VerificationMeta(
    'population',
  );
  @override
  late final GeneratedColumn<int> population = GeneratedColumn<int>(
    'population',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departementCodeMeta = const VerificationMeta(
    'departementCode',
  );
  @override
  late final GeneratedColumn<String> departementCode = GeneratedColumn<String>(
    'departement_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionCodeMeta = const VerificationMeta(
    'regionCode',
  );
  @override
  late final GeneratedColumn<String> regionCode = GeneratedColumn<String>(
    'region_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFieldsMeta = const VerificationMeta(
    'customFields',
  );
  @override
  late final GeneratedColumn<String> customFields = GeneratedColumn<String>(
    'custom_fields',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    name,
    kind,
    status,
    siren,
    siret,
    inseeCode,
    population,
    parentId,
    departementCode,
    regionCode,
    address,
    postalCode,
    city,
    latitude,
    longitude,
    phone,
    email,
    website,
    description,
    ownerId,
    customFields,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organisations';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrganisationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('collected_at')) {
      context.handle(
        _collectedAtMeta,
        collectedAt.isAcceptableOrUnknown(
          data['collected_at']!,
          _collectedAtMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('siren')) {
      context.handle(
        _sirenMeta,
        siren.isAcceptableOrUnknown(data['siren']!, _sirenMeta),
      );
    }
    if (data.containsKey('siret')) {
      context.handle(
        _siretMeta,
        siret.isAcceptableOrUnknown(data['siret']!, _siretMeta),
      );
    }
    if (data.containsKey('insee_code')) {
      context.handle(
        _inseeCodeMeta,
        inseeCode.isAcceptableOrUnknown(data['insee_code']!, _inseeCodeMeta),
      );
    }
    if (data.containsKey('population')) {
      context.handle(
        _populationMeta,
        population.isAcceptableOrUnknown(data['population']!, _populationMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('departement_code')) {
      context.handle(
        _departementCodeMeta,
        departementCode.isAcceptableOrUnknown(
          data['departement_code']!,
          _departementCodeMeta,
        ),
      );
    }
    if (data.containsKey('region_code')) {
      context.handle(
        _regionCodeMeta,
        regionCode.isAcceptableOrUnknown(data['region_code']!, _regionCodeMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('custom_fields')) {
      context.handle(
        _customFieldsMeta,
        customFields.isAcceptableOrUnknown(
          data['custom_fields']!,
          _customFieldsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrganisationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrganisationRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      collectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}collected_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      siren: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}siren'],
      ),
      siret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}siret'],
      ),
      inseeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insee_code'],
      ),
      population: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}population'],
      ),
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      departementCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departement_code'],
      ),
      regionCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_code'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      customFields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fields'],
      ),
    );
  }

  @override
  $OrganisationsTable createAlias(String alias) {
    return $OrganisationsTable(attachedDatabase, alias);
  }
}

class OrganisationRow extends DataClass implements Insertable<OrganisationRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? source;
  final String? sourceRef;
  final DateTime? collectedAt;
  final String id;
  final String name;
  final String kind;
  final String status;
  final String? siren;
  final String? siret;
  final String? inseeCode;
  final int? population;
  final String? parentId;
  final String? departementCode;
  final String? regionCode;
  final String? address;
  final String? postalCode;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? email;
  final String? website;
  final String? description;
  final String? ownerId;
  final String? customFields;
  const OrganisationRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.source,
    this.sourceRef,
    this.collectedAt,
    required this.id,
    required this.name,
    required this.kind,
    required this.status,
    this.siren,
    this.siret,
    this.inseeCode,
    this.population,
    this.parentId,
    this.departementCode,
    this.regionCode,
    this.address,
    this.postalCode,
    this.city,
    this.latitude,
    this.longitude,
    this.phone,
    this.email,
    this.website,
    this.description,
    this.ownerId,
    this.customFields,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    if (!nullToAbsent || collectedAt != null) {
      map['collected_at'] = Variable<DateTime>(collectedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || siren != null) {
      map['siren'] = Variable<String>(siren);
    }
    if (!nullToAbsent || siret != null) {
      map['siret'] = Variable<String>(siret);
    }
    if (!nullToAbsent || inseeCode != null) {
      map['insee_code'] = Variable<String>(inseeCode);
    }
    if (!nullToAbsent || population != null) {
      map['population'] = Variable<int>(population);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || departementCode != null) {
      map['departement_code'] = Variable<String>(departementCode);
    }
    if (!nullToAbsent || regionCode != null) {
      map['region_code'] = Variable<String>(regionCode);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || customFields != null) {
      map['custom_fields'] = Variable<String>(customFields);
    }
    return map;
  }

  OrganisationsCompanion toCompanion(bool nullToAbsent) {
    return OrganisationsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      collectedAt: collectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(collectedAt),
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      status: Value(status),
      siren: siren == null && nullToAbsent
          ? const Value.absent()
          : Value(siren),
      siret: siret == null && nullToAbsent
          ? const Value.absent()
          : Value(siret),
      inseeCode: inseeCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inseeCode),
      population: population == null && nullToAbsent
          ? const Value.absent()
          : Value(population),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      departementCode: departementCode == null && nullToAbsent
          ? const Value.absent()
          : Value(departementCode),
      regionCode: regionCode == null && nullToAbsent
          ? const Value.absent()
          : Value(regionCode),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      customFields: customFields == null && nullToAbsent
          ? const Value.absent()
          : Value(customFields),
    );
  }

  factory OrganisationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrganisationRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      source: serializer.fromJson<String?>(json['source']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      collectedAt: serializer.fromJson<DateTime?>(json['collectedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      status: serializer.fromJson<String>(json['status']),
      siren: serializer.fromJson<String?>(json['siren']),
      siret: serializer.fromJson<String?>(json['siret']),
      inseeCode: serializer.fromJson<String?>(json['inseeCode']),
      population: serializer.fromJson<int?>(json['population']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      departementCode: serializer.fromJson<String?>(json['departementCode']),
      regionCode: serializer.fromJson<String?>(json['regionCode']),
      address: serializer.fromJson<String?>(json['address']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      city: serializer.fromJson<String?>(json['city']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      description: serializer.fromJson<String?>(json['description']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      customFields: serializer.fromJson<String?>(json['customFields']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'source': serializer.toJson<String?>(source),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'collectedAt': serializer.toJson<DateTime?>(collectedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'status': serializer.toJson<String>(status),
      'siren': serializer.toJson<String?>(siren),
      'siret': serializer.toJson<String?>(siret),
      'inseeCode': serializer.toJson<String?>(inseeCode),
      'population': serializer.toJson<int?>(population),
      'parentId': serializer.toJson<String?>(parentId),
      'departementCode': serializer.toJson<String?>(departementCode),
      'regionCode': serializer.toJson<String?>(regionCode),
      'address': serializer.toJson<String?>(address),
      'postalCode': serializer.toJson<String?>(postalCode),
      'city': serializer.toJson<String?>(city),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'description': serializer.toJson<String?>(description),
      'ownerId': serializer.toJson<String?>(ownerId),
      'customFields': serializer.toJson<String?>(customFields),
    };
  }

  OrganisationRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> sourceRef = const Value.absent(),
    Value<DateTime?> collectedAt = const Value.absent(),
    String? id,
    String? name,
    String? kind,
    String? status,
    Value<String?> siren = const Value.absent(),
    Value<String?> siret = const Value.absent(),
    Value<String?> inseeCode = const Value.absent(),
    Value<int?> population = const Value.absent(),
    Value<String?> parentId = const Value.absent(),
    Value<String?> departementCode = const Value.absent(),
    Value<String?> regionCode = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
    Value<String?> customFields = const Value.absent(),
  }) => OrganisationRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    source: source.present ? source.value : this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    collectedAt: collectedAt.present ? collectedAt.value : this.collectedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    status: status ?? this.status,
    siren: siren.present ? siren.value : this.siren,
    siret: siret.present ? siret.value : this.siret,
    inseeCode: inseeCode.present ? inseeCode.value : this.inseeCode,
    population: population.present ? population.value : this.population,
    parentId: parentId.present ? parentId.value : this.parentId,
    departementCode: departementCode.present
        ? departementCode.value
        : this.departementCode,
    regionCode: regionCode.present ? regionCode.value : this.regionCode,
    address: address.present ? address.value : this.address,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    city: city.present ? city.value : this.city,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    website: website.present ? website.value : this.website,
    description: description.present ? description.value : this.description,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    customFields: customFields.present ? customFields.value : this.customFields,
  );
  OrganisationRow copyWithCompanion(OrganisationsCompanion data) {
    return OrganisationRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      collectedAt: data.collectedAt.present
          ? data.collectedAt.value
          : this.collectedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      status: data.status.present ? data.status.value : this.status,
      siren: data.siren.present ? data.siren.value : this.siren,
      siret: data.siret.present ? data.siret.value : this.siret,
      inseeCode: data.inseeCode.present ? data.inseeCode.value : this.inseeCode,
      population: data.population.present
          ? data.population.value
          : this.population,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      departementCode: data.departementCode.present
          ? data.departementCode.value
          : this.departementCode,
      regionCode: data.regionCode.present
          ? data.regionCode.value
          : this.regionCode,
      address: data.address.present ? data.address.value : this.address,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      description: data.description.present
          ? data.description.value
          : this.description,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      customFields: data.customFields.present
          ? data.customFields.value
          : this.customFields,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrganisationRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('siren: $siren, ')
          ..write('siret: $siret, ')
          ..write('inseeCode: $inseeCode, ')
          ..write('population: $population, ')
          ..write('parentId: $parentId, ')
          ..write('departementCode: $departementCode, ')
          ..write('regionCode: $regionCode, ')
          ..write('address: $address, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('description: $description, ')
          ..write('ownerId: $ownerId, ')
          ..write('customFields: $customFields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    name,
    kind,
    status,
    siren,
    siret,
    inseeCode,
    population,
    parentId,
    departementCode,
    regionCode,
    address,
    postalCode,
    city,
    latitude,
    longitude,
    phone,
    email,
    website,
    description,
    ownerId,
    customFields,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganisationRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.collectedAt == this.collectedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.status == this.status &&
          other.siren == this.siren &&
          other.siret == this.siret &&
          other.inseeCode == this.inseeCode &&
          other.population == this.population &&
          other.parentId == this.parentId &&
          other.departementCode == this.departementCode &&
          other.regionCode == this.regionCode &&
          other.address == this.address &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.website == this.website &&
          other.description == this.description &&
          other.ownerId == this.ownerId &&
          other.customFields == this.customFields);
}

class OrganisationsCompanion extends UpdateCompanion<OrganisationRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String?> source;
  final Value<String?> sourceRef;
  final Value<DateTime?> collectedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> status;
  final Value<String?> siren;
  final Value<String?> siret;
  final Value<String?> inseeCode;
  final Value<int?> population;
  final Value<String?> parentId;
  final Value<String?> departementCode;
  final Value<String?> regionCode;
  final Value<String?> address;
  final Value<String?> postalCode;
  final Value<String?> city;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> website;
  final Value<String?> description;
  final Value<String?> ownerId;
  final Value<String?> customFields;
  final Value<int> rowid;
  const OrganisationsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.status = const Value.absent(),
    this.siren = const Value.absent(),
    this.siret = const Value.absent(),
    this.inseeCode = const Value.absent(),
    this.population = const Value.absent(),
    this.parentId = const Value.absent(),
    this.departementCode = const Value.absent(),
    this.regionCode = const Value.absent(),
    this.address = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.description = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganisationsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    required String id,
    required String name,
    required String kind,
    required String status,
    this.siren = const Value.absent(),
    this.siret = const Value.absent(),
    this.inseeCode = const Value.absent(),
    this.population = const Value.absent(),
    this.parentId = const Value.absent(),
    this.departementCode = const Value.absent(),
    this.regionCode = const Value.absent(),
    this.address = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.description = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       kind = Value(kind),
       status = Value(status);
  static Insertable<OrganisationRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? source,
    Expression<String>? sourceRef,
    Expression<DateTime>? collectedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? status,
    Expression<String>? siren,
    Expression<String>? siret,
    Expression<String>? inseeCode,
    Expression<int>? population,
    Expression<String>? parentId,
    Expression<String>? departementCode,
    Expression<String>? regionCode,
    Expression<String>? address,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? website,
    Expression<String>? description,
    Expression<String>? ownerId,
    Expression<String>? customFields,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (collectedAt != null) 'collected_at': collectedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (status != null) 'status': status,
      if (siren != null) 'siren': siren,
      if (siret != null) 'siret': siret,
      if (inseeCode != null) 'insee_code': inseeCode,
      if (population != null) 'population': population,
      if (parentId != null) 'parent_id': parentId,
      if (departementCode != null) 'departement_code': departementCode,
      if (regionCode != null) 'region_code': regionCode,
      if (address != null) 'address': address,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (description != null) 'description': description,
      if (ownerId != null) 'owner_id': ownerId,
      if (customFields != null) 'custom_fields': customFields,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganisationsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String?>? source,
    Value<String?>? sourceRef,
    Value<DateTime?>? collectedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? status,
    Value<String?>? siren,
    Value<String?>? siret,
    Value<String?>? inseeCode,
    Value<int?>? population,
    Value<String?>? parentId,
    Value<String?>? departementCode,
    Value<String?>? regionCode,
    Value<String?>? address,
    Value<String?>? postalCode,
    Value<String?>? city,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? website,
    Value<String?>? description,
    Value<String?>? ownerId,
    Value<String?>? customFields,
    Value<int>? rowid,
  }) {
    return OrganisationsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      collectedAt: collectedAt ?? this.collectedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      siren: siren ?? this.siren,
      siret: siret ?? this.siret,
      inseeCode: inseeCode ?? this.inseeCode,
      population: population ?? this.population,
      parentId: parentId ?? this.parentId,
      departementCode: departementCode ?? this.departementCode,
      regionCode: regionCode ?? this.regionCode,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      customFields: customFields ?? this.customFields,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (collectedAt.present) {
      map['collected_at'] = Variable<DateTime>(collectedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (siren.present) {
      map['siren'] = Variable<String>(siren.value);
    }
    if (siret.present) {
      map['siret'] = Variable<String>(siret.value);
    }
    if (inseeCode.present) {
      map['insee_code'] = Variable<String>(inseeCode.value);
    }
    if (population.present) {
      map['population'] = Variable<int>(population.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (departementCode.present) {
      map['departement_code'] = Variable<String>(departementCode.value);
    }
    if (regionCode.present) {
      map['region_code'] = Variable<String>(regionCode.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (customFields.present) {
      map['custom_fields'] = Variable<String>(customFields.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganisationsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('siren: $siren, ')
          ..write('siret: $siret, ')
          ..write('inseeCode: $inseeCode, ')
          ..write('population: $population, ')
          ..write('parentId: $parentId, ')
          ..write('departementCode: $departementCode, ')
          ..write('regionCode: $regionCode, ')
          ..write('address: $address, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('description: $description, ')
          ..write('ownerId: $ownerId, ')
          ..write('customFields: $customFields, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _collectedAtMeta = const VerificationMeta(
    'collectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> collectedAt = GeneratedColumn<DateTime>(
    'collected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _civilityMeta = const VerificationMeta(
    'civility',
  );
  @override
  late final GeneratedColumn<String> civility = GeneratedColumn<String>(
    'civility',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jobTitleMeta = const VerificationMeta(
    'jobTitle',
  );
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
    'job_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceMeta = const VerificationMeta(
    'service',
  );
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
    'service',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doNotContactMeta = const VerificationMeta(
    'doNotContact',
  );
  @override
  late final GeneratedColumn<bool> doNotContact = GeneratedColumn<bool>(
    'do_not_contact',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("do_not_contact" IN (0, 1))',
    ),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFieldsMeta = const VerificationMeta(
    'customFields',
  );
  @override
  late final GeneratedColumn<String> customFields = GeneratedColumn<String>(
    'custom_fields',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    civility,
    firstName,
    lastName,
    email,
    phone,
    mobile,
    organisationId,
    jobTitle,
    service,
    notes,
    doNotContact,
    ownerId,
    customFields,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('collected_at')) {
      context.handle(
        _collectedAtMeta,
        collectedAt.isAcceptableOrUnknown(
          data['collected_at']!,
          _collectedAtMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('civility')) {
      context.handle(
        _civilityMeta,
        civility.isAcceptableOrUnknown(data['civility']!, _civilityMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    }
    if (data.containsKey('job_title')) {
      context.handle(
        _jobTitleMeta,
        jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta),
      );
    }
    if (data.containsKey('service')) {
      context.handle(
        _serviceMeta,
        service.isAcceptableOrUnknown(data['service']!, _serviceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('do_not_contact')) {
      context.handle(
        _doNotContactMeta,
        doNotContact.isAcceptableOrUnknown(
          data['do_not_contact']!,
          _doNotContactMeta,
        ),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('custom_fields')) {
      context.handle(
        _customFieldsMeta,
        customFields.isAcceptableOrUnknown(
          data['custom_fields']!,
          _customFieldsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      collectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}collected_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      civility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}civility'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      ),
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      ),
      jobTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_title'],
      ),
      service: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      doNotContact: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}do_not_contact'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      customFields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fields'],
      ),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactRow extends DataClass implements Insertable<ContactRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? source;
  final String? sourceRef;
  final DateTime? collectedAt;
  final String id;
  final String? civility;
  final String? firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? organisationId;
  final String? jobTitle;
  final String? service;
  final String? notes;
  final bool? doNotContact;
  final String? ownerId;
  final String? customFields;
  const ContactRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.source,
    this.sourceRef,
    this.collectedAt,
    required this.id,
    this.civility,
    this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.mobile,
    this.organisationId,
    this.jobTitle,
    this.service,
    this.notes,
    this.doNotContact,
    this.ownerId,
    this.customFields,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    if (!nullToAbsent || collectedAt != null) {
      map['collected_at'] = Variable<DateTime>(collectedAt);
    }
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || civility != null) {
      map['civility'] = Variable<String>(civility);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || organisationId != null) {
      map['organisation_id'] = Variable<String>(organisationId);
    }
    if (!nullToAbsent || jobTitle != null) {
      map['job_title'] = Variable<String>(jobTitle);
    }
    if (!nullToAbsent || service != null) {
      map['service'] = Variable<String>(service);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || doNotContact != null) {
      map['do_not_contact'] = Variable<bool>(doNotContact);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || customFields != null) {
      map['custom_fields'] = Variable<String>(customFields);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      collectedAt: collectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(collectedAt),
      id: Value(id),
      civility: civility == null && nullToAbsent
          ? const Value.absent()
          : Value(civility),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: Value(lastName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      mobile: mobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mobile),
      organisationId: organisationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organisationId),
      jobTitle: jobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(jobTitle),
      service: service == null && nullToAbsent
          ? const Value.absent()
          : Value(service),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      doNotContact: doNotContact == null && nullToAbsent
          ? const Value.absent()
          : Value(doNotContact),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      customFields: customFields == null && nullToAbsent
          ? const Value.absent()
          : Value(customFields),
    );
  }

  factory ContactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      source: serializer.fromJson<String?>(json['source']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      collectedAt: serializer.fromJson<DateTime?>(json['collectedAt']),
      id: serializer.fromJson<String>(json['id']),
      civility: serializer.fromJson<String?>(json['civility']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      organisationId: serializer.fromJson<String?>(json['organisationId']),
      jobTitle: serializer.fromJson<String?>(json['jobTitle']),
      service: serializer.fromJson<String?>(json['service']),
      notes: serializer.fromJson<String?>(json['notes']),
      doNotContact: serializer.fromJson<bool?>(json['doNotContact']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      customFields: serializer.fromJson<String?>(json['customFields']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'source': serializer.toJson<String?>(source),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'collectedAt': serializer.toJson<DateTime?>(collectedAt),
      'id': serializer.toJson<String>(id),
      'civility': serializer.toJson<String?>(civility),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'mobile': serializer.toJson<String?>(mobile),
      'organisationId': serializer.toJson<String?>(organisationId),
      'jobTitle': serializer.toJson<String?>(jobTitle),
      'service': serializer.toJson<String?>(service),
      'notes': serializer.toJson<String?>(notes),
      'doNotContact': serializer.toJson<bool?>(doNotContact),
      'ownerId': serializer.toJson<String?>(ownerId),
      'customFields': serializer.toJson<String?>(customFields),
    };
  }

  ContactRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> sourceRef = const Value.absent(),
    Value<DateTime?> collectedAt = const Value.absent(),
    String? id,
    Value<String?> civility = const Value.absent(),
    Value<String?> firstName = const Value.absent(),
    String? lastName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> mobile = const Value.absent(),
    Value<String?> organisationId = const Value.absent(),
    Value<String?> jobTitle = const Value.absent(),
    Value<String?> service = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<bool?> doNotContact = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
    Value<String?> customFields = const Value.absent(),
  }) => ContactRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    source: source.present ? source.value : this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    collectedAt: collectedAt.present ? collectedAt.value : this.collectedAt,
    id: id ?? this.id,
    civility: civility.present ? civility.value : this.civility,
    firstName: firstName.present ? firstName.value : this.firstName,
    lastName: lastName ?? this.lastName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    mobile: mobile.present ? mobile.value : this.mobile,
    organisationId: organisationId.present
        ? organisationId.value
        : this.organisationId,
    jobTitle: jobTitle.present ? jobTitle.value : this.jobTitle,
    service: service.present ? service.value : this.service,
    notes: notes.present ? notes.value : this.notes,
    doNotContact: doNotContact.present ? doNotContact.value : this.doNotContact,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    customFields: customFields.present ? customFields.value : this.customFields,
  );
  ContactRow copyWithCompanion(ContactsCompanion data) {
    return ContactRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      collectedAt: data.collectedAt.present
          ? data.collectedAt.value
          : this.collectedAt,
      id: data.id.present ? data.id.value : this.id,
      civility: data.civility.present ? data.civility.value : this.civility,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      service: data.service.present ? data.service.value : this.service,
      notes: data.notes.present ? data.notes.value : this.notes,
      doNotContact: data.doNotContact.present
          ? data.doNotContact.value
          : this.doNotContact,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      customFields: data.customFields.present
          ? data.customFields.value
          : this.customFields,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('civility: $civility, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('mobile: $mobile, ')
          ..write('organisationId: $organisationId, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('service: $service, ')
          ..write('notes: $notes, ')
          ..write('doNotContact: $doNotContact, ')
          ..write('ownerId: $ownerId, ')
          ..write('customFields: $customFields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    civility,
    firstName,
    lastName,
    email,
    phone,
    mobile,
    organisationId,
    jobTitle,
    service,
    notes,
    doNotContact,
    ownerId,
    customFields,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.collectedAt == this.collectedAt &&
          other.id == this.id &&
          other.civility == this.civility &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.mobile == this.mobile &&
          other.organisationId == this.organisationId &&
          other.jobTitle == this.jobTitle &&
          other.service == this.service &&
          other.notes == this.notes &&
          other.doNotContact == this.doNotContact &&
          other.ownerId == this.ownerId &&
          other.customFields == this.customFields);
}

class ContactsCompanion extends UpdateCompanion<ContactRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String?> source;
  final Value<String?> sourceRef;
  final Value<DateTime?> collectedAt;
  final Value<String> id;
  final Value<String?> civility;
  final Value<String?> firstName;
  final Value<String> lastName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> mobile;
  final Value<String?> organisationId;
  final Value<String?> jobTitle;
  final Value<String?> service;
  final Value<String?> notes;
  final Value<bool?> doNotContact;
  final Value<String?> ownerId;
  final Value<String?> customFields;
  final Value<int> rowid;
  const ContactsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.civility = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.mobile = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.service = const Value.absent(),
    this.notes = const Value.absent(),
    this.doNotContact = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    required String id,
    this.civility = const Value.absent(),
    this.firstName = const Value.absent(),
    required String lastName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.mobile = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.service = const Value.absent(),
    this.notes = const Value.absent(),
    this.doNotContact = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       lastName = Value(lastName);
  static Insertable<ContactRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? source,
    Expression<String>? sourceRef,
    Expression<DateTime>? collectedAt,
    Expression<String>? id,
    Expression<String>? civility,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? mobile,
    Expression<String>? organisationId,
    Expression<String>? jobTitle,
    Expression<String>? service,
    Expression<String>? notes,
    Expression<bool>? doNotContact,
    Expression<String>? ownerId,
    Expression<String>? customFields,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (collectedAt != null) 'collected_at': collectedAt,
      if (id != null) 'id': id,
      if (civility != null) 'civility': civility,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (mobile != null) 'mobile': mobile,
      if (organisationId != null) 'organisation_id': organisationId,
      if (jobTitle != null) 'job_title': jobTitle,
      if (service != null) 'service': service,
      if (notes != null) 'notes': notes,
      if (doNotContact != null) 'do_not_contact': doNotContact,
      if (ownerId != null) 'owner_id': ownerId,
      if (customFields != null) 'custom_fields': customFields,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String?>? source,
    Value<String?>? sourceRef,
    Value<DateTime?>? collectedAt,
    Value<String>? id,
    Value<String?>? civility,
    Value<String?>? firstName,
    Value<String>? lastName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? mobile,
    Value<String?>? organisationId,
    Value<String?>? jobTitle,
    Value<String?>? service,
    Value<String?>? notes,
    Value<bool?>? doNotContact,
    Value<String?>? ownerId,
    Value<String?>? customFields,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      collectedAt: collectedAt ?? this.collectedAt,
      id: id ?? this.id,
      civility: civility ?? this.civility,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      organisationId: organisationId ?? this.organisationId,
      jobTitle: jobTitle ?? this.jobTitle,
      service: service ?? this.service,
      notes: notes ?? this.notes,
      doNotContact: doNotContact ?? this.doNotContact,
      ownerId: ownerId ?? this.ownerId,
      customFields: customFields ?? this.customFields,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (collectedAt.present) {
      map['collected_at'] = Variable<DateTime>(collectedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (civility.present) {
      map['civility'] = Variable<String>(civility.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (doNotContact.present) {
      map['do_not_contact'] = Variable<bool>(doNotContact.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (customFields.present) {
      map['custom_fields'] = Variable<String>(customFields.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('civility: $civility, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('mobile: $mobile, ')
          ..write('organisationId: $organisationId, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('service: $service, ')
          ..write('notes: $notes, ')
          ..write('doNotContact: $doNotContact, ')
          ..write('ownerId: $ownerId, ')
          ..write('customFields: $customFields, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PositionsTable extends Positions
    with TableInfo<$PositionsTable, PositionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _collectedAtMeta = const VerificationMeta(
    'collectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> collectedAt = GeneratedColumn<DateTime>(
    'collected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobTitleMeta = const VerificationMeta(
    'jobTitle',
  );
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
    'job_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceMeta = const VerificationMeta(
    'service',
  );
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
    'service',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isElectedMeta = const VerificationMeta(
    'isElected',
  );
  @override
  late final GeneratedColumn<bool> isElected = GeneratedColumn<bool>(
    'is_elected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_elected" IN (0, 1))',
    ),
  );
  static const VerificationMeta _mandateRoleMeta = const VerificationMeta(
    'mandateRole',
  );
  @override
  late final GeneratedColumn<String> mandateRole = GeneratedColumn<String>(
    'mandate_role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _delegationMeta = const VerificationMeta(
    'delegation',
  );
  @override
  late final GeneratedColumn<String> delegation = GeneratedColumn<String>(
    'delegation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    contactId,
    organisationId,
    jobTitle,
    service,
    isElected,
    mandateRole,
    delegation,
    startDate,
    endDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'positions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PositionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('collected_at')) {
      context.handle(
        _collectedAtMeta,
        collectedAt.isAcceptableOrUnknown(
          data['collected_at']!,
          _collectedAtMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organisationIdMeta);
    }
    if (data.containsKey('job_title')) {
      context.handle(
        _jobTitleMeta,
        jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta),
      );
    }
    if (data.containsKey('service')) {
      context.handle(
        _serviceMeta,
        service.isAcceptableOrUnknown(data['service']!, _serviceMeta),
      );
    }
    if (data.containsKey('is_elected')) {
      context.handle(
        _isElectedMeta,
        isElected.isAcceptableOrUnknown(data['is_elected']!, _isElectedMeta),
      );
    } else if (isInserting) {
      context.missing(_isElectedMeta);
    }
    if (data.containsKey('mandate_role')) {
      context.handle(
        _mandateRoleMeta,
        mandateRole.isAcceptableOrUnknown(
          data['mandate_role']!,
          _mandateRoleMeta,
        ),
      );
    }
    if (data.containsKey('delegation')) {
      context.handle(
        _delegationMeta,
        delegation.isAcceptableOrUnknown(data['delegation']!, _delegationMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PositionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PositionRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      collectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}collected_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      )!,
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      )!,
      jobTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_title'],
      ),
      service: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service'],
      ),
      isElected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_elected'],
      )!,
      mandateRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mandate_role'],
      ),
      delegation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delegation'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      ),
    );
  }

  @override
  $PositionsTable createAlias(String alias) {
    return $PositionsTable(attachedDatabase, alias);
  }
}

class PositionRow extends DataClass implements Insertable<PositionRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? source;
  final String? sourceRef;
  final DateTime? collectedAt;
  final String id;
  final String contactId;
  final String organisationId;
  final String? jobTitle;
  final String? service;
  final bool isElected;
  final String? mandateRole;
  final String? delegation;
  final String? startDate;
  final String? endDate;
  const PositionRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.source,
    this.sourceRef,
    this.collectedAt,
    required this.id,
    required this.contactId,
    required this.organisationId,
    this.jobTitle,
    this.service,
    required this.isElected,
    this.mandateRole,
    this.delegation,
    this.startDate,
    this.endDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    if (!nullToAbsent || collectedAt != null) {
      map['collected_at'] = Variable<DateTime>(collectedAt);
    }
    map['id'] = Variable<String>(id);
    map['contact_id'] = Variable<String>(contactId);
    map['organisation_id'] = Variable<String>(organisationId);
    if (!nullToAbsent || jobTitle != null) {
      map['job_title'] = Variable<String>(jobTitle);
    }
    if (!nullToAbsent || service != null) {
      map['service'] = Variable<String>(service);
    }
    map['is_elected'] = Variable<bool>(isElected);
    if (!nullToAbsent || mandateRole != null) {
      map['mandate_role'] = Variable<String>(mandateRole);
    }
    if (!nullToAbsent || delegation != null) {
      map['delegation'] = Variable<String>(delegation);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    return map;
  }

  PositionsCompanion toCompanion(bool nullToAbsent) {
    return PositionsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      collectedAt: collectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(collectedAt),
      id: Value(id),
      contactId: Value(contactId),
      organisationId: Value(organisationId),
      jobTitle: jobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(jobTitle),
      service: service == null && nullToAbsent
          ? const Value.absent()
          : Value(service),
      isElected: Value(isElected),
      mandateRole: mandateRole == null && nullToAbsent
          ? const Value.absent()
          : Value(mandateRole),
      delegation: delegation == null && nullToAbsent
          ? const Value.absent()
          : Value(delegation),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory PositionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PositionRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      source: serializer.fromJson<String?>(json['source']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      collectedAt: serializer.fromJson<DateTime?>(json['collectedAt']),
      id: serializer.fromJson<String>(json['id']),
      contactId: serializer.fromJson<String>(json['contactId']),
      organisationId: serializer.fromJson<String>(json['organisationId']),
      jobTitle: serializer.fromJson<String?>(json['jobTitle']),
      service: serializer.fromJson<String?>(json['service']),
      isElected: serializer.fromJson<bool>(json['isElected']),
      mandateRole: serializer.fromJson<String?>(json['mandateRole']),
      delegation: serializer.fromJson<String?>(json['delegation']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'source': serializer.toJson<String?>(source),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'collectedAt': serializer.toJson<DateTime?>(collectedAt),
      'id': serializer.toJson<String>(id),
      'contactId': serializer.toJson<String>(contactId),
      'organisationId': serializer.toJson<String>(organisationId),
      'jobTitle': serializer.toJson<String?>(jobTitle),
      'service': serializer.toJson<String?>(service),
      'isElected': serializer.toJson<bool>(isElected),
      'mandateRole': serializer.toJson<String?>(mandateRole),
      'delegation': serializer.toJson<String?>(delegation),
      'startDate': serializer.toJson<String?>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
    };
  }

  PositionRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> sourceRef = const Value.absent(),
    Value<DateTime?> collectedAt = const Value.absent(),
    String? id,
    String? contactId,
    String? organisationId,
    Value<String?> jobTitle = const Value.absent(),
    Value<String?> service = const Value.absent(),
    bool? isElected,
    Value<String?> mandateRole = const Value.absent(),
    Value<String?> delegation = const Value.absent(),
    Value<String?> startDate = const Value.absent(),
    Value<String?> endDate = const Value.absent(),
  }) => PositionRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    source: source.present ? source.value : this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    collectedAt: collectedAt.present ? collectedAt.value : this.collectedAt,
    id: id ?? this.id,
    contactId: contactId ?? this.contactId,
    organisationId: organisationId ?? this.organisationId,
    jobTitle: jobTitle.present ? jobTitle.value : this.jobTitle,
    service: service.present ? service.value : this.service,
    isElected: isElected ?? this.isElected,
    mandateRole: mandateRole.present ? mandateRole.value : this.mandateRole,
    delegation: delegation.present ? delegation.value : this.delegation,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
  );
  PositionRow copyWithCompanion(PositionsCompanion data) {
    return PositionRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      collectedAt: data.collectedAt.present
          ? data.collectedAt.value
          : this.collectedAt,
      id: data.id.present ? data.id.value : this.id,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      service: data.service.present ? data.service.value : this.service,
      isElected: data.isElected.present ? data.isElected.value : this.isElected,
      mandateRole: data.mandateRole.present
          ? data.mandateRole.value
          : this.mandateRole,
      delegation: data.delegation.present
          ? data.delegation.value
          : this.delegation,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PositionRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('organisationId: $organisationId, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('service: $service, ')
          ..write('isElected: $isElected, ')
          ..write('mandateRole: $mandateRole, ')
          ..write('delegation: $delegation, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    source,
    sourceRef,
    collectedAt,
    id,
    contactId,
    organisationId,
    jobTitle,
    service,
    isElected,
    mandateRole,
    delegation,
    startDate,
    endDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PositionRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.collectedAt == this.collectedAt &&
          other.id == this.id &&
          other.contactId == this.contactId &&
          other.organisationId == this.organisationId &&
          other.jobTitle == this.jobTitle &&
          other.service == this.service &&
          other.isElected == this.isElected &&
          other.mandateRole == this.mandateRole &&
          other.delegation == this.delegation &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class PositionsCompanion extends UpdateCompanion<PositionRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String?> source;
  final Value<String?> sourceRef;
  final Value<DateTime?> collectedAt;
  final Value<String> id;
  final Value<String> contactId;
  final Value<String> organisationId;
  final Value<String?> jobTitle;
  final Value<String?> service;
  final Value<bool> isElected;
  final Value<String?> mandateRole;
  final Value<String?> delegation;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<int> rowid;
  const PositionsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.contactId = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.service = const Value.absent(),
    this.isElected = const Value.absent(),
    this.mandateRole = const Value.absent(),
    this.delegation = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PositionsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.collectedAt = const Value.absent(),
    required String id,
    required String contactId,
    required String organisationId,
    this.jobTitle = const Value.absent(),
    this.service = const Value.absent(),
    required bool isElected,
    this.mandateRole = const Value.absent(),
    this.delegation = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       contactId = Value(contactId),
       organisationId = Value(organisationId),
       isElected = Value(isElected);
  static Insertable<PositionRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? source,
    Expression<String>? sourceRef,
    Expression<DateTime>? collectedAt,
    Expression<String>? id,
    Expression<String>? contactId,
    Expression<String>? organisationId,
    Expression<String>? jobTitle,
    Expression<String>? service,
    Expression<bool>? isElected,
    Expression<String>? mandateRole,
    Expression<String>? delegation,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (collectedAt != null) 'collected_at': collectedAt,
      if (id != null) 'id': id,
      if (contactId != null) 'contact_id': contactId,
      if (organisationId != null) 'organisation_id': organisationId,
      if (jobTitle != null) 'job_title': jobTitle,
      if (service != null) 'service': service,
      if (isElected != null) 'is_elected': isElected,
      if (mandateRole != null) 'mandate_role': mandateRole,
      if (delegation != null) 'delegation': delegation,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PositionsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String?>? source,
    Value<String?>? sourceRef,
    Value<DateTime?>? collectedAt,
    Value<String>? id,
    Value<String>? contactId,
    Value<String>? organisationId,
    Value<String?>? jobTitle,
    Value<String?>? service,
    Value<bool>? isElected,
    Value<String?>? mandateRole,
    Value<String?>? delegation,
    Value<String?>? startDate,
    Value<String?>? endDate,
    Value<int>? rowid,
  }) {
    return PositionsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      collectedAt: collectedAt ?? this.collectedAt,
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      organisationId: organisationId ?? this.organisationId,
      jobTitle: jobTitle ?? this.jobTitle,
      service: service ?? this.service,
      isElected: isElected ?? this.isElected,
      mandateRole: mandateRole ?? this.mandateRole,
      delegation: delegation ?? this.delegation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (collectedAt.present) {
      map['collected_at'] = Variable<DateTime>(collectedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (isElected.present) {
      map['is_elected'] = Variable<bool>(isElected.value);
    }
    if (mandateRole.present) {
      map['mandate_role'] = Variable<String>(mandateRole.value);
    }
    if (delegation.present) {
      map['delegation'] = Variable<String>(delegation.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PositionsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('organisationId: $organisationId, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('service: $service, ')
          ..write('isElected: $isElected, ')
          ..write('mandateRole: $mandateRole, ')
          ..write('delegation: $delegation, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PipelinesTable extends Pipelines
    with TableInfo<$PipelinesTable, PipelineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PipelinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<double> sortOrder = GeneratedColumn<double>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    kind,
    sortOrder,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pipelines';
  @override
  VerificationContext validateIntegrity(
    Insertable<PipelineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PipelineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PipelineRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sort_order'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      ),
    );
  }

  @override
  $PipelinesTable createAlias(String alias) {
    return $PipelinesTable(attachedDatabase, alias);
  }
}

class PipelineRow extends DataClass implements Insertable<PipelineRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String kind;
  final double? sortOrder;
  final bool? archived;
  const PipelineRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.kind,
    this.sortOrder,
    this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<double>(sortOrder);
    }
    if (!nullToAbsent || archived != null) {
      map['archived'] = Variable<bool>(archived);
    }
    return map;
  }

  PipelinesCompanion toCompanion(bool nullToAbsent) {
    return PipelinesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
      archived: archived == null && nullToAbsent
          ? const Value.absent()
          : Value(archived),
    );
  }

  factory PipelineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PipelineRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      sortOrder: serializer.fromJson<double?>(json['sortOrder']),
      archived: serializer.fromJson<bool?>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'sortOrder': serializer.toJson<double?>(sortOrder),
      'archived': serializer.toJson<bool?>(archived),
    };
  }

  PipelineRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? kind,
    Value<double?> sortOrder = const Value.absent(),
    Value<bool?> archived = const Value.absent(),
  }) => PipelineRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
    archived: archived.present ? archived.value : this.archived,
  );
  PipelineRow copyWithCompanion(PipelinesCompanion data) {
    return PipelineRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PipelineRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    kind,
    sortOrder,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PipelineRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived);
}

class PipelinesCompanion extends UpdateCompanion<PipelineRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<double?> sortOrder;
  final Value<bool?> archived;
  final Value<int> rowid;
  const PipelinesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PipelinesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String kind,
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       kind = Value(kind);
  static Insertable<PipelineRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<double>? sortOrder,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PipelinesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<double?>? sortOrder,
    Value<bool?>? archived,
    Value<int>? rowid,
  }) {
    return PipelinesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<double>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PipelinesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PipelineStagesTable extends PipelineStages
    with TableInfo<$PipelineStagesTable, StageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PipelineStagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pipelineIdMeta = const VerificationMeta(
    'pipelineId',
  );
  @override
  late final GeneratedColumn<String> pipelineId = GeneratedColumn<String>(
    'pipeline_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<double> sortOrder = GeneratedColumn<double>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _probabilityMeta = const VerificationMeta(
    'probability',
  );
  @override
  late final GeneratedColumn<int> probability = GeneratedColumn<int>(
    'probability',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    pipelineId,
    name,
    sortOrder,
    probability,
    color,
    outcome,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pipeline_stages';
  @override
  VerificationContext validateIntegrity(
    Insertable<StageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pipeline_id')) {
      context.handle(
        _pipelineIdMeta,
        pipelineId.isAcceptableOrUnknown(data['pipeline_id']!, _pipelineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pipelineIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('probability')) {
      context.handle(
        _probabilityMeta,
        probability.isAcceptableOrUnknown(
          data['probability']!,
          _probabilityMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StageRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pipelineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pipeline_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sort_order'],
      ),
      probability: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}probability'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
    );
  }

  @override
  $PipelineStagesTable createAlias(String alias) {
    return $PipelineStagesTable(attachedDatabase, alias);
  }
}

class StageRow extends DataClass implements Insertable<StageRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String pipelineId;
  final String name;
  final double? sortOrder;
  final int? probability;
  final String? color;
  final String outcome;
  const StageRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.pipelineId,
    required this.name,
    this.sortOrder,
    this.probability,
    this.color,
    required this.outcome,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['pipeline_id'] = Variable<String>(pipelineId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<double>(sortOrder);
    }
    if (!nullToAbsent || probability != null) {
      map['probability'] = Variable<int>(probability);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['outcome'] = Variable<String>(outcome);
    return map;
  }

  PipelineStagesCompanion toCompanion(bool nullToAbsent) {
    return PipelineStagesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      pipelineId: Value(pipelineId),
      name: Value(name),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
      probability: probability == null && nullToAbsent
          ? const Value.absent()
          : Value(probability),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      outcome: Value(outcome),
    );
  }

  factory StageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StageRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      pipelineId: serializer.fromJson<String>(json['pipelineId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<double?>(json['sortOrder']),
      probability: serializer.fromJson<int?>(json['probability']),
      color: serializer.fromJson<String?>(json['color']),
      outcome: serializer.fromJson<String>(json['outcome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'pipelineId': serializer.toJson<String>(pipelineId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<double?>(sortOrder),
      'probability': serializer.toJson<int?>(probability),
      'color': serializer.toJson<String?>(color),
      'outcome': serializer.toJson<String>(outcome),
    };
  }

  StageRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? pipelineId,
    String? name,
    Value<double?> sortOrder = const Value.absent(),
    Value<int?> probability = const Value.absent(),
    Value<String?> color = const Value.absent(),
    String? outcome,
  }) => StageRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    pipelineId: pipelineId ?? this.pipelineId,
    name: name ?? this.name,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
    probability: probability.present ? probability.value : this.probability,
    color: color.present ? color.value : this.color,
    outcome: outcome ?? this.outcome,
  );
  StageRow copyWithCompanion(PipelineStagesCompanion data) {
    return StageRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      pipelineId: data.pipelineId.present
          ? data.pipelineId.value
          : this.pipelineId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      probability: data.probability.present
          ? data.probability.value
          : this.probability,
      color: data.color.present ? data.color.value : this.color,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StageRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('pipelineId: $pipelineId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('probability: $probability, ')
          ..write('color: $color, ')
          ..write('outcome: $outcome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    pipelineId,
    name,
    sortOrder,
    probability,
    color,
    outcome,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StageRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.pipelineId == this.pipelineId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.probability == this.probability &&
          other.color == this.color &&
          other.outcome == this.outcome);
}

class PipelineStagesCompanion extends UpdateCompanion<StageRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> pipelineId;
  final Value<String> name;
  final Value<double?> sortOrder;
  final Value<int?> probability;
  final Value<String?> color;
  final Value<String> outcome;
  final Value<int> rowid;
  const PipelineStagesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.pipelineId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.probability = const Value.absent(),
    this.color = const Value.absent(),
    this.outcome = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PipelineStagesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String pipelineId,
    required String name,
    this.sortOrder = const Value.absent(),
    this.probability = const Value.absent(),
    this.color = const Value.absent(),
    required String outcome,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       pipelineId = Value(pipelineId),
       name = Value(name),
       outcome = Value(outcome);
  static Insertable<StageRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? pipelineId,
    Expression<String>? name,
    Expression<double>? sortOrder,
    Expression<int>? probability,
    Expression<String>? color,
    Expression<String>? outcome,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (pipelineId != null) 'pipeline_id': pipelineId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (probability != null) 'probability': probability,
      if (color != null) 'color': color,
      if (outcome != null) 'outcome': outcome,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PipelineStagesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? pipelineId,
    Value<String>? name,
    Value<double?>? sortOrder,
    Value<int?>? probability,
    Value<String?>? color,
    Value<String>? outcome,
    Value<int>? rowid,
  }) {
    return PipelineStagesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      pipelineId: pipelineId ?? this.pipelineId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      probability: probability ?? this.probability,
      color: color ?? this.color,
      outcome: outcome ?? this.outcome,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pipelineId.present) {
      map['pipeline_id'] = Variable<String>(pipelineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<double>(sortOrder.value);
    }
    if (probability.present) {
      map['probability'] = Variable<int>(probability.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PipelineStagesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('pipelineId: $pipelineId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('probability: $probability, ')
          ..write('color: $color, ')
          ..write('outcome: $outcome, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DealsTable extends Deals with TableInfo<$DealsTable, DealRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pipelineIdMeta = const VerificationMeta(
    'pipelineId',
  );
  @override
  late final GeneratedColumn<String> pipelineId = GeneratedColumn<String>(
    'pipeline_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stageIdMeta = const VerificationMeta(
    'stageId',
  );
  @override
  late final GeneratedColumn<String> stageId = GeneratedColumn<String>(
    'stage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _probabilityMeta = const VerificationMeta(
    'probability',
  );
  @override
  late final GeneratedColumn<int> probability = GeneratedColumn<int>(
    'probability',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedCloseDateMeta = const VerificationMeta(
    'expectedCloseDate',
  );
  @override
  late final GeneratedColumn<String> expectedCloseDate =
      GeneratedColumn<String>(
        'expected_close_date',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<double> sortOrder = GeneratedColumn<double>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFieldsMeta = const VerificationMeta(
    'customFields',
  );
  @override
  late final GeneratedColumn<String> customFields = GeneratedColumn<String>(
    'custom_fields',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    title,
    pipelineId,
    stageId,
    organisationId,
    contactId,
    amountCents,
    probability,
    expectedCloseDate,
    status,
    closedAt,
    sortOrder,
    ownerId,
    description,
    customFields,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DealRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('pipeline_id')) {
      context.handle(
        _pipelineIdMeta,
        pipelineId.isAcceptableOrUnknown(data['pipeline_id']!, _pipelineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pipelineIdMeta);
    }
    if (data.containsKey('stage_id')) {
      context.handle(
        _stageIdMeta,
        stageId.isAcceptableOrUnknown(data['stage_id']!, _stageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stageIdMeta);
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    }
    if (data.containsKey('probability')) {
      context.handle(
        _probabilityMeta,
        probability.isAcceptableOrUnknown(
          data['probability']!,
          _probabilityMeta,
        ),
      );
    }
    if (data.containsKey('expected_close_date')) {
      context.handle(
        _expectedCloseDateMeta,
        expectedCloseDate.isAcceptableOrUnknown(
          data['expected_close_date']!,
          _expectedCloseDateMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('custom_fields')) {
      context.handle(
        _customFieldsMeta,
        customFields.isAcceptableOrUnknown(
          data['custom_fields']!,
          _customFieldsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DealRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DealRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      pipelineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pipeline_id'],
      )!,
      stageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage_id'],
      )!,
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      ),
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      ),
      probability: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}probability'],
      ),
      expectedCloseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_close_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sort_order'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      customFields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fields'],
      ),
    );
  }

  @override
  $DealsTable createAlias(String alias) {
    return $DealsTable(attachedDatabase, alias);
  }
}

class DealRow extends DataClass implements Insertable<DealRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String title;
  final String pipelineId;
  final String stageId;
  final String? organisationId;
  final String? contactId;
  final int? amountCents;
  final int? probability;
  final String? expectedCloseDate;
  final String status;
  final DateTime? closedAt;
  final double? sortOrder;
  final String? ownerId;
  final String? description;
  final String? customFields;
  const DealRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.title,
    required this.pipelineId,
    required this.stageId,
    this.organisationId,
    this.contactId,
    this.amountCents,
    this.probability,
    this.expectedCloseDate,
    required this.status,
    this.closedAt,
    this.sortOrder,
    this.ownerId,
    this.description,
    this.customFields,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['pipeline_id'] = Variable<String>(pipelineId);
    map['stage_id'] = Variable<String>(stageId);
    if (!nullToAbsent || organisationId != null) {
      map['organisation_id'] = Variable<String>(organisationId);
    }
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || amountCents != null) {
      map['amount_cents'] = Variable<int>(amountCents);
    }
    if (!nullToAbsent || probability != null) {
      map['probability'] = Variable<int>(probability);
    }
    if (!nullToAbsent || expectedCloseDate != null) {
      map['expected_close_date'] = Variable<String>(expectedCloseDate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<double>(sortOrder);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || customFields != null) {
      map['custom_fields'] = Variable<String>(customFields);
    }
    return map;
  }

  DealsCompanion toCompanion(bool nullToAbsent) {
    return DealsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      title: Value(title),
      pipelineId: Value(pipelineId),
      stageId: Value(stageId),
      organisationId: organisationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organisationId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      amountCents: amountCents == null && nullToAbsent
          ? const Value.absent()
          : Value(amountCents),
      probability: probability == null && nullToAbsent
          ? const Value.absent()
          : Value(probability),
      expectedCloseDate: expectedCloseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedCloseDate),
      status: Value(status),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      customFields: customFields == null && nullToAbsent
          ? const Value.absent()
          : Value(customFields),
    );
  }

  factory DealRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DealRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      pipelineId: serializer.fromJson<String>(json['pipelineId']),
      stageId: serializer.fromJson<String>(json['stageId']),
      organisationId: serializer.fromJson<String?>(json['organisationId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      amountCents: serializer.fromJson<int?>(json['amountCents']),
      probability: serializer.fromJson<int?>(json['probability']),
      expectedCloseDate: serializer.fromJson<String?>(
        json['expectedCloseDate'],
      ),
      status: serializer.fromJson<String>(json['status']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      sortOrder: serializer.fromJson<double?>(json['sortOrder']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      description: serializer.fromJson<String?>(json['description']),
      customFields: serializer.fromJson<String?>(json['customFields']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'pipelineId': serializer.toJson<String>(pipelineId),
      'stageId': serializer.toJson<String>(stageId),
      'organisationId': serializer.toJson<String?>(organisationId),
      'contactId': serializer.toJson<String?>(contactId),
      'amountCents': serializer.toJson<int?>(amountCents),
      'probability': serializer.toJson<int?>(probability),
      'expectedCloseDate': serializer.toJson<String?>(expectedCloseDate),
      'status': serializer.toJson<String>(status),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'sortOrder': serializer.toJson<double?>(sortOrder),
      'ownerId': serializer.toJson<String?>(ownerId),
      'description': serializer.toJson<String?>(description),
      'customFields': serializer.toJson<String?>(customFields),
    };
  }

  DealRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? title,
    String? pipelineId,
    String? stageId,
    Value<String?> organisationId = const Value.absent(),
    Value<String?> contactId = const Value.absent(),
    Value<int?> amountCents = const Value.absent(),
    Value<int?> probability = const Value.absent(),
    Value<String?> expectedCloseDate = const Value.absent(),
    String? status,
    Value<DateTime?> closedAt = const Value.absent(),
    Value<double?> sortOrder = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> customFields = const Value.absent(),
  }) => DealRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    title: title ?? this.title,
    pipelineId: pipelineId ?? this.pipelineId,
    stageId: stageId ?? this.stageId,
    organisationId: organisationId.present
        ? organisationId.value
        : this.organisationId,
    contactId: contactId.present ? contactId.value : this.contactId,
    amountCents: amountCents.present ? amountCents.value : this.amountCents,
    probability: probability.present ? probability.value : this.probability,
    expectedCloseDate: expectedCloseDate.present
        ? expectedCloseDate.value
        : this.expectedCloseDate,
    status: status ?? this.status,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    description: description.present ? description.value : this.description,
    customFields: customFields.present ? customFields.value : this.customFields,
  );
  DealRow copyWithCompanion(DealsCompanion data) {
    return DealRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      pipelineId: data.pipelineId.present
          ? data.pipelineId.value
          : this.pipelineId,
      stageId: data.stageId.present ? data.stageId.value : this.stageId,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      probability: data.probability.present
          ? data.probability.value
          : this.probability,
      expectedCloseDate: data.expectedCloseDate.present
          ? data.expectedCloseDate.value
          : this.expectedCloseDate,
      status: data.status.present ? data.status.value : this.status,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      description: data.description.present
          ? data.description.value
          : this.description,
      customFields: data.customFields.present
          ? data.customFields.value
          : this.customFields,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DealRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('pipelineId: $pipelineId, ')
          ..write('stageId: $stageId, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('amountCents: $amountCents, ')
          ..write('probability: $probability, ')
          ..write('expectedCloseDate: $expectedCloseDate, ')
          ..write('status: $status, ')
          ..write('closedAt: $closedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('ownerId: $ownerId, ')
          ..write('description: $description, ')
          ..write('customFields: $customFields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    title,
    pipelineId,
    stageId,
    organisationId,
    contactId,
    amountCents,
    probability,
    expectedCloseDate,
    status,
    closedAt,
    sortOrder,
    ownerId,
    description,
    customFields,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DealRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.title == this.title &&
          other.pipelineId == this.pipelineId &&
          other.stageId == this.stageId &&
          other.organisationId == this.organisationId &&
          other.contactId == this.contactId &&
          other.amountCents == this.amountCents &&
          other.probability == this.probability &&
          other.expectedCloseDate == this.expectedCloseDate &&
          other.status == this.status &&
          other.closedAt == this.closedAt &&
          other.sortOrder == this.sortOrder &&
          other.ownerId == this.ownerId &&
          other.description == this.description &&
          other.customFields == this.customFields);
}

class DealsCompanion extends UpdateCompanion<DealRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> title;
  final Value<String> pipelineId;
  final Value<String> stageId;
  final Value<String?> organisationId;
  final Value<String?> contactId;
  final Value<int?> amountCents;
  final Value<int?> probability;
  final Value<String?> expectedCloseDate;
  final Value<String> status;
  final Value<DateTime?> closedAt;
  final Value<double?> sortOrder;
  final Value<String?> ownerId;
  final Value<String?> description;
  final Value<String?> customFields;
  final Value<int> rowid;
  const DealsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.pipelineId = const Value.absent(),
    this.stageId = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.probability = const Value.absent(),
    this.expectedCloseDate = const Value.absent(),
    this.status = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.description = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DealsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String title,
    required String pipelineId,
    required String stageId,
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.probability = const Value.absent(),
    this.expectedCloseDate = const Value.absent(),
    required String status,
    this.closedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.description = const Value.absent(),
    this.customFields = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       title = Value(title),
       pipelineId = Value(pipelineId),
       stageId = Value(stageId),
       status = Value(status);
  static Insertable<DealRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? pipelineId,
    Expression<String>? stageId,
    Expression<String>? organisationId,
    Expression<String>? contactId,
    Expression<int>? amountCents,
    Expression<int>? probability,
    Expression<String>? expectedCloseDate,
    Expression<String>? status,
    Expression<DateTime>? closedAt,
    Expression<double>? sortOrder,
    Expression<String>? ownerId,
    Expression<String>? description,
    Expression<String>? customFields,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (pipelineId != null) 'pipeline_id': pipelineId,
      if (stageId != null) 'stage_id': stageId,
      if (organisationId != null) 'organisation_id': organisationId,
      if (contactId != null) 'contact_id': contactId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (probability != null) 'probability': probability,
      if (expectedCloseDate != null) 'expected_close_date': expectedCloseDate,
      if (status != null) 'status': status,
      if (closedAt != null) 'closed_at': closedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (ownerId != null) 'owner_id': ownerId,
      if (description != null) 'description': description,
      if (customFields != null) 'custom_fields': customFields,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DealsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? title,
    Value<String>? pipelineId,
    Value<String>? stageId,
    Value<String?>? organisationId,
    Value<String?>? contactId,
    Value<int?>? amountCents,
    Value<int?>? probability,
    Value<String?>? expectedCloseDate,
    Value<String>? status,
    Value<DateTime?>? closedAt,
    Value<double?>? sortOrder,
    Value<String?>? ownerId,
    Value<String?>? description,
    Value<String?>? customFields,
    Value<int>? rowid,
  }) {
    return DealsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      title: title ?? this.title,
      pipelineId: pipelineId ?? this.pipelineId,
      stageId: stageId ?? this.stageId,
      organisationId: organisationId ?? this.organisationId,
      contactId: contactId ?? this.contactId,
      amountCents: amountCents ?? this.amountCents,
      probability: probability ?? this.probability,
      expectedCloseDate: expectedCloseDate ?? this.expectedCloseDate,
      status: status ?? this.status,
      closedAt: closedAt ?? this.closedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      ownerId: ownerId ?? this.ownerId,
      description: description ?? this.description,
      customFields: customFields ?? this.customFields,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (pipelineId.present) {
      map['pipeline_id'] = Variable<String>(pipelineId.value);
    }
    if (stageId.present) {
      map['stage_id'] = Variable<String>(stageId.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (probability.present) {
      map['probability'] = Variable<int>(probability.value);
    }
    if (expectedCloseDate.present) {
      map['expected_close_date'] = Variable<String>(expectedCloseDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<double>(sortOrder.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (customFields.present) {
      map['custom_fields'] = Variable<String>(customFields.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DealsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('pipelineId: $pipelineId, ')
          ..write('stageId: $stageId, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('amountCents: $amountCents, ')
          ..write('probability: $probability, ')
          ..write('expectedCloseDate: $expectedCloseDate, ')
          ..write('status: $status, ')
          ..write('closedAt: $closedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('ownerId: $ownerId, ')
          ..write('description: $description, ')
          ..write('customFields: $customFields, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, ActivityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dealIdMeta = const VerificationMeta('dealId');
  @override
  late final GeneratedColumn<String> dealId = GeneratedColumn<String>(
    'deal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindAtMeta = const VerificationMeta(
    'remindAt',
  );
  @override
  late final GeneratedColumn<DateTime> remindAt = GeneratedColumn<DateTime>(
    'remind_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doneAtMeta = const VerificationMeta('doneAt');
  @override
  late final GeneratedColumn<DateTime> doneAt = GeneratedColumn<DateTime>(
    'done_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assigneeIdMeta = const VerificationMeta(
    'assigneeId',
  );
  @override
  late final GeneratedColumn<String> assigneeId = GeneratedColumn<String>(
    'assignee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    kind,
    subject,
    body,
    organisationId,
    contactId,
    dealId,
    startsAt,
    endsAt,
    dueAt,
    remindAt,
    doneAt,
    assigneeId,
    ownerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('deal_id')) {
      context.handle(
        _dealIdMeta,
        dealId.isAcceptableOrUnknown(data['deal_id']!, _dealIdMeta),
      );
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('remind_at')) {
      context.handle(
        _remindAtMeta,
        remindAt.isAcceptableOrUnknown(data['remind_at']!, _remindAtMeta),
      );
    }
    if (data.containsKey('done_at')) {
      context.handle(
        _doneAtMeta,
        doneAt.isAcceptableOrUnknown(data['done_at']!, _doneAtMeta),
      );
    }
    if (data.containsKey('assignee_id')) {
      context.handle(
        _assigneeIdMeta,
        assigneeId.isAcceptableOrUnknown(data['assignee_id']!, _assigneeIdMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      ),
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      dealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deal_id'],
      ),
      startsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}starts_at'],
      ),
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      remindAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}remind_at'],
      ),
      doneAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}done_at'],
      ),
      assigneeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assignee_id'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class ActivityRow extends DataClass implements Insertable<ActivityRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String kind;
  final String subject;
  final String? body;
  final String? organisationId;
  final String? contactId;
  final String? dealId;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? dueAt;
  final DateTime? remindAt;
  final DateTime? doneAt;
  final String? assigneeId;
  final String? ownerId;
  const ActivityRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.kind,
    required this.subject,
    this.body,
    this.organisationId,
    this.contactId,
    this.dealId,
    this.startsAt,
    this.endsAt,
    this.dueAt,
    this.remindAt,
    this.doneAt,
    this.assigneeId,
    this.ownerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['kind'] = Variable<String>(kind);
    map['subject'] = Variable<String>(subject);
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || organisationId != null) {
      map['organisation_id'] = Variable<String>(organisationId);
    }
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || dealId != null) {
      map['deal_id'] = Variable<String>(dealId);
    }
    if (!nullToAbsent || startsAt != null) {
      map['starts_at'] = Variable<DateTime>(startsAt);
    }
    if (!nullToAbsent || endsAt != null) {
      map['ends_at'] = Variable<DateTime>(endsAt);
    }
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || remindAt != null) {
      map['remind_at'] = Variable<DateTime>(remindAt);
    }
    if (!nullToAbsent || doneAt != null) {
      map['done_at'] = Variable<DateTime>(doneAt);
    }
    if (!nullToAbsent || assigneeId != null) {
      map['assignee_id'] = Variable<String>(assigneeId);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      kind: Value(kind),
      subject: Value(subject),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      organisationId: organisationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organisationId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      dealId: dealId == null && nullToAbsent
          ? const Value.absent()
          : Value(dealId),
      startsAt: startsAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startsAt),
      endsAt: endsAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endsAt),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      remindAt: remindAt == null && nullToAbsent
          ? const Value.absent()
          : Value(remindAt),
      doneAt: doneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(doneAt),
      assigneeId: assigneeId == null && nullToAbsent
          ? const Value.absent()
          : Value(assigneeId),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
    );
  }

  factory ActivityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      subject: serializer.fromJson<String>(json['subject']),
      body: serializer.fromJson<String?>(json['body']),
      organisationId: serializer.fromJson<String?>(json['organisationId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      dealId: serializer.fromJson<String?>(json['dealId']),
      startsAt: serializer.fromJson<DateTime?>(json['startsAt']),
      endsAt: serializer.fromJson<DateTime?>(json['endsAt']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      remindAt: serializer.fromJson<DateTime?>(json['remindAt']),
      doneAt: serializer.fromJson<DateTime?>(json['doneAt']),
      assigneeId: serializer.fromJson<String?>(json['assigneeId']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(kind),
      'subject': serializer.toJson<String>(subject),
      'body': serializer.toJson<String?>(body),
      'organisationId': serializer.toJson<String?>(organisationId),
      'contactId': serializer.toJson<String?>(contactId),
      'dealId': serializer.toJson<String?>(dealId),
      'startsAt': serializer.toJson<DateTime?>(startsAt),
      'endsAt': serializer.toJson<DateTime?>(endsAt),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'remindAt': serializer.toJson<DateTime?>(remindAt),
      'doneAt': serializer.toJson<DateTime?>(doneAt),
      'assigneeId': serializer.toJson<String?>(assigneeId),
      'ownerId': serializer.toJson<String?>(ownerId),
    };
  }

  ActivityRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? kind,
    String? subject,
    Value<String?> body = const Value.absent(),
    Value<String?> organisationId = const Value.absent(),
    Value<String?> contactId = const Value.absent(),
    Value<String?> dealId = const Value.absent(),
    Value<DateTime?> startsAt = const Value.absent(),
    Value<DateTime?> endsAt = const Value.absent(),
    Value<DateTime?> dueAt = const Value.absent(),
    Value<DateTime?> remindAt = const Value.absent(),
    Value<DateTime?> doneAt = const Value.absent(),
    Value<String?> assigneeId = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
  }) => ActivityRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    kind: kind ?? this.kind,
    subject: subject ?? this.subject,
    body: body.present ? body.value : this.body,
    organisationId: organisationId.present
        ? organisationId.value
        : this.organisationId,
    contactId: contactId.present ? contactId.value : this.contactId,
    dealId: dealId.present ? dealId.value : this.dealId,
    startsAt: startsAt.present ? startsAt.value : this.startsAt,
    endsAt: endsAt.present ? endsAt.value : this.endsAt,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    remindAt: remindAt.present ? remindAt.value : this.remindAt,
    doneAt: doneAt.present ? doneAt.value : this.doneAt,
    assigneeId: assigneeId.present ? assigneeId.value : this.assigneeId,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
  );
  ActivityRow copyWithCompanion(ActivitiesCompanion data) {
    return ActivityRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      subject: data.subject.present ? data.subject.value : this.subject,
      body: data.body.present ? data.body.value : this.body,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      dealId: data.dealId.present ? data.dealId.value : this.dealId,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      remindAt: data.remindAt.present ? data.remindAt.value : this.remindAt,
      doneAt: data.doneAt.present ? data.doneAt.value : this.doneAt,
      assigneeId: data.assigneeId.present
          ? data.assigneeId.value
          : this.assigneeId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('remindAt: $remindAt, ')
          ..write('doneAt: $doneAt, ')
          ..write('assigneeId: $assigneeId, ')
          ..write('ownerId: $ownerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    kind,
    subject,
    body,
    organisationId,
    contactId,
    dealId,
    startsAt,
    endsAt,
    dueAt,
    remindAt,
    doneAt,
    assigneeId,
    ownerId,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.subject == this.subject &&
          other.body == this.body &&
          other.organisationId == this.organisationId &&
          other.contactId == this.contactId &&
          other.dealId == this.dealId &&
          other.startsAt == this.startsAt &&
          other.endsAt == this.endsAt &&
          other.dueAt == this.dueAt &&
          other.remindAt == this.remindAt &&
          other.doneAt == this.doneAt &&
          other.assigneeId == this.assigneeId &&
          other.ownerId == this.ownerId);
}

class ActivitiesCompanion extends UpdateCompanion<ActivityRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> kind;
  final Value<String> subject;
  final Value<String?> body;
  final Value<String?> organisationId;
  final Value<String?> contactId;
  final Value<String?> dealId;
  final Value<DateTime?> startsAt;
  final Value<DateTime?> endsAt;
  final Value<DateTime?> dueAt;
  final Value<DateTime?> remindAt;
  final Value<DateTime?> doneAt;
  final Value<String?> assigneeId;
  final Value<String?> ownerId;
  final Value<int> rowid;
  const ActivitiesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.subject = const Value.absent(),
    this.body = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.remindAt = const Value.absent(),
    this.doneAt = const Value.absent(),
    this.assigneeId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String kind,
    required String subject,
    this.body = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.remindAt = const Value.absent(),
    this.doneAt = const Value.absent(),
    this.assigneeId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       kind = Value(kind),
       subject = Value(subject);
  static Insertable<ActivityRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? kind,
    Expression<String>? subject,
    Expression<String>? body,
    Expression<String>? organisationId,
    Expression<String>? contactId,
    Expression<String>? dealId,
    Expression<DateTime>? startsAt,
    Expression<DateTime>? endsAt,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? remindAt,
    Expression<DateTime>? doneAt,
    Expression<String>? assigneeId,
    Expression<String>? ownerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      if (organisationId != null) 'organisation_id': organisationId,
      if (contactId != null) 'contact_id': contactId,
      if (dealId != null) 'deal_id': dealId,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (dueAt != null) 'due_at': dueAt,
      if (remindAt != null) 'remind_at': remindAt,
      if (doneAt != null) 'done_at': doneAt,
      if (assigneeId != null) 'assignee_id': assigneeId,
      if (ownerId != null) 'owner_id': ownerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitiesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? kind,
    Value<String>? subject,
    Value<String?>? body,
    Value<String?>? organisationId,
    Value<String?>? contactId,
    Value<String?>? dealId,
    Value<DateTime?>? startsAt,
    Value<DateTime?>? endsAt,
    Value<DateTime?>? dueAt,
    Value<DateTime?>? remindAt,
    Value<DateTime?>? doneAt,
    Value<String?>? assigneeId,
    Value<String?>? ownerId,
    Value<int>? rowid,
  }) {
    return ActivitiesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      kind: kind ?? this.kind,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      organisationId: organisationId ?? this.organisationId,
      contactId: contactId ?? this.contactId,
      dealId: dealId ?? this.dealId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      dueAt: dueAt ?? this.dueAt,
      remindAt: remindAt ?? this.remindAt,
      doneAt: doneAt ?? this.doneAt,
      assigneeId: assigneeId ?? this.assigneeId,
      ownerId: ownerId ?? this.ownerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (dealId.present) {
      map['deal_id'] = Variable<String>(dealId.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (remindAt.present) {
      map['remind_at'] = Variable<DateTime>(remindAt.value);
    }
    if (doneAt.present) {
      map['done_at'] = Variable<DateTime>(doneAt.value);
    }
    if (assigneeId.present) {
      map['assignee_id'] = Variable<String>(assigneeId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('remindAt: $remindAt, ')
          ..write('doneAt: $doneAt, ')
          ..write('assigneeId: $assigneeId, ')
          ..write('ownerId: $ownerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, AttachmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dealIdMeta = const VerificationMeta('dealId');
  @override
  late final GeneratedColumn<String> dealId = GeneratedColumn<String>(
    'deal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    fileId,
    fileName,
    size,
    mimeType,
    organisationId,
    contactId,
    dealId,
    activityId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('deal_id')) {
      context.handle(
        _dealIdMeta,
        dealId.isAcceptableOrUnknown(data['deal_id']!, _dealIdMeta),
      );
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      ),
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      dealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deal_id'],
      ),
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      ),
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class AttachmentRow extends DataClass implements Insertable<AttachmentRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String fileId;
  final String fileName;
  final int size;
  final String? mimeType;
  final String? organisationId;
  final String? contactId;
  final String? dealId;
  final String? activityId;
  const AttachmentRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.fileId,
    required this.fileName,
    required this.size,
    this.mimeType,
    this.organisationId,
    this.contactId,
    this.dealId,
    this.activityId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['file_id'] = Variable<String>(fileId);
    map['file_name'] = Variable<String>(fileName);
    map['size'] = Variable<int>(size);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || organisationId != null) {
      map['organisation_id'] = Variable<String>(organisationId);
    }
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || dealId != null) {
      map['deal_id'] = Variable<String>(dealId);
    }
    if (!nullToAbsent || activityId != null) {
      map['activity_id'] = Variable<String>(activityId);
    }
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      fileId: Value(fileId),
      fileName: Value(fileName),
      size: Value(size),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      organisationId: organisationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organisationId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      dealId: dealId == null && nullToAbsent
          ? const Value.absent()
          : Value(dealId),
      activityId: activityId == null && nullToAbsent
          ? const Value.absent()
          : Value(activityId),
    );
  }

  factory AttachmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      fileId: serializer.fromJson<String>(json['fileId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      size: serializer.fromJson<int>(json['size']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      organisationId: serializer.fromJson<String?>(json['organisationId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      dealId: serializer.fromJson<String?>(json['dealId']),
      activityId: serializer.fromJson<String?>(json['activityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'fileId': serializer.toJson<String>(fileId),
      'fileName': serializer.toJson<String>(fileName),
      'size': serializer.toJson<int>(size),
      'mimeType': serializer.toJson<String?>(mimeType),
      'organisationId': serializer.toJson<String?>(organisationId),
      'contactId': serializer.toJson<String?>(contactId),
      'dealId': serializer.toJson<String?>(dealId),
      'activityId': serializer.toJson<String?>(activityId),
    };
  }

  AttachmentRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? fileId,
    String? fileName,
    int? size,
    Value<String?> mimeType = const Value.absent(),
    Value<String?> organisationId = const Value.absent(),
    Value<String?> contactId = const Value.absent(),
    Value<String?> dealId = const Value.absent(),
    Value<String?> activityId = const Value.absent(),
  }) => AttachmentRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    fileId: fileId ?? this.fileId,
    fileName: fileName ?? this.fileName,
    size: size ?? this.size,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    organisationId: organisationId.present
        ? organisationId.value
        : this.organisationId,
    contactId: contactId.present ? contactId.value : this.contactId,
    dealId: dealId.present ? dealId.value : this.dealId,
    activityId: activityId.present ? activityId.value : this.activityId,
  );
  AttachmentRow copyWithCompanion(AttachmentsCompanion data) {
    return AttachmentRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      size: data.size.present ? data.size.value : this.size,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      dealId: data.dealId.present ? data.dealId.value : this.dealId,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('fileName: $fileName, ')
          ..write('size: $size, ')
          ..write('mimeType: $mimeType, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('activityId: $activityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    fileId,
    fileName,
    size,
    mimeType,
    organisationId,
    contactId,
    dealId,
    activityId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.fileName == this.fileName &&
          other.size == this.size &&
          other.mimeType == this.mimeType &&
          other.organisationId == this.organisationId &&
          other.contactId == this.contactId &&
          other.dealId == this.dealId &&
          other.activityId == this.activityId);
}

class AttachmentsCompanion extends UpdateCompanion<AttachmentRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> fileId;
  final Value<String> fileName;
  final Value<int> size;
  final Value<String?> mimeType;
  final Value<String?> organisationId;
  final Value<String?> contactId;
  final Value<String?> dealId;
  final Value<String?> activityId;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.size = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String fileId,
    required String fileName,
    required int size,
    this.mimeType = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       fileId = Value(fileId),
       fileName = Value(fileName),
       size = Value(size);
  static Insertable<AttachmentRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? fileId,
    Expression<String>? fileName,
    Expression<int>? size,
    Expression<String>? mimeType,
    Expression<String>? organisationId,
    Expression<String>? contactId,
    Expression<String>? dealId,
    Expression<String>? activityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (fileName != null) 'file_name': fileName,
      if (size != null) 'size': size,
      if (mimeType != null) 'mime_type': mimeType,
      if (organisationId != null) 'organisation_id': organisationId,
      if (contactId != null) 'contact_id': contactId,
      if (dealId != null) 'deal_id': dealId,
      if (activityId != null) 'activity_id': activityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? fileId,
    Value<String>? fileName,
    Value<int>? size,
    Value<String?>? mimeType,
    Value<String?>? organisationId,
    Value<String?>? contactId,
    Value<String?>? dealId,
    Value<String?>? activityId,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      size: size ?? this.size,
      mimeType: mimeType ?? this.mimeType,
      organisationId: organisationId ?? this.organisationId,
      contactId: contactId ?? this.contactId,
      dealId: dealId ?? this.dealId,
      activityId: activityId ?? this.activityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<String>(fileId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (dealId.present) {
      map['deal_id'] = Variable<String>(dealId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('fileName: $fileName, ')
          ..write('size: $size, ')
          ..write('mimeType: $mimeType, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('activityId: $activityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaggingsTable extends Taggings
    with TableInfo<$TaggingsTable, TaggingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaggingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    tagId,
    entity,
    recordId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taggings';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaggingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaggingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaggingRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
    );
  }

  @override
  $TaggingsTable createAlias(String alias) {
    return $TaggingsTable(attachedDatabase, alias);
  }
}

class TaggingRow extends DataClass implements Insertable<TaggingRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String tagId;
  final String entity;
  final String recordId;
  const TaggingRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.tagId,
    required this.entity,
    required this.recordId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['tag_id'] = Variable<String>(tagId);
    map['entity'] = Variable<String>(entity);
    map['record_id'] = Variable<String>(recordId);
    return map;
  }

  TaggingsCompanion toCompanion(bool nullToAbsent) {
    return TaggingsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      tagId: Value(tagId),
      entity: Value(entity),
      recordId: Value(recordId),
    );
  }

  factory TaggingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaggingRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      tagId: serializer.fromJson<String>(json['tagId']),
      entity: serializer.fromJson<String>(json['entity']),
      recordId: serializer.fromJson<String>(json['recordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'tagId': serializer.toJson<String>(tagId),
      'entity': serializer.toJson<String>(entity),
      'recordId': serializer.toJson<String>(recordId),
    };
  }

  TaggingRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? tagId,
    String? entity,
    String? recordId,
  }) => TaggingRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    tagId: tagId ?? this.tagId,
    entity: entity ?? this.entity,
    recordId: recordId ?? this.recordId,
  );
  TaggingRow copyWithCompanion(TaggingsCompanion data) {
    return TaggingRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      entity: data.entity.present ? data.entity.value : this.entity,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaggingRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('entity: $entity, ')
          ..write('recordId: $recordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    tagId,
    entity,
    recordId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaggingRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.entity == this.entity &&
          other.recordId == this.recordId);
}

class TaggingsCompanion extends UpdateCompanion<TaggingRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> tagId;
  final Value<String> entity;
  final Value<String> recordId;
  final Value<int> rowid;
  const TaggingsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.entity = const Value.absent(),
    this.recordId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaggingsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String tagId,
    required String entity,
    required String recordId,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       tagId = Value(tagId),
       entity = Value(entity),
       recordId = Value(recordId);
  static Insertable<TaggingRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? tagId,
    Expression<String>? entity,
    Expression<String>? recordId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (entity != null) 'entity': entity,
      if (recordId != null) 'record_id': recordId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaggingsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? tagId,
    Value<String>? entity,
    Value<String>? recordId,
    Value<int>? rowid,
  }) {
    return TaggingsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      entity: entity ?? this.entity,
      recordId: recordId ?? this.recordId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaggingsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('entity: $entity, ')
          ..write('recordId: $recordId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomFieldsTable extends CustomFields
    with TableInfo<$CustomFieldsTable, CustomFieldRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionsMeta = const VerificationMeta(
    'options',
  );
  @override
  late final GeneratedColumn<String> options = GeneratedColumn<String>(
    'options',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<double> sortOrder = GeneratedColumn<double>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    entity,
    key,
    label,
    type,
    options,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomFieldRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('options')) {
      context.handle(
        _optionsMeta,
        options.isAcceptableOrUnknown(data['options']!, _optionsMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomFieldRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomFieldRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      options: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sort_order'],
      ),
    );
  }

  @override
  $CustomFieldsTable createAlias(String alias) {
    return $CustomFieldsTable(attachedDatabase, alias);
  }
}

class CustomFieldRow extends DataClass implements Insertable<CustomFieldRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String entity;
  final String key;
  final String label;
  final String type;
  final String? options;
  final double? sortOrder;
  const CustomFieldRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.entity,
    required this.key,
    required this.label,
    required this.type,
    this.options,
    this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['entity'] = Variable<String>(entity);
    map['key'] = Variable<String>(key);
    map['label'] = Variable<String>(label);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || options != null) {
      map['options'] = Variable<String>(options);
    }
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<double>(sortOrder);
    }
    return map;
  }

  CustomFieldsCompanion toCompanion(bool nullToAbsent) {
    return CustomFieldsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      entity: Value(entity),
      key: Value(key),
      label: Value(label),
      type: Value(type),
      options: options == null && nullToAbsent
          ? const Value.absent()
          : Value(options),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
    );
  }

  factory CustomFieldRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomFieldRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      key: serializer.fromJson<String>(json['key']),
      label: serializer.fromJson<String>(json['label']),
      type: serializer.fromJson<String>(json['type']),
      options: serializer.fromJson<String?>(json['options']),
      sortOrder: serializer.fromJson<double?>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'entity': serializer.toJson<String>(entity),
      'key': serializer.toJson<String>(key),
      'label': serializer.toJson<String>(label),
      'type': serializer.toJson<String>(type),
      'options': serializer.toJson<String?>(options),
      'sortOrder': serializer.toJson<double?>(sortOrder),
    };
  }

  CustomFieldRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? entity,
    String? key,
    String? label,
    String? type,
    Value<String?> options = const Value.absent(),
    Value<double?> sortOrder = const Value.absent(),
  }) => CustomFieldRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    entity: entity ?? this.entity,
    key: key ?? this.key,
    label: label ?? this.label,
    type: type ?? this.type,
    options: options.present ? options.value : this.options,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
  );
  CustomFieldRow copyWithCompanion(CustomFieldsCompanion data) {
    return CustomFieldRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      key: data.key.present ? data.key.value : this.key,
      label: data.label.present ? data.label.value : this.label,
      type: data.type.present ? data.type.value : this.type,
      options: data.options.present ? data.options.value : this.options,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomFieldRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('options: $options, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    entity,
    key,
    label,
    type,
    options,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomFieldRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.key == this.key &&
          other.label == this.label &&
          other.type == this.type &&
          other.options == this.options &&
          other.sortOrder == this.sortOrder);
}

class CustomFieldsCompanion extends UpdateCompanion<CustomFieldRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> entity;
  final Value<String> key;
  final Value<String> label;
  final Value<String> type;
  final Value<String?> options;
  final Value<double?> sortOrder;
  final Value<int> rowid;
  const CustomFieldsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.key = const Value.absent(),
    this.label = const Value.absent(),
    this.type = const Value.absent(),
    this.options = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomFieldsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String entity,
    required String key,
    required String label,
    required String type,
    this.options = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       entity = Value(entity),
       key = Value(key),
       label = Value(label),
       type = Value(type);
  static Insertable<CustomFieldRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? entity,
    Expression<String>? key,
    Expression<String>? label,
    Expression<String>? type,
    Expression<String>? options,
    Expression<double>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (key != null) 'key': key,
      if (label != null) 'label': label,
      if (type != null) 'type': type,
      if (options != null) 'options': options,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomFieldsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? entity,
    Value<String>? key,
    Value<String>? label,
    Value<String>? type,
    Value<String?>? options,
    Value<double?>? sortOrder,
    Value<int>? rowid,
  }) {
    return CustomFieldsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      entity: entity ?? this.entity,
      key: key ?? this.key,
      label: label ?? this.label,
      type: type ?? this.type,
      options: options ?? this.options,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(options.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<double>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomFieldsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('options: $options, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SegmentsTable extends Segments
    with TableInfo<$SegmentsTable, SegmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _configMeta = const VerificationMeta('config');
  @override
  late final GeneratedColumn<String> config = GeneratedColumn<String>(
    'config',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    entity,
    description,
    config,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<SegmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('config')) {
      context.handle(
        _configMeta,
        config.isAcceptableOrUnknown(data['config']!, _configMeta),
      );
    } else if (isInserting) {
      context.missing(_configMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SegmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SegmentRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      config: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config'],
      )!,
    );
  }

  @override
  $SegmentsTable createAlias(String alias) {
    return $SegmentsTable(attachedDatabase, alias);
  }
}

class SegmentRow extends DataClass implements Insertable<SegmentRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String entity;
  final String? description;
  final String config;
  const SegmentRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.entity,
    this.description,
    required this.config,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['entity'] = Variable<String>(entity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['config'] = Variable<String>(config);
    return map;
  }

  SegmentsCompanion toCompanion(bool nullToAbsent) {
    return SegmentsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      entity: Value(entity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      config: Value(config),
    );
  }

  factory SegmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SegmentRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      entity: serializer.fromJson<String>(json['entity']),
      description: serializer.fromJson<String?>(json['description']),
      config: serializer.fromJson<String>(json['config']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'entity': serializer.toJson<String>(entity),
      'description': serializer.toJson<String?>(description),
      'config': serializer.toJson<String>(config),
    };
  }

  SegmentRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? entity,
    Value<String?> description = const Value.absent(),
    String? config,
  }) => SegmentRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    entity: entity ?? this.entity,
    description: description.present ? description.value : this.description,
    config: config ?? this.config,
  );
  SegmentRow copyWithCompanion(SegmentsCompanion data) {
    return SegmentRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      entity: data.entity.present ? data.entity.value : this.entity,
      description: data.description.present
          ? data.description.value
          : this.description,
      config: data.config.present ? data.config.value : this.config,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SegmentRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('entity: $entity, ')
          ..write('description: $description, ')
          ..write('config: $config')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    entity,
    description,
    config,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SegmentRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.entity == this.entity &&
          other.description == this.description &&
          other.config == this.config);
}

class SegmentsCompanion extends UpdateCompanion<SegmentRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> entity;
  final Value<String?> description;
  final Value<String> config;
  final Value<int> rowid;
  const SegmentsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.entity = const Value.absent(),
    this.description = const Value.absent(),
    this.config = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SegmentsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String entity,
    this.description = const Value.absent(),
    required String config,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       entity = Value(entity),
       config = Value(config);
  static Insertable<SegmentRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? entity,
    Expression<String>? description,
    Expression<String>? config,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (entity != null) 'entity': entity,
      if (description != null) 'description': description,
      if (config != null) 'config': config,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SegmentsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? entity,
    Value<String?>? description,
    Value<String>? config,
    Value<int>? rowid,
  }) {
    return SegmentsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      entity: entity ?? this.entity,
      description: description ?? this.description,
      config: config ?? this.config,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (config.present) {
      map['config'] = Variable<String>(config.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('entity: $entity, ')
          ..write('description: $description, ')
          ..write('config: $config, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmailTemplatesTable extends EmailTemplates
    with TableInfo<$EmailTemplatesTable, EmailTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    subject,
    body,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmailTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailTemplateRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $EmailTemplatesTable createAlias(String alias) {
    return $EmailTemplatesTable(attachedDatabase, alias);
  }
}

class EmailTemplateRow extends DataClass
    implements Insertable<EmailTemplateRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String subject;
  final String body;
  final String? description;
  const EmailTemplateRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.subject,
    required this.body,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['subject'] = Variable<String>(subject);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  EmailTemplatesCompanion toCompanion(bool nullToAbsent) {
    return EmailTemplatesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      subject: Value(subject),
      body: Value(body),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory EmailTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailTemplateRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      subject: serializer.fromJson<String>(json['subject']),
      body: serializer.fromJson<String>(json['body']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'subject': serializer.toJson<String>(subject),
      'body': serializer.toJson<String>(body),
      'description': serializer.toJson<String?>(description),
    };
  }

  EmailTemplateRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? subject,
    String? body,
    Value<String?> description = const Value.absent(),
  }) => EmailTemplateRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    subject: subject ?? this.subject,
    body: body ?? this.body,
    description: description.present ? description.value : this.description,
  );
  EmailTemplateRow copyWithCompanion(EmailTemplatesCompanion data) {
    return EmailTemplateRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      subject: data.subject.present ? data.subject.value : this.subject,
      body: data.body.present ? data.body.value : this.body,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailTemplateRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    subject,
    body,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailTemplateRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.subject == this.subject &&
          other.body == this.body &&
          other.description == this.description);
}

class EmailTemplatesCompanion extends UpdateCompanion<EmailTemplateRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> subject;
  final Value<String> body;
  final Value<String?> description;
  final Value<int> rowid;
  const EmailTemplatesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.subject = const Value.absent(),
    this.body = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmailTemplatesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String subject,
    required String body,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       subject = Value(subject),
       body = Value(body);
  static Insertable<EmailTemplateRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? subject,
    Expression<String>? body,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmailTemplatesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? subject,
    Value<String>? body,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return EmailTemplatesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailTemplatesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmailSequencesTable extends EmailSequences
    with TableInfo<$EmailSequencesTable, EmailSequenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailSequencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<String> steps = GeneratedColumn<String>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    description,
    steps,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_sequences';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmailSequenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailSequenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailSequenceRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      ),
    );
  }

  @override
  $EmailSequencesTable createAlias(String alias) {
    return $EmailSequencesTable(attachedDatabase, alias);
  }
}

class EmailSequenceRow extends DataClass
    implements Insertable<EmailSequenceRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String? description;
  final String steps;
  final bool? active;
  const EmailSequenceRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.name,
    this.description,
    required this.steps,
    this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['steps'] = Variable<String>(steps);
    if (!nullToAbsent || active != null) {
      map['active'] = Variable<bool>(active);
    }
    return map;
  }

  EmailSequencesCompanion toCompanion(bool nullToAbsent) {
    return EmailSequencesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      steps: Value(steps),
      active: active == null && nullToAbsent
          ? const Value.absent()
          : Value(active),
    );
  }

  factory EmailSequenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailSequenceRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      steps: serializer.fromJson<String>(json['steps']),
      active: serializer.fromJson<bool?>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'steps': serializer.toJson<String>(steps),
      'active': serializer.toJson<bool?>(active),
    };
  }

  EmailSequenceRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? steps,
    Value<bool?> active = const Value.absent(),
  }) => EmailSequenceRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    steps: steps ?? this.steps,
    active: active.present ? active.value : this.active,
  );
  EmailSequenceRow copyWithCompanion(EmailSequencesCompanion data) {
    return EmailSequenceRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      steps: data.steps.present ? data.steps.value : this.steps,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailSequenceRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('steps: $steps, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    description,
    steps,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailSequenceRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.steps == this.steps &&
          other.active == this.active);
}

class EmailSequencesCompanion extends UpdateCompanion<EmailSequenceRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> steps;
  final Value<bool?> active;
  final Value<int> rowid;
  const EmailSequencesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.steps = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmailSequencesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String steps,
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       steps = Value(steps);
  static Insertable<EmailSequenceRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? steps,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (steps != null) 'steps': steps,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmailSequencesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? steps,
    Value<bool?>? active,
    Value<int>? rowid,
  }) {
    return EmailSequencesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(steps.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailSequencesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('steps: $steps, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SequenceEnrollmentsTable extends SequenceEnrollments
    with TableInfo<$SequenceEnrollmentsTable, EnrollmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SequenceEnrollmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceIdMeta = const VerificationMeta(
    'sequenceId',
  );
  @override
  late final GeneratedColumn<String> sequenceId = GeneratedColumn<String>(
    'sequence_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextSendAtMeta = const VerificationMeta(
    'nextSendAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextSendAt = GeneratedColumn<DateTime>(
    'next_send_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    sequenceId,
    contactId,
    ownerId,
    step,
    nextSendAt,
    status,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sequence_enrollments';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnrollmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sequence_id')) {
      context.handle(
        _sequenceIdMeta,
        sequenceId.isAcceptableOrUnknown(data['sequence_id']!, _sequenceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('step')) {
      context.handle(
        _stepMeta,
        step.isAcceptableOrUnknown(data['step']!, _stepMeta),
      );
    } else if (isInserting) {
      context.missing(_stepMeta);
    }
    if (data.containsKey('next_send_at')) {
      context.handle(
        _nextSendAtMeta,
        nextSendAt.isAcceptableOrUnknown(
          data['next_send_at']!,
          _nextSendAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnrollmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnrollmentRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sequenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sequence_id'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      )!,
      nextSendAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_send_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SequenceEnrollmentsTable createAlias(String alias) {
    return $SequenceEnrollmentsTable(attachedDatabase, alias);
  }
}

class EnrollmentRow extends DataClass implements Insertable<EnrollmentRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String sequenceId;
  final String contactId;
  final String ownerId;
  final int step;
  final DateTime? nextSendAt;
  final String status;
  final String? lastError;
  const EnrollmentRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.sequenceId,
    required this.contactId,
    required this.ownerId,
    required this.step,
    this.nextSendAt,
    required this.status,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['sequence_id'] = Variable<String>(sequenceId);
    map['contact_id'] = Variable<String>(contactId);
    map['owner_id'] = Variable<String>(ownerId);
    map['step'] = Variable<int>(step);
    if (!nullToAbsent || nextSendAt != null) {
      map['next_send_at'] = Variable<DateTime>(nextSendAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SequenceEnrollmentsCompanion toCompanion(bool nullToAbsent) {
    return SequenceEnrollmentsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      sequenceId: Value(sequenceId),
      contactId: Value(contactId),
      ownerId: Value(ownerId),
      step: Value(step),
      nextSendAt: nextSendAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextSendAt),
      status: Value(status),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory EnrollmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnrollmentRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      sequenceId: serializer.fromJson<String>(json['sequenceId']),
      contactId: serializer.fromJson<String>(json['contactId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      step: serializer.fromJson<int>(json['step']),
      nextSendAt: serializer.fromJson<DateTime?>(json['nextSendAt']),
      status: serializer.fromJson<String>(json['status']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'sequenceId': serializer.toJson<String>(sequenceId),
      'contactId': serializer.toJson<String>(contactId),
      'ownerId': serializer.toJson<String>(ownerId),
      'step': serializer.toJson<int>(step),
      'nextSendAt': serializer.toJson<DateTime?>(nextSendAt),
      'status': serializer.toJson<String>(status),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  EnrollmentRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? sequenceId,
    String? contactId,
    String? ownerId,
    int? step,
    Value<DateTime?> nextSendAt = const Value.absent(),
    String? status,
    Value<String?> lastError = const Value.absent(),
  }) => EnrollmentRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    sequenceId: sequenceId ?? this.sequenceId,
    contactId: contactId ?? this.contactId,
    ownerId: ownerId ?? this.ownerId,
    step: step ?? this.step,
    nextSendAt: nextSendAt.present ? nextSendAt.value : this.nextSendAt,
    status: status ?? this.status,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  EnrollmentRow copyWithCompanion(SequenceEnrollmentsCompanion data) {
    return EnrollmentRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      sequenceId: data.sequenceId.present
          ? data.sequenceId.value
          : this.sequenceId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      step: data.step.present ? data.step.value : this.step,
      nextSendAt: data.nextSendAt.present
          ? data.nextSendAt.value
          : this.nextSendAt,
      status: data.status.present ? data.status.value : this.status,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sequenceId: $sequenceId, ')
          ..write('contactId: $contactId, ')
          ..write('ownerId: $ownerId, ')
          ..write('step: $step, ')
          ..write('nextSendAt: $nextSendAt, ')
          ..write('status: $status, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    sequenceId,
    contactId,
    ownerId,
    step,
    nextSendAt,
    status,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnrollmentRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.sequenceId == this.sequenceId &&
          other.contactId == this.contactId &&
          other.ownerId == this.ownerId &&
          other.step == this.step &&
          other.nextSendAt == this.nextSendAt &&
          other.status == this.status &&
          other.lastError == this.lastError);
}

class SequenceEnrollmentsCompanion extends UpdateCompanion<EnrollmentRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> sequenceId;
  final Value<String> contactId;
  final Value<String> ownerId;
  final Value<int> step;
  final Value<DateTime?> nextSendAt;
  final Value<String> status;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SequenceEnrollmentsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.sequenceId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.step = const Value.absent(),
    this.nextSendAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SequenceEnrollmentsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String sequenceId,
    required String contactId,
    required String ownerId,
    required int step,
    this.nextSendAt = const Value.absent(),
    required String status,
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       sequenceId = Value(sequenceId),
       contactId = Value(contactId),
       ownerId = Value(ownerId),
       step = Value(step),
       status = Value(status);
  static Insertable<EnrollmentRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? sequenceId,
    Expression<String>? contactId,
    Expression<String>? ownerId,
    Expression<int>? step,
    Expression<DateTime>? nextSendAt,
    Expression<String>? status,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (sequenceId != null) 'sequence_id': sequenceId,
      if (contactId != null) 'contact_id': contactId,
      if (ownerId != null) 'owner_id': ownerId,
      if (step != null) 'step': step,
      if (nextSendAt != null) 'next_send_at': nextSendAt,
      if (status != null) 'status': status,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SequenceEnrollmentsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? sequenceId,
    Value<String>? contactId,
    Value<String>? ownerId,
    Value<int>? step,
    Value<DateTime?>? nextSendAt,
    Value<String>? status,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SequenceEnrollmentsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      sequenceId: sequenceId ?? this.sequenceId,
      contactId: contactId ?? this.contactId,
      ownerId: ownerId ?? this.ownerId,
      step: step ?? this.step,
      nextSendAt: nextSendAt ?? this.nextSendAt,
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sequenceId.present) {
      map['sequence_id'] = Variable<String>(sequenceId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (nextSendAt.present) {
      map['next_send_at'] = Variable<DateTime>(nextSendAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SequenceEnrollmentsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sequenceId: $sequenceId, ')
          ..write('contactId: $contactId, ')
          ..write('ownerId: $ownerId, ')
          ..write('step: $step, ')
          ..write('nextSendAt: $nextSendAt, ')
          ..write('status: $status, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceCentsMeta = const VerificationMeta(
    'unitPriceCents',
  );
  @override
  late final GeneratedColumn<int> unitPriceCents = GeneratedColumn<int>(
    'unit_price_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vatRateMeta = const VerificationMeta(
    'vatRate',
  );
  @override
  late final GeneratedColumn<int> vatRate = GeneratedColumn<int>(
    'vat_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountCodeMeta = const VerificationMeta(
    'accountCode',
  );
  @override
  late final GeneratedColumn<String> accountCode = GeneratedColumn<String>(
    'account_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    description,
    unitPriceCents,
    vatRate,
    unit,
    accountCode,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('unit_price_cents')) {
      context.handle(
        _unitPriceCentsMeta,
        unitPriceCents.isAcceptableOrUnknown(
          data['unit_price_cents']!,
          _unitPriceCentsMeta,
        ),
      );
    }
    if (data.containsKey('vat_rate')) {
      context.handle(
        _vatRateMeta,
        vatRate.isAcceptableOrUnknown(data['vat_rate']!, _vatRateMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('account_code')) {
      context.handle(
        _accountCodeMeta,
        accountCode.isAcceptableOrUnknown(
          data['account_code']!,
          _accountCodeMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      unitPriceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_cents'],
      ),
      vatRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_rate'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      accountCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_code'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String? description;
  final int? unitPriceCents;
  final int? vatRate;
  final String? unit;
  final String? accountCode;
  final bool? active;
  const ProductRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.name,
    this.description,
    this.unitPriceCents,
    this.vatRate,
    this.unit,
    this.accountCode,
    this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || unitPriceCents != null) {
      map['unit_price_cents'] = Variable<int>(unitPriceCents);
    }
    if (!nullToAbsent || vatRate != null) {
      map['vat_rate'] = Variable<int>(vatRate);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || accountCode != null) {
      map['account_code'] = Variable<String>(accountCode);
    }
    if (!nullToAbsent || active != null) {
      map['active'] = Variable<bool>(active);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      unitPriceCents: unitPriceCents == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPriceCents),
      vatRate: vatRate == null && nullToAbsent
          ? const Value.absent()
          : Value(vatRate),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      accountCode: accountCode == null && nullToAbsent
          ? const Value.absent()
          : Value(accountCode),
      active: active == null && nullToAbsent
          ? const Value.absent()
          : Value(active),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      unitPriceCents: serializer.fromJson<int?>(json['unitPriceCents']),
      vatRate: serializer.fromJson<int?>(json['vatRate']),
      unit: serializer.fromJson<String?>(json['unit']),
      accountCode: serializer.fromJson<String?>(json['accountCode']),
      active: serializer.fromJson<bool?>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'unitPriceCents': serializer.toJson<int?>(unitPriceCents),
      'vatRate': serializer.toJson<int?>(vatRate),
      'unit': serializer.toJson<String?>(unit),
      'accountCode': serializer.toJson<String?>(accountCode),
      'active': serializer.toJson<bool?>(active),
    };
  }

  ProductRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<int?> unitPriceCents = const Value.absent(),
    Value<int?> vatRate = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<String?> accountCode = const Value.absent(),
    Value<bool?> active = const Value.absent(),
  }) => ProductRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    unitPriceCents: unitPriceCents.present
        ? unitPriceCents.value
        : this.unitPriceCents,
    vatRate: vatRate.present ? vatRate.value : this.vatRate,
    unit: unit.present ? unit.value : this.unit,
    accountCode: accountCode.present ? accountCode.value : this.accountCode,
    active: active.present ? active.value : this.active,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      unitPriceCents: data.unitPriceCents.present
          ? data.unitPriceCents.value
          : this.unitPriceCents,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      unit: data.unit.present ? data.unit.value : this.unit,
      accountCode: data.accountCode.present
          ? data.accountCode.value
          : this.accountCode,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitPriceCents: $unitPriceCents, ')
          ..write('vatRate: $vatRate, ')
          ..write('unit: $unit, ')
          ..write('accountCode: $accountCode, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    name,
    description,
    unitPriceCents,
    vatRate,
    unit,
    accountCode,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.unitPriceCents == this.unitPriceCents &&
          other.vatRate == this.vatRate &&
          other.unit == this.unit &&
          other.accountCode == this.accountCode &&
          other.active == this.active);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> unitPriceCents;
  final Value<int?> vatRate;
  final Value<String?> unit;
  final Value<String?> accountCode;
  final Value<bool?> active;
  final Value<int> rowid;
  const ProductsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.unitPriceCents = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.unit = const Value.absent(),
    this.accountCode = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.unitPriceCents = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.unit = const Value.absent(),
    this.accountCode = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name);
  static Insertable<ProductRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? unitPriceCents,
    Expression<int>? vatRate,
    Expression<String>? unit,
    Expression<String>? accountCode,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (unitPriceCents != null) 'unit_price_cents': unitPriceCents,
      if (vatRate != null) 'vat_rate': vatRate,
      if (unit != null) 'unit': unit,
      if (accountCode != null) 'account_code': accountCode,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int?>? unitPriceCents,
    Value<int?>? vatRate,
    Value<String?>? unit,
    Value<String?>? accountCode,
    Value<bool?>? active,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitPriceCents: unitPriceCents ?? this.unitPriceCents,
      vatRate: vatRate ?? this.vatRate,
      unit: unit ?? this.unit,
      accountCode: accountCode ?? this.accountCode,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unitPriceCents.present) {
      map['unit_price_cents'] = Variable<int>(unitPriceCents.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<int>(vatRate.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (accountCode.present) {
      map['account_code'] = Variable<String>(accountCode.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitPriceCents: $unitPriceCents, ')
          ..write('vatRate: $vatRate, ')
          ..write('unit: $unit, ')
          ..write('accountCode: $accountCode, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices
    with TableInfo<$InvoicesTable, InvoiceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _organisationIdMeta = const VerificationMeta(
    'organisationId',
  );
  @override
  late final GeneratedColumn<String> organisationId = GeneratedColumn<String>(
    'organisation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dealIdMeta = const VerificationMeta('dealId');
  @override
  late final GeneratedColumn<String> dealId = GeneratedColumn<String>(
    'deal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<String> quoteId = GeneratedColumn<String>(
    'quote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalInvoiceIdMeta = const VerificationMeta(
    'originalInvoiceId',
  );
  @override
  late final GeneratedColumn<String> originalInvoiceId =
      GeneratedColumn<String>(
        'original_invoice_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<String> issueDate = GeneratedColumn<String>(
    'issue_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<String> serviceDate = GeneratedColumn<String>(
    'service_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validUntilMeta = const VerificationMeta(
    'validUntil',
  );
  @override
  late final GeneratedColumn<String> validUntil = GeneratedColumn<String>(
    'valid_until',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linesMeta = const VerificationMeta('lines');
  @override
  late final GeneratedColumn<String> lines = GeneratedColumn<String>(
    'lines',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalHtCentsMeta = const VerificationMeta(
    'totalHtCents',
  );
  @override
  late final GeneratedColumn<int> totalHtCents = GeneratedColumn<int>(
    'total_ht_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalVatCentsMeta = const VerificationMeta(
    'totalVatCents',
  );
  @override
  late final GeneratedColumn<int> totalVatCents = GeneratedColumn<int>(
    'total_vat_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalTtcCentsMeta = const VerificationMeta(
    'totalTtcCents',
  );
  @override
  late final GeneratedColumn<int> totalTtcCents = GeneratedColumn<int>(
    'total_ttc_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vatBreakdownMeta = const VerificationMeta(
    'vatBreakdown',
  );
  @override
  late final GeneratedColumn<String> vatBreakdown = GeneratedColumn<String>(
    'vat_breakdown',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyerMeta = const VerificationMeta('buyer');
  @override
  late final GeneratedColumn<String> buyer = GeneratedColumn<String>(
    'buyer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sellerMeta = const VerificationMeta('seller');
  @override
  late final GeneratedColumn<String> seller = GeneratedColumn<String>(
    'seller',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentTermsMeta = const VerificationMeta(
    'paymentTerms',
  );
  @override
  late final GeneratedColumn<String> paymentTerms = GeneratedColumn<String>(
    'payment_terms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyerReferenceMeta = const VerificationMeta(
    'buyerReference',
  );
  @override
  late final GeneratedColumn<String> buyerReference = GeneratedColumn<String>(
    'buyer_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceCodeMeta = const VerificationMeta(
    'serviceCode',
  );
  @override
  late final GeneratedColumn<String> serviceCode = GeneratedColumn<String>(
    'service_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfFileIdMeta = const VerificationMeta(
    'pdfFileId',
  );
  @override
  late final GeneratedColumn<String> pdfFileId = GeneratedColumn<String>(
    'pdf_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chorusFluxMeta = const VerificationMeta(
    'chorusFlux',
  );
  @override
  late final GeneratedColumn<String> chorusFlux = GeneratedColumn<String>(
    'chorus_flux',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chorusStatusMeta = const VerificationMeta(
    'chorusStatus',
  );
  @override
  late final GeneratedColumn<String> chorusStatus = GeneratedColumn<String>(
    'chorus_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    kind,
    status,
    number,
    subject,
    organisationId,
    contactId,
    dealId,
    quoteId,
    originalInvoiceId,
    issueDate,
    serviceDate,
    dueDate,
    validUntil,
    lines,
    totalHtCents,
    totalVatCents,
    totalTtcCents,
    vatBreakdown,
    buyer,
    seller,
    notes,
    paymentTerms,
    buyerReference,
    serviceCode,
    pdfFileId,
    chorusFlux,
    chorusStatus,
    sentAt,
    ownerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('organisation_id')) {
      context.handle(
        _organisationIdMeta,
        organisationId.isAcceptableOrUnknown(
          data['organisation_id']!,
          _organisationIdMeta,
        ),
      );
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('deal_id')) {
      context.handle(
        _dealIdMeta,
        dealId.isAcceptableOrUnknown(data['deal_id']!, _dealIdMeta),
      );
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    }
    if (data.containsKey('original_invoice_id')) {
      context.handle(
        _originalInvoiceIdMeta,
        originalInvoiceId.isAcceptableOrUnknown(
          data['original_invoice_id']!,
          _originalInvoiceIdMeta,
        ),
      );
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    }
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('valid_until')) {
      context.handle(
        _validUntilMeta,
        validUntil.isAcceptableOrUnknown(data['valid_until']!, _validUntilMeta),
      );
    }
    if (data.containsKey('lines')) {
      context.handle(
        _linesMeta,
        lines.isAcceptableOrUnknown(data['lines']!, _linesMeta),
      );
    } else if (isInserting) {
      context.missing(_linesMeta);
    }
    if (data.containsKey('total_ht_cents')) {
      context.handle(
        _totalHtCentsMeta,
        totalHtCents.isAcceptableOrUnknown(
          data['total_ht_cents']!,
          _totalHtCentsMeta,
        ),
      );
    }
    if (data.containsKey('total_vat_cents')) {
      context.handle(
        _totalVatCentsMeta,
        totalVatCents.isAcceptableOrUnknown(
          data['total_vat_cents']!,
          _totalVatCentsMeta,
        ),
      );
    }
    if (data.containsKey('total_ttc_cents')) {
      context.handle(
        _totalTtcCentsMeta,
        totalTtcCents.isAcceptableOrUnknown(
          data['total_ttc_cents']!,
          _totalTtcCentsMeta,
        ),
      );
    }
    if (data.containsKey('vat_breakdown')) {
      context.handle(
        _vatBreakdownMeta,
        vatBreakdown.isAcceptableOrUnknown(
          data['vat_breakdown']!,
          _vatBreakdownMeta,
        ),
      );
    }
    if (data.containsKey('buyer')) {
      context.handle(
        _buyerMeta,
        buyer.isAcceptableOrUnknown(data['buyer']!, _buyerMeta),
      );
    }
    if (data.containsKey('seller')) {
      context.handle(
        _sellerMeta,
        seller.isAcceptableOrUnknown(data['seller']!, _sellerMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('payment_terms')) {
      context.handle(
        _paymentTermsMeta,
        paymentTerms.isAcceptableOrUnknown(
          data['payment_terms']!,
          _paymentTermsMeta,
        ),
      );
    }
    if (data.containsKey('buyer_reference')) {
      context.handle(
        _buyerReferenceMeta,
        buyerReference.isAcceptableOrUnknown(
          data['buyer_reference']!,
          _buyerReferenceMeta,
        ),
      );
    }
    if (data.containsKey('service_code')) {
      context.handle(
        _serviceCodeMeta,
        serviceCode.isAcceptableOrUnknown(
          data['service_code']!,
          _serviceCodeMeta,
        ),
      );
    }
    if (data.containsKey('pdf_file_id')) {
      context.handle(
        _pdfFileIdMeta,
        pdfFileId.isAcceptableOrUnknown(data['pdf_file_id']!, _pdfFileIdMeta),
      );
    }
    if (data.containsKey('chorus_flux')) {
      context.handle(
        _chorusFluxMeta,
        chorusFlux.isAcceptableOrUnknown(data['chorus_flux']!, _chorusFluxMeta),
      );
    }
    if (data.containsKey('chorus_status')) {
      context.handle(
        _chorusStatusMeta,
        chorusStatus.isAcceptableOrUnknown(
          data['chorus_status']!,
          _chorusStatusMeta,
        ),
      );
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      organisationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation_id'],
      ),
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      dealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deal_id'],
      ),
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      ),
      originalInvoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_invoice_id'],
      ),
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issue_date'],
      ),
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_date'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      validUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valid_until'],
      ),
      lines: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lines'],
      )!,
      totalHtCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ht_cents'],
      ),
      totalVatCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_vat_cents'],
      ),
      totalTtcCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ttc_cents'],
      ),
      vatBreakdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_breakdown'],
      ),
      buyer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buyer'],
      ),
      seller: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      paymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_terms'],
      ),
      buyerReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buyer_reference'],
      ),
      serviceCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_code'],
      ),
      pdfFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_file_id'],
      ),
      chorusFlux: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chorus_flux'],
      ),
      chorusStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chorus_status'],
      ),
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class InvoiceRow extends DataClass implements Insertable<InvoiceRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String kind;
  final String status;
  final String? number;
  final String? subject;
  final String? organisationId;
  final String? contactId;
  final String? dealId;
  final String? quoteId;
  final String? originalInvoiceId;
  final String? issueDate;
  final String? serviceDate;
  final String? dueDate;
  final String? validUntil;
  final String lines;
  final int? totalHtCents;
  final int? totalVatCents;
  final int? totalTtcCents;
  final String? vatBreakdown;
  final String? buyer;
  final String? seller;
  final String? notes;
  final String? paymentTerms;
  final String? buyerReference;
  final String? serviceCode;
  final String? pdfFileId;
  final String? chorusFlux;
  final String? chorusStatus;
  final DateTime? sentAt;
  final String? ownerId;
  const InvoiceRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.kind,
    required this.status,
    this.number,
    this.subject,
    this.organisationId,
    this.contactId,
    this.dealId,
    this.quoteId,
    this.originalInvoiceId,
    this.issueDate,
    this.serviceDate,
    this.dueDate,
    this.validUntil,
    required this.lines,
    this.totalHtCents,
    this.totalVatCents,
    this.totalTtcCents,
    this.vatBreakdown,
    this.buyer,
    this.seller,
    this.notes,
    this.paymentTerms,
    this.buyerReference,
    this.serviceCode,
    this.pdfFileId,
    this.chorusFlux,
    this.chorusStatus,
    this.sentAt,
    this.ownerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['kind'] = Variable<String>(kind);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || organisationId != null) {
      map['organisation_id'] = Variable<String>(organisationId);
    }
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || dealId != null) {
      map['deal_id'] = Variable<String>(dealId);
    }
    if (!nullToAbsent || quoteId != null) {
      map['quote_id'] = Variable<String>(quoteId);
    }
    if (!nullToAbsent || originalInvoiceId != null) {
      map['original_invoice_id'] = Variable<String>(originalInvoiceId);
    }
    if (!nullToAbsent || issueDate != null) {
      map['issue_date'] = Variable<String>(issueDate);
    }
    if (!nullToAbsent || serviceDate != null) {
      map['service_date'] = Variable<String>(serviceDate);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    if (!nullToAbsent || validUntil != null) {
      map['valid_until'] = Variable<String>(validUntil);
    }
    map['lines'] = Variable<String>(lines);
    if (!nullToAbsent || totalHtCents != null) {
      map['total_ht_cents'] = Variable<int>(totalHtCents);
    }
    if (!nullToAbsent || totalVatCents != null) {
      map['total_vat_cents'] = Variable<int>(totalVatCents);
    }
    if (!nullToAbsent || totalTtcCents != null) {
      map['total_ttc_cents'] = Variable<int>(totalTtcCents);
    }
    if (!nullToAbsent || vatBreakdown != null) {
      map['vat_breakdown'] = Variable<String>(vatBreakdown);
    }
    if (!nullToAbsent || buyer != null) {
      map['buyer'] = Variable<String>(buyer);
    }
    if (!nullToAbsent || seller != null) {
      map['seller'] = Variable<String>(seller);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || paymentTerms != null) {
      map['payment_terms'] = Variable<String>(paymentTerms);
    }
    if (!nullToAbsent || buyerReference != null) {
      map['buyer_reference'] = Variable<String>(buyerReference);
    }
    if (!nullToAbsent || serviceCode != null) {
      map['service_code'] = Variable<String>(serviceCode);
    }
    if (!nullToAbsent || pdfFileId != null) {
      map['pdf_file_id'] = Variable<String>(pdfFileId);
    }
    if (!nullToAbsent || chorusFlux != null) {
      map['chorus_flux'] = Variable<String>(chorusFlux);
    }
    if (!nullToAbsent || chorusStatus != null) {
      map['chorus_status'] = Variable<String>(chorusStatus);
    }
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      kind: Value(kind),
      status: Value(status),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      organisationId: organisationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organisationId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      dealId: dealId == null && nullToAbsent
          ? const Value.absent()
          : Value(dealId),
      quoteId: quoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(quoteId),
      originalInvoiceId: originalInvoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalInvoiceId),
      issueDate: issueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(issueDate),
      serviceDate: serviceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      validUntil: validUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(validUntil),
      lines: Value(lines),
      totalHtCents: totalHtCents == null && nullToAbsent
          ? const Value.absent()
          : Value(totalHtCents),
      totalVatCents: totalVatCents == null && nullToAbsent
          ? const Value.absent()
          : Value(totalVatCents),
      totalTtcCents: totalTtcCents == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTtcCents),
      vatBreakdown: vatBreakdown == null && nullToAbsent
          ? const Value.absent()
          : Value(vatBreakdown),
      buyer: buyer == null && nullToAbsent
          ? const Value.absent()
          : Value(buyer),
      seller: seller == null && nullToAbsent
          ? const Value.absent()
          : Value(seller),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      paymentTerms: paymentTerms == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTerms),
      buyerReference: buyerReference == null && nullToAbsent
          ? const Value.absent()
          : Value(buyerReference),
      serviceCode: serviceCode == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCode),
      pdfFileId: pdfFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFileId),
      chorusFlux: chorusFlux == null && nullToAbsent
          ? const Value.absent()
          : Value(chorusFlux),
      chorusStatus: chorusStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(chorusStatus),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
    );
  }

  factory InvoiceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      status: serializer.fromJson<String>(json['status']),
      number: serializer.fromJson<String?>(json['number']),
      subject: serializer.fromJson<String?>(json['subject']),
      organisationId: serializer.fromJson<String?>(json['organisationId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      dealId: serializer.fromJson<String?>(json['dealId']),
      quoteId: serializer.fromJson<String?>(json['quoteId']),
      originalInvoiceId: serializer.fromJson<String?>(
        json['originalInvoiceId'],
      ),
      issueDate: serializer.fromJson<String?>(json['issueDate']),
      serviceDate: serializer.fromJson<String?>(json['serviceDate']),
      dueDate: serializer.fromJson<String?>(json['dueDate']),
      validUntil: serializer.fromJson<String?>(json['validUntil']),
      lines: serializer.fromJson<String>(json['lines']),
      totalHtCents: serializer.fromJson<int?>(json['totalHtCents']),
      totalVatCents: serializer.fromJson<int?>(json['totalVatCents']),
      totalTtcCents: serializer.fromJson<int?>(json['totalTtcCents']),
      vatBreakdown: serializer.fromJson<String?>(json['vatBreakdown']),
      buyer: serializer.fromJson<String?>(json['buyer']),
      seller: serializer.fromJson<String?>(json['seller']),
      notes: serializer.fromJson<String?>(json['notes']),
      paymentTerms: serializer.fromJson<String?>(json['paymentTerms']),
      buyerReference: serializer.fromJson<String?>(json['buyerReference']),
      serviceCode: serializer.fromJson<String?>(json['serviceCode']),
      pdfFileId: serializer.fromJson<String?>(json['pdfFileId']),
      chorusFlux: serializer.fromJson<String?>(json['chorusFlux']),
      chorusStatus: serializer.fromJson<String?>(json['chorusStatus']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(kind),
      'status': serializer.toJson<String>(status),
      'number': serializer.toJson<String?>(number),
      'subject': serializer.toJson<String?>(subject),
      'organisationId': serializer.toJson<String?>(organisationId),
      'contactId': serializer.toJson<String?>(contactId),
      'dealId': serializer.toJson<String?>(dealId),
      'quoteId': serializer.toJson<String?>(quoteId),
      'originalInvoiceId': serializer.toJson<String?>(originalInvoiceId),
      'issueDate': serializer.toJson<String?>(issueDate),
      'serviceDate': serializer.toJson<String?>(serviceDate),
      'dueDate': serializer.toJson<String?>(dueDate),
      'validUntil': serializer.toJson<String?>(validUntil),
      'lines': serializer.toJson<String>(lines),
      'totalHtCents': serializer.toJson<int?>(totalHtCents),
      'totalVatCents': serializer.toJson<int?>(totalVatCents),
      'totalTtcCents': serializer.toJson<int?>(totalTtcCents),
      'vatBreakdown': serializer.toJson<String?>(vatBreakdown),
      'buyer': serializer.toJson<String?>(buyer),
      'seller': serializer.toJson<String?>(seller),
      'notes': serializer.toJson<String?>(notes),
      'paymentTerms': serializer.toJson<String?>(paymentTerms),
      'buyerReference': serializer.toJson<String?>(buyerReference),
      'serviceCode': serializer.toJson<String?>(serviceCode),
      'pdfFileId': serializer.toJson<String?>(pdfFileId),
      'chorusFlux': serializer.toJson<String?>(chorusFlux),
      'chorusStatus': serializer.toJson<String?>(chorusStatus),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'ownerId': serializer.toJson<String?>(ownerId),
    };
  }

  InvoiceRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? kind,
    String? status,
    Value<String?> number = const Value.absent(),
    Value<String?> subject = const Value.absent(),
    Value<String?> organisationId = const Value.absent(),
    Value<String?> contactId = const Value.absent(),
    Value<String?> dealId = const Value.absent(),
    Value<String?> quoteId = const Value.absent(),
    Value<String?> originalInvoiceId = const Value.absent(),
    Value<String?> issueDate = const Value.absent(),
    Value<String?> serviceDate = const Value.absent(),
    Value<String?> dueDate = const Value.absent(),
    Value<String?> validUntil = const Value.absent(),
    String? lines,
    Value<int?> totalHtCents = const Value.absent(),
    Value<int?> totalVatCents = const Value.absent(),
    Value<int?> totalTtcCents = const Value.absent(),
    Value<String?> vatBreakdown = const Value.absent(),
    Value<String?> buyer = const Value.absent(),
    Value<String?> seller = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> paymentTerms = const Value.absent(),
    Value<String?> buyerReference = const Value.absent(),
    Value<String?> serviceCode = const Value.absent(),
    Value<String?> pdfFileId = const Value.absent(),
    Value<String?> chorusFlux = const Value.absent(),
    Value<String?> chorusStatus = const Value.absent(),
    Value<DateTime?> sentAt = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
  }) => InvoiceRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    kind: kind ?? this.kind,
    status: status ?? this.status,
    number: number.present ? number.value : this.number,
    subject: subject.present ? subject.value : this.subject,
    organisationId: organisationId.present
        ? organisationId.value
        : this.organisationId,
    contactId: contactId.present ? contactId.value : this.contactId,
    dealId: dealId.present ? dealId.value : this.dealId,
    quoteId: quoteId.present ? quoteId.value : this.quoteId,
    originalInvoiceId: originalInvoiceId.present
        ? originalInvoiceId.value
        : this.originalInvoiceId,
    issueDate: issueDate.present ? issueDate.value : this.issueDate,
    serviceDate: serviceDate.present ? serviceDate.value : this.serviceDate,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    validUntil: validUntil.present ? validUntil.value : this.validUntil,
    lines: lines ?? this.lines,
    totalHtCents: totalHtCents.present ? totalHtCents.value : this.totalHtCents,
    totalVatCents: totalVatCents.present
        ? totalVatCents.value
        : this.totalVatCents,
    totalTtcCents: totalTtcCents.present
        ? totalTtcCents.value
        : this.totalTtcCents,
    vatBreakdown: vatBreakdown.present ? vatBreakdown.value : this.vatBreakdown,
    buyer: buyer.present ? buyer.value : this.buyer,
    seller: seller.present ? seller.value : this.seller,
    notes: notes.present ? notes.value : this.notes,
    paymentTerms: paymentTerms.present ? paymentTerms.value : this.paymentTerms,
    buyerReference: buyerReference.present
        ? buyerReference.value
        : this.buyerReference,
    serviceCode: serviceCode.present ? serviceCode.value : this.serviceCode,
    pdfFileId: pdfFileId.present ? pdfFileId.value : this.pdfFileId,
    chorusFlux: chorusFlux.present ? chorusFlux.value : this.chorusFlux,
    chorusStatus: chorusStatus.present ? chorusStatus.value : this.chorusStatus,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
  );
  InvoiceRow copyWithCompanion(InvoicesCompanion data) {
    return InvoiceRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      status: data.status.present ? data.status.value : this.status,
      number: data.number.present ? data.number.value : this.number,
      subject: data.subject.present ? data.subject.value : this.subject,
      organisationId: data.organisationId.present
          ? data.organisationId.value
          : this.organisationId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      dealId: data.dealId.present ? data.dealId.value : this.dealId,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      originalInvoiceId: data.originalInvoiceId.present
          ? data.originalInvoiceId.value
          : this.originalInvoiceId,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      validUntil: data.validUntil.present
          ? data.validUntil.value
          : this.validUntil,
      lines: data.lines.present ? data.lines.value : this.lines,
      totalHtCents: data.totalHtCents.present
          ? data.totalHtCents.value
          : this.totalHtCents,
      totalVatCents: data.totalVatCents.present
          ? data.totalVatCents.value
          : this.totalVatCents,
      totalTtcCents: data.totalTtcCents.present
          ? data.totalTtcCents.value
          : this.totalTtcCents,
      vatBreakdown: data.vatBreakdown.present
          ? data.vatBreakdown.value
          : this.vatBreakdown,
      buyer: data.buyer.present ? data.buyer.value : this.buyer,
      seller: data.seller.present ? data.seller.value : this.seller,
      notes: data.notes.present ? data.notes.value : this.notes,
      paymentTerms: data.paymentTerms.present
          ? data.paymentTerms.value
          : this.paymentTerms,
      buyerReference: data.buyerReference.present
          ? data.buyerReference.value
          : this.buyerReference,
      serviceCode: data.serviceCode.present
          ? data.serviceCode.value
          : this.serviceCode,
      pdfFileId: data.pdfFileId.present ? data.pdfFileId.value : this.pdfFileId,
      chorusFlux: data.chorusFlux.present
          ? data.chorusFlux.value
          : this.chorusFlux,
      chorusStatus: data.chorusStatus.present
          ? data.chorusStatus.value
          : this.chorusStatus,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('number: $number, ')
          ..write('subject: $subject, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('quoteId: $quoteId, ')
          ..write('originalInvoiceId: $originalInvoiceId, ')
          ..write('issueDate: $issueDate, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('validUntil: $validUntil, ')
          ..write('lines: $lines, ')
          ..write('totalHtCents: $totalHtCents, ')
          ..write('totalVatCents: $totalVatCents, ')
          ..write('totalTtcCents: $totalTtcCents, ')
          ..write('vatBreakdown: $vatBreakdown, ')
          ..write('buyer: $buyer, ')
          ..write('seller: $seller, ')
          ..write('notes: $notes, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('buyerReference: $buyerReference, ')
          ..write('serviceCode: $serviceCode, ')
          ..write('pdfFileId: $pdfFileId, ')
          ..write('chorusFlux: $chorusFlux, ')
          ..write('chorusStatus: $chorusStatus, ')
          ..write('sentAt: $sentAt, ')
          ..write('ownerId: $ownerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    kind,
    status,
    number,
    subject,
    organisationId,
    contactId,
    dealId,
    quoteId,
    originalInvoiceId,
    issueDate,
    serviceDate,
    dueDate,
    validUntil,
    lines,
    totalHtCents,
    totalVatCents,
    totalTtcCents,
    vatBreakdown,
    buyer,
    seller,
    notes,
    paymentTerms,
    buyerReference,
    serviceCode,
    pdfFileId,
    chorusFlux,
    chorusStatus,
    sentAt,
    ownerId,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.status == this.status &&
          other.number == this.number &&
          other.subject == this.subject &&
          other.organisationId == this.organisationId &&
          other.contactId == this.contactId &&
          other.dealId == this.dealId &&
          other.quoteId == this.quoteId &&
          other.originalInvoiceId == this.originalInvoiceId &&
          other.issueDate == this.issueDate &&
          other.serviceDate == this.serviceDate &&
          other.dueDate == this.dueDate &&
          other.validUntil == this.validUntil &&
          other.lines == this.lines &&
          other.totalHtCents == this.totalHtCents &&
          other.totalVatCents == this.totalVatCents &&
          other.totalTtcCents == this.totalTtcCents &&
          other.vatBreakdown == this.vatBreakdown &&
          other.buyer == this.buyer &&
          other.seller == this.seller &&
          other.notes == this.notes &&
          other.paymentTerms == this.paymentTerms &&
          other.buyerReference == this.buyerReference &&
          other.serviceCode == this.serviceCode &&
          other.pdfFileId == this.pdfFileId &&
          other.chorusFlux == this.chorusFlux &&
          other.chorusStatus == this.chorusStatus &&
          other.sentAt == this.sentAt &&
          other.ownerId == this.ownerId);
}

class InvoicesCompanion extends UpdateCompanion<InvoiceRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> kind;
  final Value<String> status;
  final Value<String?> number;
  final Value<String?> subject;
  final Value<String?> organisationId;
  final Value<String?> contactId;
  final Value<String?> dealId;
  final Value<String?> quoteId;
  final Value<String?> originalInvoiceId;
  final Value<String?> issueDate;
  final Value<String?> serviceDate;
  final Value<String?> dueDate;
  final Value<String?> validUntil;
  final Value<String> lines;
  final Value<int?> totalHtCents;
  final Value<int?> totalVatCents;
  final Value<int?> totalTtcCents;
  final Value<String?> vatBreakdown;
  final Value<String?> buyer;
  final Value<String?> seller;
  final Value<String?> notes;
  final Value<String?> paymentTerms;
  final Value<String?> buyerReference;
  final Value<String?> serviceCode;
  final Value<String?> pdfFileId;
  final Value<String?> chorusFlux;
  final Value<String?> chorusStatus;
  final Value<DateTime?> sentAt;
  final Value<String?> ownerId;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.status = const Value.absent(),
    this.number = const Value.absent(),
    this.subject = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.originalInvoiceId = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.validUntil = const Value.absent(),
    this.lines = const Value.absent(),
    this.totalHtCents = const Value.absent(),
    this.totalVatCents = const Value.absent(),
    this.totalTtcCents = const Value.absent(),
    this.vatBreakdown = const Value.absent(),
    this.buyer = const Value.absent(),
    this.seller = const Value.absent(),
    this.notes = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.buyerReference = const Value.absent(),
    this.serviceCode = const Value.absent(),
    this.pdfFileId = const Value.absent(),
    this.chorusFlux = const Value.absent(),
    this.chorusStatus = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String kind,
    required String status,
    this.number = const Value.absent(),
    this.subject = const Value.absent(),
    this.organisationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.dealId = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.originalInvoiceId = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.validUntil = const Value.absent(),
    required String lines,
    this.totalHtCents = const Value.absent(),
    this.totalVatCents = const Value.absent(),
    this.totalTtcCents = const Value.absent(),
    this.vatBreakdown = const Value.absent(),
    this.buyer = const Value.absent(),
    this.seller = const Value.absent(),
    this.notes = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.buyerReference = const Value.absent(),
    this.serviceCode = const Value.absent(),
    this.pdfFileId = const Value.absent(),
    this.chorusFlux = const Value.absent(),
    this.chorusStatus = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       kind = Value(kind),
       status = Value(status),
       lines = Value(lines);
  static Insertable<InvoiceRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? kind,
    Expression<String>? status,
    Expression<String>? number,
    Expression<String>? subject,
    Expression<String>? organisationId,
    Expression<String>? contactId,
    Expression<String>? dealId,
    Expression<String>? quoteId,
    Expression<String>? originalInvoiceId,
    Expression<String>? issueDate,
    Expression<String>? serviceDate,
    Expression<String>? dueDate,
    Expression<String>? validUntil,
    Expression<String>? lines,
    Expression<int>? totalHtCents,
    Expression<int>? totalVatCents,
    Expression<int>? totalTtcCents,
    Expression<String>? vatBreakdown,
    Expression<String>? buyer,
    Expression<String>? seller,
    Expression<String>? notes,
    Expression<String>? paymentTerms,
    Expression<String>? buyerReference,
    Expression<String>? serviceCode,
    Expression<String>? pdfFileId,
    Expression<String>? chorusFlux,
    Expression<String>? chorusStatus,
    Expression<DateTime>? sentAt,
    Expression<String>? ownerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (status != null) 'status': status,
      if (number != null) 'number': number,
      if (subject != null) 'subject': subject,
      if (organisationId != null) 'organisation_id': organisationId,
      if (contactId != null) 'contact_id': contactId,
      if (dealId != null) 'deal_id': dealId,
      if (quoteId != null) 'quote_id': quoteId,
      if (originalInvoiceId != null) 'original_invoice_id': originalInvoiceId,
      if (issueDate != null) 'issue_date': issueDate,
      if (serviceDate != null) 'service_date': serviceDate,
      if (dueDate != null) 'due_date': dueDate,
      if (validUntil != null) 'valid_until': validUntil,
      if (lines != null) 'lines': lines,
      if (totalHtCents != null) 'total_ht_cents': totalHtCents,
      if (totalVatCents != null) 'total_vat_cents': totalVatCents,
      if (totalTtcCents != null) 'total_ttc_cents': totalTtcCents,
      if (vatBreakdown != null) 'vat_breakdown': vatBreakdown,
      if (buyer != null) 'buyer': buyer,
      if (seller != null) 'seller': seller,
      if (notes != null) 'notes': notes,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (buyerReference != null) 'buyer_reference': buyerReference,
      if (serviceCode != null) 'service_code': serviceCode,
      if (pdfFileId != null) 'pdf_file_id': pdfFileId,
      if (chorusFlux != null) 'chorus_flux': chorusFlux,
      if (chorusStatus != null) 'chorus_status': chorusStatus,
      if (sentAt != null) 'sent_at': sentAt,
      if (ownerId != null) 'owner_id': ownerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? kind,
    Value<String>? status,
    Value<String?>? number,
    Value<String?>? subject,
    Value<String?>? organisationId,
    Value<String?>? contactId,
    Value<String?>? dealId,
    Value<String?>? quoteId,
    Value<String?>? originalInvoiceId,
    Value<String?>? issueDate,
    Value<String?>? serviceDate,
    Value<String?>? dueDate,
    Value<String?>? validUntil,
    Value<String>? lines,
    Value<int?>? totalHtCents,
    Value<int?>? totalVatCents,
    Value<int?>? totalTtcCents,
    Value<String?>? vatBreakdown,
    Value<String?>? buyer,
    Value<String?>? seller,
    Value<String?>? notes,
    Value<String?>? paymentTerms,
    Value<String?>? buyerReference,
    Value<String?>? serviceCode,
    Value<String?>? pdfFileId,
    Value<String?>? chorusFlux,
    Value<String?>? chorusStatus,
    Value<DateTime?>? sentAt,
    Value<String?>? ownerId,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      number: number ?? this.number,
      subject: subject ?? this.subject,
      organisationId: organisationId ?? this.organisationId,
      contactId: contactId ?? this.contactId,
      dealId: dealId ?? this.dealId,
      quoteId: quoteId ?? this.quoteId,
      originalInvoiceId: originalInvoiceId ?? this.originalInvoiceId,
      issueDate: issueDate ?? this.issueDate,
      serviceDate: serviceDate ?? this.serviceDate,
      dueDate: dueDate ?? this.dueDate,
      validUntil: validUntil ?? this.validUntil,
      lines: lines ?? this.lines,
      totalHtCents: totalHtCents ?? this.totalHtCents,
      totalVatCents: totalVatCents ?? this.totalVatCents,
      totalTtcCents: totalTtcCents ?? this.totalTtcCents,
      vatBreakdown: vatBreakdown ?? this.vatBreakdown,
      buyer: buyer ?? this.buyer,
      seller: seller ?? this.seller,
      notes: notes ?? this.notes,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      buyerReference: buyerReference ?? this.buyerReference,
      serviceCode: serviceCode ?? this.serviceCode,
      pdfFileId: pdfFileId ?? this.pdfFileId,
      chorusFlux: chorusFlux ?? this.chorusFlux,
      chorusStatus: chorusStatus ?? this.chorusStatus,
      sentAt: sentAt ?? this.sentAt,
      ownerId: ownerId ?? this.ownerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (organisationId.present) {
      map['organisation_id'] = Variable<String>(organisationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (dealId.present) {
      map['deal_id'] = Variable<String>(dealId.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (originalInvoiceId.present) {
      map['original_invoice_id'] = Variable<String>(originalInvoiceId.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<String>(issueDate.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<String>(serviceDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (validUntil.present) {
      map['valid_until'] = Variable<String>(validUntil.value);
    }
    if (lines.present) {
      map['lines'] = Variable<String>(lines.value);
    }
    if (totalHtCents.present) {
      map['total_ht_cents'] = Variable<int>(totalHtCents.value);
    }
    if (totalVatCents.present) {
      map['total_vat_cents'] = Variable<int>(totalVatCents.value);
    }
    if (totalTtcCents.present) {
      map['total_ttc_cents'] = Variable<int>(totalTtcCents.value);
    }
    if (vatBreakdown.present) {
      map['vat_breakdown'] = Variable<String>(vatBreakdown.value);
    }
    if (buyer.present) {
      map['buyer'] = Variable<String>(buyer.value);
    }
    if (seller.present) {
      map['seller'] = Variable<String>(seller.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(paymentTerms.value);
    }
    if (buyerReference.present) {
      map['buyer_reference'] = Variable<String>(buyerReference.value);
    }
    if (serviceCode.present) {
      map['service_code'] = Variable<String>(serviceCode.value);
    }
    if (pdfFileId.present) {
      map['pdf_file_id'] = Variable<String>(pdfFileId.value);
    }
    if (chorusFlux.present) {
      map['chorus_flux'] = Variable<String>(chorusFlux.value);
    }
    if (chorusStatus.present) {
      map['chorus_status'] = Variable<String>(chorusStatus.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('number: $number, ')
          ..write('subject: $subject, ')
          ..write('organisationId: $organisationId, ')
          ..write('contactId: $contactId, ')
          ..write('dealId: $dealId, ')
          ..write('quoteId: $quoteId, ')
          ..write('originalInvoiceId: $originalInvoiceId, ')
          ..write('issueDate: $issueDate, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('validUntil: $validUntil, ')
          ..write('lines: $lines, ')
          ..write('totalHtCents: $totalHtCents, ')
          ..write('totalVatCents: $totalVatCents, ')
          ..write('totalTtcCents: $totalTtcCents, ')
          ..write('vatBreakdown: $vatBreakdown, ')
          ..write('buyer: $buyer, ')
          ..write('seller: $seller, ')
          ..write('notes: $notes, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('buyerReference: $buyerReference, ')
          ..write('serviceCode: $serviceCode, ')
          ..write('pdfFileId: $pdfFileId, ')
          ..write('chorusFlux: $chorusFlux, ')
          ..write('chorusStatus: $chorusStatus, ')
          ..write('sentAt: $sentAt, ')
          ..write('ownerId: $ownerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fieldMetaMeta = const VerificationMeta(
    'fieldMeta',
  );
  @override
  late final GeneratedColumn<String> fieldMeta = GeneratedColumn<String>(
    'field_meta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidOnMeta = const VerificationMeta('paidOn');
  @override
  late final GeneratedColumn<String> paidOn = GeneratedColumn<String>(
    'paid_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    invoiceId,
    amountCents,
    paidOn,
    method,
    reference,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('field_meta')) {
      context.handle(
        _fieldMetaMeta,
        fieldMeta.isAcceptableOrUnknown(data['field_meta']!, _fieldMetaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('paid_on')) {
      context.handle(
        _paidOnMeta,
        paidOn.isAcceptableOrUnknown(data['paid_on']!, _paidOnMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fieldMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_meta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      paidOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_on'],
      ),
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      ),
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final int version;
  final String fieldMeta;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final String invoiceId;
  final int amountCents;
  final String? paidOn;
  final String? method;
  final String? reference;
  final String? notes;
  const PaymentRow({
    required this.version,
    required this.fieldMeta,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.invoiceId,
    required this.amountCents,
    this.paidOn,
    this.method,
    this.reference,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['field_meta'] = Variable<String>(fieldMeta);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || paidOn != null) {
      map['paid_on'] = Variable<String>(paidOn);
    }
    if (!nullToAbsent || method != null) {
      map['method'] = Variable<String>(method);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      version: Value(version),
      fieldMeta: Value(fieldMeta),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedAt: Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      invoiceId: Value(invoiceId),
      amountCents: Value(amountCents),
      paidOn: paidOn == null && nullToAbsent
          ? const Value.absent()
          : Value(paidOn),
      method: method == null && nullToAbsent
          ? const Value.absent()
          : Value(method),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      version: serializer.fromJson<int>(json['version']),
      fieldMeta: serializer.fromJson<String>(json['fieldMeta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      paidOn: serializer.fromJson<String?>(json['paidOn']),
      method: serializer.fromJson<String?>(json['method']),
      reference: serializer.fromJson<String?>(json['reference']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'fieldMeta': serializer.toJson<String>(fieldMeta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'amountCents': serializer.toJson<int>(amountCents),
      'paidOn': serializer.toJson<String?>(paidOn),
      'method': serializer.toJson<String?>(method),
      'reference': serializer.toJson<String?>(reference),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PaymentRow copyWith({
    int? version,
    String? fieldMeta,
    DateTime? createdAt,
    Value<String?> createdBy = const Value.absent(),
    DateTime? updatedAt,
    Value<String?> updatedBy = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? invoiceId,
    int? amountCents,
    Value<String?> paidOn = const Value.absent(),
    Value<String?> method = const Value.absent(),
    Value<String?> reference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PaymentRow(
    version: version ?? this.version,
    fieldMeta: fieldMeta ?? this.fieldMeta,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    amountCents: amountCents ?? this.amountCents,
    paidOn: paidOn.present ? paidOn.value : this.paidOn,
    method: method.present ? method.value : this.method,
    reference: reference.present ? reference.value : this.reference,
    notes: notes.present ? notes.value : this.notes,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      version: data.version.present ? data.version.value : this.version,
      fieldMeta: data.fieldMeta.present ? data.fieldMeta.value : this.fieldMeta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      paidOn: data.paidOn.present ? data.paidOn.value : this.paidOn,
      method: data.method.present ? data.method.value : this.method,
      reference: data.reference.present ? data.reference.value : this.reference,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidOn: $paidOn, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
    deletedAt,
    id,
    invoiceId,
    amountCents,
    paidOn,
    method,
    reference,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.version == this.version &&
          other.fieldMeta == this.fieldMeta &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.amountCents == this.amountCents &&
          other.paidOn == this.paidOn &&
          other.method == this.method &&
          other.reference == this.reference &&
          other.notes == this.notes);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<int> version;
  final Value<String> fieldMeta;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  final Value<DateTime> updatedAt;
  final Value<String?> updatedBy;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<int> amountCents;
  final Value<String?> paidOn;
  final Value<String?> method;
  final Value<String?> reference;
  final Value<String?> notes;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.paidOn = const Value.absent(),
    this.method = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.version = const Value.absent(),
    this.fieldMeta = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
    required DateTime updatedAt,
    this.updatedBy = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String invoiceId,
    required int amountCents,
    this.paidOn = const Value.absent(),
    this.method = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       invoiceId = Value(invoiceId),
       amountCents = Value(amountCents);
  static Insertable<PaymentRow> custom({
    Expression<int>? version,
    Expression<String>? fieldMeta,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<int>? amountCents,
    Expression<String>? paidOn,
    Expression<String>? method,
    Expression<String>? reference,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (fieldMeta != null) 'field_meta': fieldMeta,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (paidOn != null) 'paid_on': paidOn,
      if (method != null) 'method': method,
      if (reference != null) 'reference': reference,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? version,
    Value<String>? fieldMeta,
    Value<DateTime>? createdAt,
    Value<String?>? createdBy,
    Value<DateTime>? updatedAt,
    Value<String?>? updatedBy,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? invoiceId,
    Value<int>? amountCents,
    Value<String?>? paidOn,
    Value<String?>? method,
    Value<String?>? reference,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      version: version ?? this.version,
      fieldMeta: fieldMeta ?? this.fieldMeta,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amountCents: amountCents ?? this.amountCents,
      paidOn: paidOn ?? this.paidOn,
      method: method ?? this.method,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fieldMeta.present) {
      map['field_meta'] = Variable<String>(fieldMeta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (paidOn.present) {
      map['paid_on'] = Variable<String>(paidOn.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('version: $version, ')
          ..write('fieldMeta: $fieldMeta, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidOn: $paidOn, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxTable extends Outbox with TableInfo<$OutboxTable, OutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _opIdMeta = const VerificationMeta('opId');
  @override
  late final GeneratedColumn<String> opId = GeneratedColumn<String>(
    'op_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseVersionMeta = const VerificationMeta(
    'baseVersion',
  );
  @override
  late final GeneratedColumn<int> baseVersion = GeneratedColumn<int>(
    'base_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcMeta = const VerificationMeta('hlc');
  @override
  late final GeneratedColumn<String> hlc = GeneratedColumn<String>(
    'hlc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldsMeta = const VerificationMeta('fields');
  @override
  late final GeneratedColumn<String> fields = GeneratedColumn<String>(
    'fields',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    seq,
    opId,
    entity,
    entityId,
    baseVersion,
    hlc,
    fields,
    createdAt,
    attempts,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    }
    if (data.containsKey('op_id')) {
      context.handle(
        _opIdMeta,
        opId.isAcceptableOrUnknown(data['op_id']!, _opIdMeta),
      );
    } else if (isInserting) {
      context.missing(_opIdMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('base_version')) {
      context.handle(
        _baseVersionMeta,
        baseVersion.isAcceptableOrUnknown(
          data['base_version']!,
          _baseVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseVersionMeta);
    }
    if (data.containsKey('hlc')) {
      context.handle(
        _hlcMeta,
        hlc.isAcceptableOrUnknown(data['hlc']!, _hlcMeta),
      );
    } else if (isInserting) {
      context.missing(_hlcMeta);
    }
    if (data.containsKey('fields')) {
      context.handle(
        _fieldsMeta,
        fields.isAcceptableOrUnknown(data['fields']!, _fieldsMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seq};
  @override
  OutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxRow(
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      opId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op_id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      baseVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_version'],
      )!,
      hlc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc'],
      )!,
      fields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fields'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $OutboxTable createAlias(String alias) {
    return $OutboxTable(attachedDatabase, alias);
  }
}

class OutboxRow extends DataClass implements Insertable<OutboxRow> {
  final int seq;
  final String opId;
  final String entity;
  final String entityId;
  final int baseVersion;
  final String hlc;

  /// Champs modifiés (JSON).
  final String fields;
  final DateTime createdAt;
  final int attempts;
  final String? lastError;
  const OutboxRow({
    required this.seq,
    required this.opId,
    required this.entity,
    required this.entityId,
    required this.baseVersion,
    required this.hlc,
    required this.fields,
    required this.createdAt,
    required this.attempts,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['seq'] = Variable<int>(seq);
    map['op_id'] = Variable<String>(opId);
    map['entity'] = Variable<String>(entity);
    map['entity_id'] = Variable<String>(entityId);
    map['base_version'] = Variable<int>(baseVersion);
    map['hlc'] = Variable<String>(hlc);
    map['fields'] = Variable<String>(fields);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  OutboxCompanion toCompanion(bool nullToAbsent) {
    return OutboxCompanion(
      seq: Value(seq),
      opId: Value(opId),
      entity: Value(entity),
      entityId: Value(entityId),
      baseVersion: Value(baseVersion),
      hlc: Value(hlc),
      fields: Value(fields),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory OutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxRow(
      seq: serializer.fromJson<int>(json['seq']),
      opId: serializer.fromJson<String>(json['opId']),
      entity: serializer.fromJson<String>(json['entity']),
      entityId: serializer.fromJson<String>(json['entityId']),
      baseVersion: serializer.fromJson<int>(json['baseVersion']),
      hlc: serializer.fromJson<String>(json['hlc']),
      fields: serializer.fromJson<String>(json['fields']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seq': serializer.toJson<int>(seq),
      'opId': serializer.toJson<String>(opId),
      'entity': serializer.toJson<String>(entity),
      'entityId': serializer.toJson<String>(entityId),
      'baseVersion': serializer.toJson<int>(baseVersion),
      'hlc': serializer.toJson<String>(hlc),
      'fields': serializer.toJson<String>(fields),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  OutboxRow copyWith({
    int? seq,
    String? opId,
    String? entity,
    String? entityId,
    int? baseVersion,
    String? hlc,
    String? fields,
    DateTime? createdAt,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
  }) => OutboxRow(
    seq: seq ?? this.seq,
    opId: opId ?? this.opId,
    entity: entity ?? this.entity,
    entityId: entityId ?? this.entityId,
    baseVersion: baseVersion ?? this.baseVersion,
    hlc: hlc ?? this.hlc,
    fields: fields ?? this.fields,
    createdAt: createdAt ?? this.createdAt,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  OutboxRow copyWithCompanion(OutboxCompanion data) {
    return OutboxRow(
      seq: data.seq.present ? data.seq.value : this.seq,
      opId: data.opId.present ? data.opId.value : this.opId,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      baseVersion: data.baseVersion.present
          ? data.baseVersion.value
          : this.baseVersion,
      hlc: data.hlc.present ? data.hlc.value : this.hlc,
      fields: data.fields.present ? data.fields.value : this.fields,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxRow(')
          ..write('seq: $seq, ')
          ..write('opId: $opId, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('baseVersion: $baseVersion, ')
          ..write('hlc: $hlc, ')
          ..write('fields: $fields, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    seq,
    opId,
    entity,
    entityId,
    baseVersion,
    hlc,
    fields,
    createdAt,
    attempts,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxRow &&
          other.seq == this.seq &&
          other.opId == this.opId &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.baseVersion == this.baseVersion &&
          other.hlc == this.hlc &&
          other.fields == this.fields &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError);
}

class OutboxCompanion extends UpdateCompanion<OutboxRow> {
  final Value<int> seq;
  final Value<String> opId;
  final Value<String> entity;
  final Value<String> entityId;
  final Value<int> baseVersion;
  final Value<String> hlc;
  final Value<String> fields;
  final Value<DateTime> createdAt;
  final Value<int> attempts;
  final Value<String?> lastError;
  const OutboxCompanion({
    this.seq = const Value.absent(),
    this.opId = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.baseVersion = const Value.absent(),
    this.hlc = const Value.absent(),
    this.fields = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  OutboxCompanion.insert({
    this.seq = const Value.absent(),
    required String opId,
    required String entity,
    required String entityId,
    required int baseVersion,
    required String hlc,
    required String fields,
    required DateTime createdAt,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : opId = Value(opId),
       entity = Value(entity),
       entityId = Value(entityId),
       baseVersion = Value(baseVersion),
       hlc = Value(hlc),
       fields = Value(fields),
       createdAt = Value(createdAt);
  static Insertable<OutboxRow> custom({
    Expression<int>? seq,
    Expression<String>? opId,
    Expression<String>? entity,
    Expression<String>? entityId,
    Expression<int>? baseVersion,
    Expression<String>? hlc,
    Expression<String>? fields,
    Expression<DateTime>? createdAt,
    Expression<int>? attempts,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (seq != null) 'seq': seq,
      if (opId != null) 'op_id': opId,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (baseVersion != null) 'base_version': baseVersion,
      if (hlc != null) 'hlc': hlc,
      if (fields != null) 'fields': fields,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
    });
  }

  OutboxCompanion copyWith({
    Value<int>? seq,
    Value<String>? opId,
    Value<String>? entity,
    Value<String>? entityId,
    Value<int>? baseVersion,
    Value<String>? hlc,
    Value<String>? fields,
    Value<DateTime>? createdAt,
    Value<int>? attempts,
    Value<String?>? lastError,
  }) {
    return OutboxCompanion(
      seq: seq ?? this.seq,
      opId: opId ?? this.opId,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      baseVersion: baseVersion ?? this.baseVersion,
      hlc: hlc ?? this.hlc,
      fields: fields ?? this.fields,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (opId.present) {
      map['op_id'] = Variable<String>(opId.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (baseVersion.present) {
      map['base_version'] = Variable<int>(baseVersion.value);
    }
    if (hlc.present) {
      map['hlc'] = Variable<String>(hlc.value);
    }
    if (fields.present) {
      map['fields'] = Variable<String>(fields.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxCompanion(')
          ..write('seq: $seq, ')
          ..write('opId: $opId, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('baseVersion: $baseVersion, ')
          ..write('hlc: $hlc, ')
          ..write('fields: $fields, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $SyncErrorsTable extends SyncErrors
    with TableInfo<$SyncErrorsTable, SyncErrorRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncErrorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _opIdMeta = const VerificationMeta('opId');
  @override
  late final GeneratedColumn<String> opId = GeneratedColumn<String>(
    'op_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldsMeta = const VerificationMeta('fields');
  @override
  late final GeneratedColumn<String> fields = GeneratedColumn<String>(
    'fields',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    opId,
    entity,
    entityId,
    fields,
    message,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_errors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncErrorRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('op_id')) {
      context.handle(
        _opIdMeta,
        opId.isAcceptableOrUnknown(data['op_id']!, _opIdMeta),
      );
    } else if (isInserting) {
      context.missing(_opIdMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('fields')) {
      context.handle(
        _fieldsMeta,
        fields.isAcceptableOrUnknown(data['fields']!, _fieldsMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldsMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncErrorRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncErrorRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      opId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op_id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      fields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fields'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncErrorsTable createAlias(String alias) {
    return $SyncErrorsTable(attachedDatabase, alias);
  }
}

class SyncErrorRow extends DataClass implements Insertable<SyncErrorRow> {
  final int id;
  final String opId;
  final String entity;
  final String entityId;
  final String fields;
  final String message;
  final DateTime createdAt;
  const SyncErrorRow({
    required this.id,
    required this.opId,
    required this.entity,
    required this.entityId,
    required this.fields,
    required this.message,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['op_id'] = Variable<String>(opId);
    map['entity'] = Variable<String>(entity);
    map['entity_id'] = Variable<String>(entityId);
    map['fields'] = Variable<String>(fields);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncErrorsCompanion toCompanion(bool nullToAbsent) {
    return SyncErrorsCompanion(
      id: Value(id),
      opId: Value(opId),
      entity: Value(entity),
      entityId: Value(entityId),
      fields: Value(fields),
      message: Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory SyncErrorRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncErrorRow(
      id: serializer.fromJson<int>(json['id']),
      opId: serializer.fromJson<String>(json['opId']),
      entity: serializer.fromJson<String>(json['entity']),
      entityId: serializer.fromJson<String>(json['entityId']),
      fields: serializer.fromJson<String>(json['fields']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'opId': serializer.toJson<String>(opId),
      'entity': serializer.toJson<String>(entity),
      'entityId': serializer.toJson<String>(entityId),
      'fields': serializer.toJson<String>(fields),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncErrorRow copyWith({
    int? id,
    String? opId,
    String? entity,
    String? entityId,
    String? fields,
    String? message,
    DateTime? createdAt,
  }) => SyncErrorRow(
    id: id ?? this.id,
    opId: opId ?? this.opId,
    entity: entity ?? this.entity,
    entityId: entityId ?? this.entityId,
    fields: fields ?? this.fields,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncErrorRow copyWithCompanion(SyncErrorsCompanion data) {
    return SyncErrorRow(
      id: data.id.present ? data.id.value : this.id,
      opId: data.opId.present ? data.opId.value : this.opId,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      fields: data.fields.present ? data.fields.value : this.fields,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncErrorRow(')
          ..write('id: $id, ')
          ..write('opId: $opId, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('fields: $fields, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, opId, entity, entityId, fields, message, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncErrorRow &&
          other.id == this.id &&
          other.opId == this.opId &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.fields == this.fields &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class SyncErrorsCompanion extends UpdateCompanion<SyncErrorRow> {
  final Value<int> id;
  final Value<String> opId;
  final Value<String> entity;
  final Value<String> entityId;
  final Value<String> fields;
  final Value<String> message;
  final Value<DateTime> createdAt;
  const SyncErrorsCompanion({
    this.id = const Value.absent(),
    this.opId = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.fields = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncErrorsCompanion.insert({
    this.id = const Value.absent(),
    required String opId,
    required String entity,
    required String entityId,
    required String fields,
    required String message,
    required DateTime createdAt,
  }) : opId = Value(opId),
       entity = Value(entity),
       entityId = Value(entityId),
       fields = Value(fields),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<SyncErrorRow> custom({
    Expression<int>? id,
    Expression<String>? opId,
    Expression<String>? entity,
    Expression<String>? entityId,
    Expression<String>? fields,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (opId != null) 'op_id': opId,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (fields != null) 'fields': fields,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncErrorsCompanion copyWith({
    Value<int>? id,
    Value<String>? opId,
    Value<String>? entity,
    Value<String>? entityId,
    Value<String>? fields,
    Value<String>? message,
    Value<DateTime>? createdAt,
  }) {
    return SyncErrorsCompanion(
      id: id ?? this.id,
      opId: opId ?? this.opId,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      fields: fields ?? this.fields,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (opId.present) {
      map['op_id'] = Variable<String>(opId.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (fields.present) {
      map['fields'] = Variable<String>(fields.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncErrorsCompanion(')
          ..write('id: $id, ')
          ..write('opId: $opId, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('fields: $fields, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $KeyValuesTable extends KeyValues
    with TableInfo<$KeyValuesTable, KeyValueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KeyValuesTable createAlias(String alias) {
    return $KeyValuesTable(attachedDatabase, alias);
  }
}

class KeyValueRow extends DataClass implements Insertable<KeyValueRow> {
  final String key;
  final String value;
  const KeyValueRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValuesCompanion toCompanion(bool nullToAbsent) {
    return KeyValuesCompanion(key: Value(key), value: Value(value));
  }

  factory KeyValueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValueRow copyWith({String? key, String? value}) =>
      KeyValueRow(key: key ?? this.key, value: value ?? this.value);
  KeyValueRow copyWithCompanion(KeyValuesCompanion data) {
    return KeyValueRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueRow &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValuesCompanion extends UpdateCompanion<KeyValueRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValuesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValuesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KeyValueRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValuesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KeyValuesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValuesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $OrganisationsTable organisations = $OrganisationsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $PositionsTable positions = $PositionsTable(this);
  late final $PipelinesTable pipelines = $PipelinesTable(this);
  late final $PipelineStagesTable pipelineStages = $PipelineStagesTable(this);
  late final $DealsTable deals = $DealsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $TaggingsTable taggings = $TaggingsTable(this);
  late final $CustomFieldsTable customFields = $CustomFieldsTable(this);
  late final $SegmentsTable segments = $SegmentsTable(this);
  late final $EmailTemplatesTable emailTemplates = $EmailTemplatesTable(this);
  late final $EmailSequencesTable emailSequences = $EmailSequencesTable(this);
  late final $SequenceEnrollmentsTable sequenceEnrollments =
      $SequenceEnrollmentsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $OutboxTable outbox = $OutboxTable(this);
  late final $SyncErrorsTable syncErrors = $SyncErrorsTable(this);
  late final $KeyValuesTable keyValues = $KeyValuesTable(this);
  late final Index organisationsParent = Index(
    'organisations_parent',
    'CREATE INDEX organisations_parent ON organisations (parent_id)',
  );
  late final Index contactsOrganisation = Index(
    'contacts_organisation',
    'CREATE INDEX contacts_organisation ON contacts (organisation_id)',
  );
  late final Index positionsContact = Index(
    'positions_contact',
    'CREATE INDEX positions_contact ON positions (contact_id)',
  );
  late final Index positionsOrganisation = Index(
    'positions_organisation',
    'CREATE INDEX positions_organisation ON positions (organisation_id)',
  );
  late final Index dealsOrganisation = Index(
    'deals_organisation',
    'CREATE INDEX deals_organisation ON deals (organisation_id)',
  );
  late final Index activitiesOrganisation = Index(
    'activities_organisation',
    'CREATE INDEX activities_organisation ON activities (organisation_id)',
  );
  late final Index activitiesContact = Index(
    'activities_contact',
    'CREATE INDEX activities_contact ON activities (contact_id)',
  );
  late final Index taggingsRecord = Index(
    'taggings_record',
    'CREATE INDEX taggings_record ON taggings (record_id)',
  );
  late final Index invoicesOrganisation = Index(
    'invoices_organisation',
    'CREATE INDEX invoices_organisation ON invoices (organisation_id)',
  );
  late final Index paymentsInvoice = Index(
    'payments_invoice',
    'CREATE INDEX payments_invoice ON payments (invoice_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tags,
    organisations,
    contacts,
    positions,
    pipelines,
    pipelineStages,
    deals,
    activities,
    attachments,
    taggings,
    customFields,
    segments,
    emailTemplates,
    emailSequences,
    sequenceEnrollments,
    products,
    invoices,
    payments,
    outbox,
    syncErrors,
    keyValues,
    organisationsParent,
    contactsOrganisation,
    positionsContact,
    positionsOrganisation,
    dealsOrganisation,
    activitiesOrganisation,
    activitiesContact,
    taggingsRecord,
    invoicesOrganisation,
    paymentsInvoice,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      required String id,
      required String name,
      required String color,
      Value<String?> description,
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> color,
      Value<String?> description,
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          TagRow,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (TagRow, BaseReferences<_$AppDatabase, $TagsTable, TagRow>),
          TagRow,
          PrefetchHooks Function()
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                color: color,
                description: description,
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String color,
                Value<String?> description = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                color: color,
                description: description,
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      TagRow,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (TagRow, BaseReferences<_$AppDatabase, $TagsTable, TagRow>),
      TagRow,
      PrefetchHooks Function()
    >;
typedef $$OrganisationsTableCreateCompanionBuilder =
    OrganisationsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      required String id,
      required String name,
      required String kind,
      required String status,
      Value<String?> siren,
      Value<String?> siret,
      Value<String?> inseeCode,
      Value<int?> population,
      Value<String?> parentId,
      Value<String?> departementCode,
      Value<String?> regionCode,
      Value<String?> address,
      Value<String?> postalCode,
      Value<String?> city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<String?> description,
      Value<String?> ownerId,
      Value<String?> customFields,
      Value<int> rowid,
    });
typedef $$OrganisationsTableUpdateCompanionBuilder =
    OrganisationsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      Value<String> id,
      Value<String> name,
      Value<String> kind,
      Value<String> status,
      Value<String?> siren,
      Value<String?> siret,
      Value<String?> inseeCode,
      Value<int?> population,
      Value<String?> parentId,
      Value<String?> departementCode,
      Value<String?> regionCode,
      Value<String?> address,
      Value<String?> postalCode,
      Value<String?> city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<String?> description,
      Value<String?> ownerId,
      Value<String?> customFields,
      Value<int> rowid,
    });

class $$OrganisationsTableFilterComposer
    extends Composer<_$AppDatabase, $OrganisationsTable> {
  $$OrganisationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get siren => $composableBuilder(
    column: $table.siren,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get siret => $composableBuilder(
    column: $table.siret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inseeCode => $composableBuilder(
    column: $table.inseeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departementCode => $composableBuilder(
    column: $table.departementCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrganisationsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganisationsTable> {
  $$OrganisationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siren => $composableBuilder(
    column: $table.siren,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siret => $composableBuilder(
    column: $table.siret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inseeCode => $composableBuilder(
    column: $table.inseeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departementCode => $composableBuilder(
    column: $table.departementCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganisationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganisationsTable> {
  $$OrganisationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get siren =>
      $composableBuilder(column: $table.siren, builder: (column) => column);

  GeneratedColumn<String> get siret =>
      $composableBuilder(column: $table.siret, builder: (column) => column);

  GeneratedColumn<String> get inseeCode =>
      $composableBuilder(column: $table.inseeCode, builder: (column) => column);

  GeneratedColumn<int> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get departementCode => $composableBuilder(
    column: $table.departementCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => column,
  );
}

class $$OrganisationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganisationsTable,
          OrganisationRow,
          $$OrganisationsTableFilterComposer,
          $$OrganisationsTableOrderingComposer,
          $$OrganisationsTableAnnotationComposer,
          $$OrganisationsTableCreateCompanionBuilder,
          $$OrganisationsTableUpdateCompanionBuilder,
          (
            OrganisationRow,
            BaseReferences<_$AppDatabase, $OrganisationsTable, OrganisationRow>,
          ),
          OrganisationRow,
          PrefetchHooks Function()
        > {
  $$OrganisationsTableTableManager(_$AppDatabase db, $OrganisationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganisationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganisationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrganisationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> siren = const Value.absent(),
                Value<String?> siret = const Value.absent(),
                Value<String?> inseeCode = const Value.absent(),
                Value<int?> population = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String?> departementCode = const Value.absent(),
                Value<String?> regionCode = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganisationsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                name: name,
                kind: kind,
                status: status,
                siren: siren,
                siret: siret,
                inseeCode: inseeCode,
                population: population,
                parentId: parentId,
                departementCode: departementCode,
                regionCode: regionCode,
                address: address,
                postalCode: postalCode,
                city: city,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                email: email,
                website: website,
                description: description,
                ownerId: ownerId,
                customFields: customFields,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                required String id,
                required String name,
                required String kind,
                required String status,
                Value<String?> siren = const Value.absent(),
                Value<String?> siret = const Value.absent(),
                Value<String?> inseeCode = const Value.absent(),
                Value<int?> population = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String?> departementCode = const Value.absent(),
                Value<String?> regionCode = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganisationsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                name: name,
                kind: kind,
                status: status,
                siren: siren,
                siret: siret,
                inseeCode: inseeCode,
                population: population,
                parentId: parentId,
                departementCode: departementCode,
                regionCode: regionCode,
                address: address,
                postalCode: postalCode,
                city: city,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                email: email,
                website: website,
                description: description,
                ownerId: ownerId,
                customFields: customFields,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrganisationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganisationsTable,
      OrganisationRow,
      $$OrganisationsTableFilterComposer,
      $$OrganisationsTableOrderingComposer,
      $$OrganisationsTableAnnotationComposer,
      $$OrganisationsTableCreateCompanionBuilder,
      $$OrganisationsTableUpdateCompanionBuilder,
      (
        OrganisationRow,
        BaseReferences<_$AppDatabase, $OrganisationsTable, OrganisationRow>,
      ),
      OrganisationRow,
      PrefetchHooks Function()
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      required String id,
      Value<String?> civility,
      Value<String?> firstName,
      required String lastName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> mobile,
      Value<String?> organisationId,
      Value<String?> jobTitle,
      Value<String?> service,
      Value<String?> notes,
      Value<bool?> doNotContact,
      Value<String?> ownerId,
      Value<String?> customFields,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      Value<String> id,
      Value<String?> civility,
      Value<String?> firstName,
      Value<String> lastName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> mobile,
      Value<String?> organisationId,
      Value<String?> jobTitle,
      Value<String?> service,
      Value<String?> notes,
      Value<bool?> doNotContact,
      Value<String?> ownerId,
      Value<String?> customFields,
      Value<int> rowid,
    });

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get civility => $composableBuilder(
    column: $table.civility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get doNotContact => $composableBuilder(
    column: $table.doNotContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get civility => $composableBuilder(
    column: $table.civility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get doNotContact => $composableBuilder(
    column: $table.doNotContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get civility =>
      $composableBuilder(column: $table.civility, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get service =>
      $composableBuilder(column: $table.service, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get doNotContact => $composableBuilder(
    column: $table.doNotContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => column,
  );
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          ContactRow,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (
            ContactRow,
            BaseReferences<_$AppDatabase, $ContactsTable, ContactRow>,
          ),
          ContactRow,
          PrefetchHooks Function()
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> civility = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> jobTitle = const Value.absent(),
                Value<String?> service = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool?> doNotContact = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                civility: civility,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                mobile: mobile,
                organisationId: organisationId,
                jobTitle: jobTitle,
                service: service,
                notes: notes,
                doNotContact: doNotContact,
                ownerId: ownerId,
                customFields: customFields,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                required String id,
                Value<String?> civility = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                required String lastName,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> jobTitle = const Value.absent(),
                Value<String?> service = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool?> doNotContact = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                civility: civility,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                mobile: mobile,
                organisationId: organisationId,
                jobTitle: jobTitle,
                service: service,
                notes: notes,
                doNotContact: doNotContact,
                ownerId: ownerId,
                customFields: customFields,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      ContactRow,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (ContactRow, BaseReferences<_$AppDatabase, $ContactsTable, ContactRow>),
      ContactRow,
      PrefetchHooks Function()
    >;
typedef $$PositionsTableCreateCompanionBuilder =
    PositionsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      required String id,
      required String contactId,
      required String organisationId,
      Value<String?> jobTitle,
      Value<String?> service,
      required bool isElected,
      Value<String?> mandateRole,
      Value<String?> delegation,
      Value<String?> startDate,
      Value<String?> endDate,
      Value<int> rowid,
    });
typedef $$PositionsTableUpdateCompanionBuilder =
    PositionsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String?> source,
      Value<String?> sourceRef,
      Value<DateTime?> collectedAt,
      Value<String> id,
      Value<String> contactId,
      Value<String> organisationId,
      Value<String?> jobTitle,
      Value<String?> service,
      Value<bool> isElected,
      Value<String?> mandateRole,
      Value<String?> delegation,
      Value<String?> startDate,
      Value<String?> endDate,
      Value<int> rowid,
    });

class $$PositionsTableFilterComposer
    extends Composer<_$AppDatabase, $PositionsTable> {
  $$PositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isElected => $composableBuilder(
    column: $table.isElected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mandateRole => $composableBuilder(
    column: $table.mandateRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get delegation => $composableBuilder(
    column: $table.delegation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PositionsTable> {
  $$PositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isElected => $composableBuilder(
    column: $table.isElected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mandateRole => $composableBuilder(
    column: $table.mandateRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get delegation => $composableBuilder(
    column: $table.delegation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PositionsTable> {
  $$PositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get service =>
      $composableBuilder(column: $table.service, builder: (column) => column);

  GeneratedColumn<bool> get isElected =>
      $composableBuilder(column: $table.isElected, builder: (column) => column);

  GeneratedColumn<String> get mandateRole => $composableBuilder(
    column: $table.mandateRole,
    builder: (column) => column,
  );

  GeneratedColumn<String> get delegation => $composableBuilder(
    column: $table.delegation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);
}

class $$PositionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PositionsTable,
          PositionRow,
          $$PositionsTableFilterComposer,
          $$PositionsTableOrderingComposer,
          $$PositionsTableAnnotationComposer,
          $$PositionsTableCreateCompanionBuilder,
          $$PositionsTableUpdateCompanionBuilder,
          (
            PositionRow,
            BaseReferences<_$AppDatabase, $PositionsTable, PositionRow>,
          ),
          PositionRow,
          PrefetchHooks Function()
        > {
  $$PositionsTableTableManager(_$AppDatabase db, $PositionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PositionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> contactId = const Value.absent(),
                Value<String> organisationId = const Value.absent(),
                Value<String?> jobTitle = const Value.absent(),
                Value<String?> service = const Value.absent(),
                Value<bool> isElected = const Value.absent(),
                Value<String?> mandateRole = const Value.absent(),
                Value<String?> delegation = const Value.absent(),
                Value<String?> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PositionsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                contactId: contactId,
                organisationId: organisationId,
                jobTitle: jobTitle,
                service: service,
                isElected: isElected,
                mandateRole: mandateRole,
                delegation: delegation,
                startDate: startDate,
                endDate: endDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<DateTime?> collectedAt = const Value.absent(),
                required String id,
                required String contactId,
                required String organisationId,
                Value<String?> jobTitle = const Value.absent(),
                Value<String?> service = const Value.absent(),
                required bool isElected,
                Value<String?> mandateRole = const Value.absent(),
                Value<String?> delegation = const Value.absent(),
                Value<String?> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PositionsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                source: source,
                sourceRef: sourceRef,
                collectedAt: collectedAt,
                id: id,
                contactId: contactId,
                organisationId: organisationId,
                jobTitle: jobTitle,
                service: service,
                isElected: isElected,
                mandateRole: mandateRole,
                delegation: delegation,
                startDate: startDate,
                endDate: endDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PositionsTable,
      PositionRow,
      $$PositionsTableFilterComposer,
      $$PositionsTableOrderingComposer,
      $$PositionsTableAnnotationComposer,
      $$PositionsTableCreateCompanionBuilder,
      $$PositionsTableUpdateCompanionBuilder,
      (
        PositionRow,
        BaseReferences<_$AppDatabase, $PositionsTable, PositionRow>,
      ),
      PositionRow,
      PrefetchHooks Function()
    >;
typedef $$PipelinesTableCreateCompanionBuilder =
    PipelinesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String kind,
      Value<double?> sortOrder,
      Value<bool?> archived,
      Value<int> rowid,
    });
typedef $$PipelinesTableUpdateCompanionBuilder =
    PipelinesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> kind,
      Value<double?> sortOrder,
      Value<bool?> archived,
      Value<int> rowid,
    });

class $$PipelinesTableFilterComposer
    extends Composer<_$AppDatabase, $PipelinesTable> {
  $$PipelinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PipelinesTableOrderingComposer
    extends Composer<_$AppDatabase, $PipelinesTable> {
  $$PipelinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PipelinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PipelinesTable> {
  $$PipelinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$PipelinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PipelinesTable,
          PipelineRow,
          $$PipelinesTableFilterComposer,
          $$PipelinesTableOrderingComposer,
          $$PipelinesTableAnnotationComposer,
          $$PipelinesTableCreateCompanionBuilder,
          $$PipelinesTableUpdateCompanionBuilder,
          (
            PipelineRow,
            BaseReferences<_$AppDatabase, $PipelinesTable, PipelineRow>,
          ),
          PipelineRow,
          PrefetchHooks Function()
        > {
  $$PipelinesTableTableManager(_$AppDatabase db, $PipelinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PipelinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PipelinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PipelinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<bool?> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelinesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                kind: kind,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String kind,
                Value<double?> sortOrder = const Value.absent(),
                Value<bool?> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelinesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                kind: kind,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PipelinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PipelinesTable,
      PipelineRow,
      $$PipelinesTableFilterComposer,
      $$PipelinesTableOrderingComposer,
      $$PipelinesTableAnnotationComposer,
      $$PipelinesTableCreateCompanionBuilder,
      $$PipelinesTableUpdateCompanionBuilder,
      (
        PipelineRow,
        BaseReferences<_$AppDatabase, $PipelinesTable, PipelineRow>,
      ),
      PipelineRow,
      PrefetchHooks Function()
    >;
typedef $$PipelineStagesTableCreateCompanionBuilder =
    PipelineStagesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String pipelineId,
      required String name,
      Value<double?> sortOrder,
      Value<int?> probability,
      Value<String?> color,
      required String outcome,
      Value<int> rowid,
    });
typedef $$PipelineStagesTableUpdateCompanionBuilder =
    PipelineStagesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> pipelineId,
      Value<String> name,
      Value<double?> sortOrder,
      Value<int?> probability,
      Value<String?> color,
      Value<String> outcome,
      Value<int> rowid,
    });

class $$PipelineStagesTableFilterComposer
    extends Composer<_$AppDatabase, $PipelineStagesTable> {
  $$PipelineStagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PipelineStagesTableOrderingComposer
    extends Composer<_$AppDatabase, $PipelineStagesTable> {
  $$PipelineStagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PipelineStagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PipelineStagesTable> {
  $$PipelineStagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);
}

class $$PipelineStagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PipelineStagesTable,
          StageRow,
          $$PipelineStagesTableFilterComposer,
          $$PipelineStagesTableOrderingComposer,
          $$PipelineStagesTableAnnotationComposer,
          $$PipelineStagesTableCreateCompanionBuilder,
          $$PipelineStagesTableUpdateCompanionBuilder,
          (
            StageRow,
            BaseReferences<_$AppDatabase, $PipelineStagesTable, StageRow>,
          ),
          StageRow,
          PrefetchHooks Function()
        > {
  $$PipelineStagesTableTableManager(
    _$AppDatabase db,
    $PipelineStagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PipelineStagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PipelineStagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PipelineStagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> pipelineId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<int?> probability = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelineStagesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                pipelineId: pipelineId,
                name: name,
                sortOrder: sortOrder,
                probability: probability,
                color: color,
                outcome: outcome,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String pipelineId,
                required String name,
                Value<double?> sortOrder = const Value.absent(),
                Value<int?> probability = const Value.absent(),
                Value<String?> color = const Value.absent(),
                required String outcome,
                Value<int> rowid = const Value.absent(),
              }) => PipelineStagesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                pipelineId: pipelineId,
                name: name,
                sortOrder: sortOrder,
                probability: probability,
                color: color,
                outcome: outcome,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PipelineStagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PipelineStagesTable,
      StageRow,
      $$PipelineStagesTableFilterComposer,
      $$PipelineStagesTableOrderingComposer,
      $$PipelineStagesTableAnnotationComposer,
      $$PipelineStagesTableCreateCompanionBuilder,
      $$PipelineStagesTableUpdateCompanionBuilder,
      (StageRow, BaseReferences<_$AppDatabase, $PipelineStagesTable, StageRow>),
      StageRow,
      PrefetchHooks Function()
    >;
typedef $$DealsTableCreateCompanionBuilder =
    DealsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String title,
      required String pipelineId,
      required String stageId,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<int?> amountCents,
      Value<int?> probability,
      Value<String?> expectedCloseDate,
      required String status,
      Value<DateTime?> closedAt,
      Value<double?> sortOrder,
      Value<String?> ownerId,
      Value<String?> description,
      Value<String?> customFields,
      Value<int> rowid,
    });
typedef $$DealsTableUpdateCompanionBuilder =
    DealsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> title,
      Value<String> pipelineId,
      Value<String> stageId,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<int?> amountCents,
      Value<int?> probability,
      Value<String?> expectedCloseDate,
      Value<String> status,
      Value<DateTime?> closedAt,
      Value<double?> sortOrder,
      Value<String?> ownerId,
      Value<String?> description,
      Value<String?> customFields,
      Value<int> rowid,
    });

class $$DealsTableFilterComposer extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stageId => $composableBuilder(
    column: $table.stageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedCloseDate => $composableBuilder(
    column: $table.expectedCloseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DealsTableOrderingComposer
    extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stageId => $composableBuilder(
    column: $table.stageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedCloseDate => $composableBuilder(
    column: $table.expectedCloseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stageId =>
      $composableBuilder(column: $table.stageId, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expectedCloseDate => $composableBuilder(
    column: $table.expectedCloseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => column,
  );
}

class $$DealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DealsTable,
          DealRow,
          $$DealsTableFilterComposer,
          $$DealsTableOrderingComposer,
          $$DealsTableAnnotationComposer,
          $$DealsTableCreateCompanionBuilder,
          $$DealsTableUpdateCompanionBuilder,
          (DealRow, BaseReferences<_$AppDatabase, $DealsTable, DealRow>),
          DealRow,
          PrefetchHooks Function()
        > {
  $$DealsTableTableManager(_$AppDatabase db, $DealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> pipelineId = const Value.absent(),
                Value<String> stageId = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<int?> amountCents = const Value.absent(),
                Value<int?> probability = const Value.absent(),
                Value<String?> expectedCloseDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DealsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                title: title,
                pipelineId: pipelineId,
                stageId: stageId,
                organisationId: organisationId,
                contactId: contactId,
                amountCents: amountCents,
                probability: probability,
                expectedCloseDate: expectedCloseDate,
                status: status,
                closedAt: closedAt,
                sortOrder: sortOrder,
                ownerId: ownerId,
                description: description,
                customFields: customFields,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String title,
                required String pipelineId,
                required String stageId,
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<int?> amountCents = const Value.absent(),
                Value<int?> probability = const Value.absent(),
                Value<String?> expectedCloseDate = const Value.absent(),
                required String status,
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DealsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                title: title,
                pipelineId: pipelineId,
                stageId: stageId,
                organisationId: organisationId,
                contactId: contactId,
                amountCents: amountCents,
                probability: probability,
                expectedCloseDate: expectedCloseDate,
                status: status,
                closedAt: closedAt,
                sortOrder: sortOrder,
                ownerId: ownerId,
                description: description,
                customFields: customFields,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DealsTable,
      DealRow,
      $$DealsTableFilterComposer,
      $$DealsTableOrderingComposer,
      $$DealsTableAnnotationComposer,
      $$DealsTableCreateCompanionBuilder,
      $$DealsTableUpdateCompanionBuilder,
      (DealRow, BaseReferences<_$AppDatabase, $DealsTable, DealRow>),
      DealRow,
      PrefetchHooks Function()
    >;
typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String kind,
      required String subject,
      Value<String?> body,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<DateTime?> startsAt,
      Value<DateTime?> endsAt,
      Value<DateTime?> dueAt,
      Value<DateTime?> remindAt,
      Value<DateTime?> doneAt,
      Value<String?> assigneeId,
      Value<String?> ownerId,
      Value<int> rowid,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> kind,
      Value<String> subject,
      Value<String?> body,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<DateTime?> startsAt,
      Value<DateTime?> endsAt,
      Value<DateTime?> dueAt,
      Value<DateTime?> remindAt,
      Value<DateTime?> doneAt,
      Value<String?> assigneeId,
      Value<String?> ownerId,
      Value<int> rowid,
    });

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get remindAt => $composableBuilder(
    column: $table.remindAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get doneAt => $composableBuilder(
    column: $table.doneAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get remindAt => $composableBuilder(
    column: $table.remindAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get doneAt => $composableBuilder(
    column: $table.doneAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get dealId =>
      $composableBuilder(column: $table.dealId, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get remindAt =>
      $composableBuilder(column: $table.remindAt, builder: (column) => column);

  GeneratedColumn<DateTime> get doneAt =>
      $composableBuilder(column: $table.doneAt, builder: (column) => column);

  GeneratedColumn<String> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          ActivityRow,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (
            ActivityRow,
            BaseReferences<_$AppDatabase, $ActivitiesTable, ActivityRow>,
          ),
          ActivityRow,
          PrefetchHooks Function()
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<DateTime?> startsAt = const Value.absent(),
                Value<DateTime?> endsAt = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> remindAt = const Value.absent(),
                Value<DateTime?> doneAt = const Value.absent(),
                Value<String?> assigneeId = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                kind: kind,
                subject: subject,
                body: body,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                startsAt: startsAt,
                endsAt: endsAt,
                dueAt: dueAt,
                remindAt: remindAt,
                doneAt: doneAt,
                assigneeId: assigneeId,
                ownerId: ownerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String kind,
                required String subject,
                Value<String?> body = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<DateTime?> startsAt = const Value.absent(),
                Value<DateTime?> endsAt = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> remindAt = const Value.absent(),
                Value<DateTime?> doneAt = const Value.absent(),
                Value<String?> assigneeId = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                kind: kind,
                subject: subject,
                body: body,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                startsAt: startsAt,
                endsAt: endsAt,
                dueAt: dueAt,
                remindAt: remindAt,
                doneAt: doneAt,
                assigneeId: assigneeId,
                ownerId: ownerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      ActivityRow,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (
        ActivityRow,
        BaseReferences<_$AppDatabase, $ActivitiesTable, ActivityRow>,
      ),
      ActivityRow,
      PrefetchHooks Function()
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String fileId,
      required String fileName,
      required int size,
      Value<String?> mimeType,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<String?> activityId,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> fileId,
      Value<String> fileName,
      Value<int> size,
      Value<String?> mimeType,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<String?> activityId,
      Value<int> rowid,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileId => $composableBuilder(
    column: $table.fileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileId => $composableBuilder(
    column: $table.fileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileId =>
      $composableBuilder(column: $table.fileId, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get dealId =>
      $composableBuilder(column: $table.dealId, builder: (column) => column);

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          AttachmentRow,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            AttachmentRow,
            BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
          ),
          AttachmentRow,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> fileId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<String?> activityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                fileId: fileId,
                fileName: fileName,
                size: size,
                mimeType: mimeType,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                activityId: activityId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String fileId,
                required String fileName,
                required int size,
                Value<String?> mimeType = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<String?> activityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                fileId: fileId,
                fileName: fileName,
                size: size,
                mimeType: mimeType,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                activityId: activityId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      AttachmentRow,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        AttachmentRow,
        BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
      ),
      AttachmentRow,
      PrefetchHooks Function()
    >;
typedef $$TaggingsTableCreateCompanionBuilder =
    TaggingsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String tagId,
      required String entity,
      required String recordId,
      Value<int> rowid,
    });
typedef $$TaggingsTableUpdateCompanionBuilder =
    TaggingsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> tagId,
      Value<String> entity,
      Value<String> recordId,
      Value<int> rowid,
    });

class $$TaggingsTableFilterComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaggingsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaggingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);
}

class $$TaggingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaggingsTable,
          TaggingRow,
          $$TaggingsTableFilterComposer,
          $$TaggingsTableOrderingComposer,
          $$TaggingsTableAnnotationComposer,
          $$TaggingsTableCreateCompanionBuilder,
          $$TaggingsTableUpdateCompanionBuilder,
          (
            TaggingRow,
            BaseReferences<_$AppDatabase, $TaggingsTable, TaggingRow>,
          ),
          TaggingRow,
          PrefetchHooks Function()
        > {
  $$TaggingsTableTableManager(_$AppDatabase db, $TaggingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaggingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaggingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaggingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaggingsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                tagId: tagId,
                entity: entity,
                recordId: recordId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String tagId,
                required String entity,
                required String recordId,
                Value<int> rowid = const Value.absent(),
              }) => TaggingsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                tagId: tagId,
                entity: entity,
                recordId: recordId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaggingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaggingsTable,
      TaggingRow,
      $$TaggingsTableFilterComposer,
      $$TaggingsTableOrderingComposer,
      $$TaggingsTableAnnotationComposer,
      $$TaggingsTableCreateCompanionBuilder,
      $$TaggingsTableUpdateCompanionBuilder,
      (TaggingRow, BaseReferences<_$AppDatabase, $TaggingsTable, TaggingRow>),
      TaggingRow,
      PrefetchHooks Function()
    >;
typedef $$CustomFieldsTableCreateCompanionBuilder =
    CustomFieldsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String entity,
      required String key,
      required String label,
      required String type,
      Value<String?> options,
      Value<double?> sortOrder,
      Value<int> rowid,
    });
typedef $$CustomFieldsTableUpdateCompanionBuilder =
    CustomFieldsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> entity,
      Value<String> key,
      Value<String> label,
      Value<String> type,
      Value<String?> options,
      Value<double?> sortOrder,
      Value<int> rowid,
    });

class $$CustomFieldsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomFieldsTable> {
  $$CustomFieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get options => $composableBuilder(
    column: $table.options,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomFieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomFieldsTable> {
  $$CustomFieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get options => $composableBuilder(
    column: $table.options,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomFieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomFieldsTable> {
  $$CustomFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get options =>
      $composableBuilder(column: $table.options, builder: (column) => column);

  GeneratedColumn<double> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$CustomFieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomFieldsTable,
          CustomFieldRow,
          $$CustomFieldsTableFilterComposer,
          $$CustomFieldsTableOrderingComposer,
          $$CustomFieldsTableAnnotationComposer,
          $$CustomFieldsTableCreateCompanionBuilder,
          $$CustomFieldsTableUpdateCompanionBuilder,
          (
            CustomFieldRow,
            BaseReferences<_$AppDatabase, $CustomFieldsTable, CustomFieldRow>,
          ),
          CustomFieldRow,
          PrefetchHooks Function()
        > {
  $$CustomFieldsTableTableManager(_$AppDatabase db, $CustomFieldsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomFieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomFieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> options = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomFieldsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                entity: entity,
                key: key,
                label: label,
                type: type,
                options: options,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String entity,
                required String key,
                required String label,
                required String type,
                Value<String?> options = const Value.absent(),
                Value<double?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomFieldsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                entity: entity,
                key: key,
                label: label,
                type: type,
                options: options,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomFieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomFieldsTable,
      CustomFieldRow,
      $$CustomFieldsTableFilterComposer,
      $$CustomFieldsTableOrderingComposer,
      $$CustomFieldsTableAnnotationComposer,
      $$CustomFieldsTableCreateCompanionBuilder,
      $$CustomFieldsTableUpdateCompanionBuilder,
      (
        CustomFieldRow,
        BaseReferences<_$AppDatabase, $CustomFieldsTable, CustomFieldRow>,
      ),
      CustomFieldRow,
      PrefetchHooks Function()
    >;
typedef $$SegmentsTableCreateCompanionBuilder =
    SegmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String entity,
      Value<String?> description,
      required String config,
      Value<int> rowid,
    });
typedef $$SegmentsTableUpdateCompanionBuilder =
    SegmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> entity,
      Value<String?> description,
      Value<String> config,
      Value<int> rowid,
    });

class $$SegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get config =>
      $composableBuilder(column: $table.config, builder: (column) => column);
}

class $$SegmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SegmentsTable,
          SegmentRow,
          $$SegmentsTableFilterComposer,
          $$SegmentsTableOrderingComposer,
          $$SegmentsTableAnnotationComposer,
          $$SegmentsTableCreateCompanionBuilder,
          $$SegmentsTableUpdateCompanionBuilder,
          (
            SegmentRow,
            BaseReferences<_$AppDatabase, $SegmentsTable, SegmentRow>,
          ),
          SegmentRow,
          PrefetchHooks Function()
        > {
  $$SegmentsTableTableManager(_$AppDatabase db, $SegmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> config = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SegmentsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                entity: entity,
                description: description,
                config: config,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String entity,
                Value<String?> description = const Value.absent(),
                required String config,
                Value<int> rowid = const Value.absent(),
              }) => SegmentsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                entity: entity,
                description: description,
                config: config,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SegmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SegmentsTable,
      SegmentRow,
      $$SegmentsTableFilterComposer,
      $$SegmentsTableOrderingComposer,
      $$SegmentsTableAnnotationComposer,
      $$SegmentsTableCreateCompanionBuilder,
      $$SegmentsTableUpdateCompanionBuilder,
      (SegmentRow, BaseReferences<_$AppDatabase, $SegmentsTable, SegmentRow>),
      SegmentRow,
      PrefetchHooks Function()
    >;
typedef $$EmailTemplatesTableCreateCompanionBuilder =
    EmailTemplatesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String subject,
      required String body,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$EmailTemplatesTableUpdateCompanionBuilder =
    EmailTemplatesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> subject,
      Value<String> body,
      Value<String?> description,
      Value<int> rowid,
    });

class $$EmailTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $EmailTemplatesTable> {
  $$EmailTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmailTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmailTemplatesTable> {
  $$EmailTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmailTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmailTemplatesTable> {
  $$EmailTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$EmailTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmailTemplatesTable,
          EmailTemplateRow,
          $$EmailTemplatesTableFilterComposer,
          $$EmailTemplatesTableOrderingComposer,
          $$EmailTemplatesTableAnnotationComposer,
          $$EmailTemplatesTableCreateCompanionBuilder,
          $$EmailTemplatesTableUpdateCompanionBuilder,
          (
            EmailTemplateRow,
            BaseReferences<
              _$AppDatabase,
              $EmailTemplatesTable,
              EmailTemplateRow
            >,
          ),
          EmailTemplateRow,
          PrefetchHooks Function()
        > {
  $$EmailTemplatesTableTableManager(
    _$AppDatabase db,
    $EmailTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmailTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmailTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmailTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmailTemplatesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                subject: subject,
                body: body,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String subject,
                required String body,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmailTemplatesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                subject: subject,
                body: body,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmailTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmailTemplatesTable,
      EmailTemplateRow,
      $$EmailTemplatesTableFilterComposer,
      $$EmailTemplatesTableOrderingComposer,
      $$EmailTemplatesTableAnnotationComposer,
      $$EmailTemplatesTableCreateCompanionBuilder,
      $$EmailTemplatesTableUpdateCompanionBuilder,
      (
        EmailTemplateRow,
        BaseReferences<_$AppDatabase, $EmailTemplatesTable, EmailTemplateRow>,
      ),
      EmailTemplateRow,
      PrefetchHooks Function()
    >;
typedef $$EmailSequencesTableCreateCompanionBuilder =
    EmailSequencesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      Value<String?> description,
      required String steps,
      Value<bool?> active,
      Value<int> rowid,
    });
typedef $$EmailSequencesTableUpdateCompanionBuilder =
    EmailSequencesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String> steps,
      Value<bool?> active,
      Value<int> rowid,
    });

class $$EmailSequencesTableFilterComposer
    extends Composer<_$AppDatabase, $EmailSequencesTable> {
  $$EmailSequencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmailSequencesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmailSequencesTable> {
  $$EmailSequencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmailSequencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmailSequencesTable> {
  $$EmailSequencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$EmailSequencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmailSequencesTable,
          EmailSequenceRow,
          $$EmailSequencesTableFilterComposer,
          $$EmailSequencesTableOrderingComposer,
          $$EmailSequencesTableAnnotationComposer,
          $$EmailSequencesTableCreateCompanionBuilder,
          $$EmailSequencesTableUpdateCompanionBuilder,
          (
            EmailSequenceRow,
            BaseReferences<
              _$AppDatabase,
              $EmailSequencesTable,
              EmailSequenceRow
            >,
          ),
          EmailSequenceRow,
          PrefetchHooks Function()
        > {
  $$EmailSequencesTableTableManager(
    _$AppDatabase db,
    $EmailSequencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmailSequencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmailSequencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmailSequencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> steps = const Value.absent(),
                Value<bool?> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmailSequencesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                steps: steps,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String steps,
                Value<bool?> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmailSequencesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                steps: steps,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmailSequencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmailSequencesTable,
      EmailSequenceRow,
      $$EmailSequencesTableFilterComposer,
      $$EmailSequencesTableOrderingComposer,
      $$EmailSequencesTableAnnotationComposer,
      $$EmailSequencesTableCreateCompanionBuilder,
      $$EmailSequencesTableUpdateCompanionBuilder,
      (
        EmailSequenceRow,
        BaseReferences<_$AppDatabase, $EmailSequencesTable, EmailSequenceRow>,
      ),
      EmailSequenceRow,
      PrefetchHooks Function()
    >;
typedef $$SequenceEnrollmentsTableCreateCompanionBuilder =
    SequenceEnrollmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String sequenceId,
      required String contactId,
      required String ownerId,
      required int step,
      Value<DateTime?> nextSendAt,
      required String status,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SequenceEnrollmentsTableUpdateCompanionBuilder =
    SequenceEnrollmentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> sequenceId,
      Value<String> contactId,
      Value<String> ownerId,
      Value<int> step,
      Value<DateTime?> nextSendAt,
      Value<String> status,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$SequenceEnrollmentsTableFilterComposer
    extends Composer<_$AppDatabase, $SequenceEnrollmentsTable> {
  $$SequenceEnrollmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sequenceId => $composableBuilder(
    column: $table.sequenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextSendAt => $composableBuilder(
    column: $table.nextSendAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SequenceEnrollmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SequenceEnrollmentsTable> {
  $$SequenceEnrollmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sequenceId => $composableBuilder(
    column: $table.sequenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextSendAt => $composableBuilder(
    column: $table.nextSendAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SequenceEnrollmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SequenceEnrollmentsTable> {
  $$SequenceEnrollmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sequenceId => $composableBuilder(
    column: $table.sequenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<DateTime> get nextSendAt => $composableBuilder(
    column: $table.nextSendAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SequenceEnrollmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SequenceEnrollmentsTable,
          EnrollmentRow,
          $$SequenceEnrollmentsTableFilterComposer,
          $$SequenceEnrollmentsTableOrderingComposer,
          $$SequenceEnrollmentsTableAnnotationComposer,
          $$SequenceEnrollmentsTableCreateCompanionBuilder,
          $$SequenceEnrollmentsTableUpdateCompanionBuilder,
          (
            EnrollmentRow,
            BaseReferences<
              _$AppDatabase,
              $SequenceEnrollmentsTable,
              EnrollmentRow
            >,
          ),
          EnrollmentRow,
          PrefetchHooks Function()
        > {
  $$SequenceEnrollmentsTableTableManager(
    _$AppDatabase db,
    $SequenceEnrollmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SequenceEnrollmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SequenceEnrollmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SequenceEnrollmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> sequenceId = const Value.absent(),
                Value<String> contactId = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int> step = const Value.absent(),
                Value<DateTime?> nextSendAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SequenceEnrollmentsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                sequenceId: sequenceId,
                contactId: contactId,
                ownerId: ownerId,
                step: step,
                nextSendAt: nextSendAt,
                status: status,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String sequenceId,
                required String contactId,
                required String ownerId,
                required int step,
                Value<DateTime?> nextSendAt = const Value.absent(),
                required String status,
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SequenceEnrollmentsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                sequenceId: sequenceId,
                contactId: contactId,
                ownerId: ownerId,
                step: step,
                nextSendAt: nextSendAt,
                status: status,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SequenceEnrollmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SequenceEnrollmentsTable,
      EnrollmentRow,
      $$SequenceEnrollmentsTableFilterComposer,
      $$SequenceEnrollmentsTableOrderingComposer,
      $$SequenceEnrollmentsTableAnnotationComposer,
      $$SequenceEnrollmentsTableCreateCompanionBuilder,
      $$SequenceEnrollmentsTableUpdateCompanionBuilder,
      (
        EnrollmentRow,
        BaseReferences<_$AppDatabase, $SequenceEnrollmentsTable, EnrollmentRow>,
      ),
      EnrollmentRow,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      Value<String?> description,
      Value<int?> unitPriceCents,
      Value<int?> vatRate,
      Value<String?> unit,
      Value<String?> accountCode,
      Value<bool?> active,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<int?> unitPriceCents,
      Value<int?> vatRate,
      Value<String?> unit,
      Value<String?> accountCode,
      Value<bool?> active,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceCents => $composableBuilder(
    column: $table.unitPriceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceCents => $composableBuilder(
    column: $table.unitPriceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitPriceCents => $composableBuilder(
    column: $table.unitPriceCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get accountCode => $composableBuilder(
    column: $table.accountCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> unitPriceCents = const Value.absent(),
                Value<int?> vatRate = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> accountCode = const Value.absent(),
                Value<bool?> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                unitPriceCents: unitPriceCents,
                vatRate: vatRate,
                unit: unit,
                accountCode: accountCode,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int?> unitPriceCents = const Value.absent(),
                Value<int?> vatRate = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> accountCode = const Value.absent(),
                Value<bool?> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                unitPriceCents: unitPriceCents,
                vatRate: vatRate,
                unit: unit,
                accountCode: accountCode,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String kind,
      required String status,
      Value<String?> number,
      Value<String?> subject,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<String?> quoteId,
      Value<String?> originalInvoiceId,
      Value<String?> issueDate,
      Value<String?> serviceDate,
      Value<String?> dueDate,
      Value<String?> validUntil,
      required String lines,
      Value<int?> totalHtCents,
      Value<int?> totalVatCents,
      Value<int?> totalTtcCents,
      Value<String?> vatBreakdown,
      Value<String?> buyer,
      Value<String?> seller,
      Value<String?> notes,
      Value<String?> paymentTerms,
      Value<String?> buyerReference,
      Value<String?> serviceCode,
      Value<String?> pdfFileId,
      Value<String?> chorusFlux,
      Value<String?> chorusStatus,
      Value<DateTime?> sentAt,
      Value<String?> ownerId,
      Value<int> rowid,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> kind,
      Value<String> status,
      Value<String?> number,
      Value<String?> subject,
      Value<String?> organisationId,
      Value<String?> contactId,
      Value<String?> dealId,
      Value<String?> quoteId,
      Value<String?> originalInvoiceId,
      Value<String?> issueDate,
      Value<String?> serviceDate,
      Value<String?> dueDate,
      Value<String?> validUntil,
      Value<String> lines,
      Value<int?> totalHtCents,
      Value<int?> totalVatCents,
      Value<int?> totalTtcCents,
      Value<String?> vatBreakdown,
      Value<String?> buyer,
      Value<String?> seller,
      Value<String?> notes,
      Value<String?> paymentTerms,
      Value<String?> buyerReference,
      Value<String?> serviceCode,
      Value<String?> pdfFileId,
      Value<String?> chorusFlux,
      Value<String?> chorusStatus,
      Value<DateTime?> sentAt,
      Value<String?> ownerId,
      Value<int> rowid,
    });

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteId => $composableBuilder(
    column: $table.quoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalInvoiceId => $composableBuilder(
    column: $table.originalInvoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalHtCents => $composableBuilder(
    column: $table.totalHtCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalVatCents => $composableBuilder(
    column: $table.totalVatCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTtcCents => $composableBuilder(
    column: $table.totalTtcCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatBreakdown => $composableBuilder(
    column: $table.vatBreakdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seller => $composableBuilder(
    column: $table.seller,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyerReference => $composableBuilder(
    column: $table.buyerReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceCode => $composableBuilder(
    column: $table.serviceCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfFileId => $composableBuilder(
    column: $table.pdfFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chorusFlux => $composableBuilder(
    column: $table.chorusFlux,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chorusStatus => $composableBuilder(
    column: $table.chorusStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dealId => $composableBuilder(
    column: $table.dealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteId => $composableBuilder(
    column: $table.quoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalInvoiceId => $composableBuilder(
    column: $table.originalInvoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalHtCents => $composableBuilder(
    column: $table.totalHtCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalVatCents => $composableBuilder(
    column: $table.totalVatCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTtcCents => $composableBuilder(
    column: $table.totalTtcCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatBreakdown => $composableBuilder(
    column: $table.vatBreakdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seller => $composableBuilder(
    column: $table.seller,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyerReference => $composableBuilder(
    column: $table.buyerReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceCode => $composableBuilder(
    column: $table.serviceCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfFileId => $composableBuilder(
    column: $table.pdfFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chorusFlux => $composableBuilder(
    column: $table.chorusFlux,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chorusStatus => $composableBuilder(
    column: $table.chorusStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get organisationId => $composableBuilder(
    column: $table.organisationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get dealId =>
      $composableBuilder(column: $table.dealId, builder: (column) => column);

  GeneratedColumn<String> get quoteId =>
      $composableBuilder(column: $table.quoteId, builder: (column) => column);

  GeneratedColumn<String> get originalInvoiceId => $composableBuilder(
    column: $table.originalInvoiceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<String> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lines =>
      $composableBuilder(column: $table.lines, builder: (column) => column);

  GeneratedColumn<int> get totalHtCents => $composableBuilder(
    column: $table.totalHtCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalVatCents => $composableBuilder(
    column: $table.totalVatCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTtcCents => $composableBuilder(
    column: $table.totalTtcCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatBreakdown => $composableBuilder(
    column: $table.vatBreakdown,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyer =>
      $composableBuilder(column: $table.buyer, builder: (column) => column);

  GeneratedColumn<String> get seller =>
      $composableBuilder(column: $table.seller, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyerReference => $composableBuilder(
    column: $table.buyerReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serviceCode => $composableBuilder(
    column: $table.serviceCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfFileId =>
      $composableBuilder(column: $table.pdfFileId, builder: (column) => column);

  GeneratedColumn<String> get chorusFlux => $composableBuilder(
    column: $table.chorusFlux,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chorusStatus => $composableBuilder(
    column: $table.chorusStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          InvoiceRow,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (
            InvoiceRow,
            BaseReferences<_$AppDatabase, $InvoicesTable, InvoiceRow>,
          ),
          InvoiceRow,
          PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<String?> quoteId = const Value.absent(),
                Value<String?> originalInvoiceId = const Value.absent(),
                Value<String?> issueDate = const Value.absent(),
                Value<String?> serviceDate = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<String?> validUntil = const Value.absent(),
                Value<String> lines = const Value.absent(),
                Value<int?> totalHtCents = const Value.absent(),
                Value<int?> totalVatCents = const Value.absent(),
                Value<int?> totalTtcCents = const Value.absent(),
                Value<String?> vatBreakdown = const Value.absent(),
                Value<String?> buyer = const Value.absent(),
                Value<String?> seller = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> paymentTerms = const Value.absent(),
                Value<String?> buyerReference = const Value.absent(),
                Value<String?> serviceCode = const Value.absent(),
                Value<String?> pdfFileId = const Value.absent(),
                Value<String?> chorusFlux = const Value.absent(),
                Value<String?> chorusStatus = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                kind: kind,
                status: status,
                number: number,
                subject: subject,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                quoteId: quoteId,
                originalInvoiceId: originalInvoiceId,
                issueDate: issueDate,
                serviceDate: serviceDate,
                dueDate: dueDate,
                validUntil: validUntil,
                lines: lines,
                totalHtCents: totalHtCents,
                totalVatCents: totalVatCents,
                totalTtcCents: totalTtcCents,
                vatBreakdown: vatBreakdown,
                buyer: buyer,
                seller: seller,
                notes: notes,
                paymentTerms: paymentTerms,
                buyerReference: buyerReference,
                serviceCode: serviceCode,
                pdfFileId: pdfFileId,
                chorusFlux: chorusFlux,
                chorusStatus: chorusStatus,
                sentAt: sentAt,
                ownerId: ownerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String kind,
                required String status,
                Value<String?> number = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> organisationId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> dealId = const Value.absent(),
                Value<String?> quoteId = const Value.absent(),
                Value<String?> originalInvoiceId = const Value.absent(),
                Value<String?> issueDate = const Value.absent(),
                Value<String?> serviceDate = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<String?> validUntil = const Value.absent(),
                required String lines,
                Value<int?> totalHtCents = const Value.absent(),
                Value<int?> totalVatCents = const Value.absent(),
                Value<int?> totalTtcCents = const Value.absent(),
                Value<String?> vatBreakdown = const Value.absent(),
                Value<String?> buyer = const Value.absent(),
                Value<String?> seller = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> paymentTerms = const Value.absent(),
                Value<String?> buyerReference = const Value.absent(),
                Value<String?> serviceCode = const Value.absent(),
                Value<String?> pdfFileId = const Value.absent(),
                Value<String?> chorusFlux = const Value.absent(),
                Value<String?> chorusStatus = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                kind: kind,
                status: status,
                number: number,
                subject: subject,
                organisationId: organisationId,
                contactId: contactId,
                dealId: dealId,
                quoteId: quoteId,
                originalInvoiceId: originalInvoiceId,
                issueDate: issueDate,
                serviceDate: serviceDate,
                dueDate: dueDate,
                validUntil: validUntil,
                lines: lines,
                totalHtCents: totalHtCents,
                totalVatCents: totalVatCents,
                totalTtcCents: totalTtcCents,
                vatBreakdown: vatBreakdown,
                buyer: buyer,
                seller: seller,
                notes: notes,
                paymentTerms: paymentTerms,
                buyerReference: buyerReference,
                serviceCode: serviceCode,
                pdfFileId: pdfFileId,
                chorusFlux: chorusFlux,
                chorusStatus: chorusStatus,
                sentAt: sentAt,
                ownerId: ownerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      InvoiceRow,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (InvoiceRow, BaseReferences<_$AppDatabase, $InvoicesTable, InvoiceRow>),
      InvoiceRow,
      PrefetchHooks Function()
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      required DateTime createdAt,
      Value<String?> createdBy,
      required DateTime updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      required String id,
      required String invoiceId,
      required int amountCents,
      Value<String?> paidOn,
      Value<String?> method,
      Value<String?> reference,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> version,
      Value<String> fieldMeta,
      Value<DateTime> createdAt,
      Value<String?> createdBy,
      Value<DateTime> updatedAt,
      Value<String?> updatedBy,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> invoiceId,
      Value<int> amountCents,
      Value<String?> paidOn,
      Value<String?> method,
      Value<String?> reference,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldMeta => $composableBuilder(
    column: $table.fieldMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get fieldMeta =>
      $composableBuilder(column: $table.fieldMeta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paidOn =>
      $composableBuilder(column: $table.paidOn, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (
            PaymentRow,
            BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>,
          ),
          PaymentRow,
          PrefetchHooks Function()
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> paidOn = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                invoiceId: invoiceId,
                amountCents: amountCents,
                paidOn: paidOn,
                method: method,
                reference: reference,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<String> fieldMeta = const Value.absent(),
                required DateTime createdAt,
                Value<String?> createdBy = const Value.absent(),
                required DateTime updatedAt,
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String invoiceId,
                required int amountCents,
                Value<String?> paidOn = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                version: version,
                fieldMeta: fieldMeta,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
                deletedAt: deletedAt,
                id: id,
                invoiceId: invoiceId,
                amountCents: amountCents,
                paidOn: paidOn,
                method: method,
                reference: reference,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>),
      PaymentRow,
      PrefetchHooks Function()
    >;
typedef $$OutboxTableCreateCompanionBuilder =
    OutboxCompanion Function({
      Value<int> seq,
      required String opId,
      required String entity,
      required String entityId,
      required int baseVersion,
      required String hlc,
      required String fields,
      required DateTime createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });
typedef $$OutboxTableUpdateCompanionBuilder =
    OutboxCompanion Function({
      Value<int> seq,
      Value<String> opId,
      Value<String> entity,
      Value<String> entityId,
      Value<int> baseVersion,
      Value<String> hlc,
      Value<String> fields,
      Value<DateTime> createdAt,
      Value<int> attempts,
      Value<String?> lastError,
    });

class $$OutboxTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseVersion => $composableBuilder(
    column: $table.baseVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlc => $composableBuilder(
    column: $table.hlc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseVersion => $composableBuilder(
    column: $table.baseVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlc => $composableBuilder(
    column: $table.hlc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get opId =>
      $composableBuilder(column: $table.opId, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<int> get baseVersion => $composableBuilder(
    column: $table.baseVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hlc =>
      $composableBuilder(column: $table.hlc, builder: (column) => column);

  GeneratedColumn<String> get fields =>
      $composableBuilder(column: $table.fields, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$OutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxTable,
          OutboxRow,
          $$OutboxTableFilterComposer,
          $$OutboxTableOrderingComposer,
          $$OutboxTableAnnotationComposer,
          $$OutboxTableCreateCompanionBuilder,
          $$OutboxTableUpdateCompanionBuilder,
          (OutboxRow, BaseReferences<_$AppDatabase, $OutboxTable, OutboxRow>),
          OutboxRow,
          PrefetchHooks Function()
        > {
  $$OutboxTableTableManager(_$AppDatabase db, $OutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                Value<String> opId = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<int> baseVersion = const Value.absent(),
                Value<String> hlc = const Value.absent(),
                Value<String> fields = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => OutboxCompanion(
                seq: seq,
                opId: opId,
                entity: entity,
                entityId: entityId,
                baseVersion: baseVersion,
                hlc: hlc,
                fields: fields,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                required String opId,
                required String entity,
                required String entityId,
                required int baseVersion,
                required String hlc,
                required String fields,
                required DateTime createdAt,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => OutboxCompanion.insert(
                seq: seq,
                opId: opId,
                entity: entity,
                entityId: entityId,
                baseVersion: baseVersion,
                hlc: hlc,
                fields: fields,
                createdAt: createdAt,
                attempts: attempts,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxTable,
      OutboxRow,
      $$OutboxTableFilterComposer,
      $$OutboxTableOrderingComposer,
      $$OutboxTableAnnotationComposer,
      $$OutboxTableCreateCompanionBuilder,
      $$OutboxTableUpdateCompanionBuilder,
      (OutboxRow, BaseReferences<_$AppDatabase, $OutboxTable, OutboxRow>),
      OutboxRow,
      PrefetchHooks Function()
    >;
typedef $$SyncErrorsTableCreateCompanionBuilder =
    SyncErrorsCompanion Function({
      Value<int> id,
      required String opId,
      required String entity,
      required String entityId,
      required String fields,
      required String message,
      required DateTime createdAt,
    });
typedef $$SyncErrorsTableUpdateCompanionBuilder =
    SyncErrorsCompanion Function({
      Value<int> id,
      Value<String> opId,
      Value<String> entity,
      Value<String> entityId,
      Value<String> fields,
      Value<String> message,
      Value<DateTime> createdAt,
    });

class $$SyncErrorsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncErrorsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opId => $composableBuilder(
    column: $table.opId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncErrorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get opId =>
      $composableBuilder(column: $table.opId, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get fields =>
      $composableBuilder(column: $table.fields, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncErrorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncErrorsTable,
          SyncErrorRow,
          $$SyncErrorsTableFilterComposer,
          $$SyncErrorsTableOrderingComposer,
          $$SyncErrorsTableAnnotationComposer,
          $$SyncErrorsTableCreateCompanionBuilder,
          $$SyncErrorsTableUpdateCompanionBuilder,
          (
            SyncErrorRow,
            BaseReferences<_$AppDatabase, $SyncErrorsTable, SyncErrorRow>,
          ),
          SyncErrorRow,
          PrefetchHooks Function()
        > {
  $$SyncErrorsTableTableManager(_$AppDatabase db, $SyncErrorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncErrorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncErrorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncErrorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> opId = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> fields = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncErrorsCompanion(
                id: id,
                opId: opId,
                entity: entity,
                entityId: entityId,
                fields: fields,
                message: message,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String opId,
                required String entity,
                required String entityId,
                required String fields,
                required String message,
                required DateTime createdAt,
              }) => SyncErrorsCompanion.insert(
                id: id,
                opId: opId,
                entity: entity,
                entityId: entityId,
                fields: fields,
                message: message,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncErrorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncErrorsTable,
      SyncErrorRow,
      $$SyncErrorsTableFilterComposer,
      $$SyncErrorsTableOrderingComposer,
      $$SyncErrorsTableAnnotationComposer,
      $$SyncErrorsTableCreateCompanionBuilder,
      $$SyncErrorsTableUpdateCompanionBuilder,
      (
        SyncErrorRow,
        BaseReferences<_$AppDatabase, $SyncErrorsTable, SyncErrorRow>,
      ),
      SyncErrorRow,
      PrefetchHooks Function()
    >;
typedef $$KeyValuesTableCreateCompanionBuilder =
    KeyValuesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$KeyValuesTableUpdateCompanionBuilder =
    KeyValuesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$KeyValuesTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KeyValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValuesTable,
          KeyValueRow,
          $$KeyValuesTableFilterComposer,
          $$KeyValuesTableOrderingComposer,
          $$KeyValuesTableAnnotationComposer,
          $$KeyValuesTableCreateCompanionBuilder,
          $$KeyValuesTableUpdateCompanionBuilder,
          (
            KeyValueRow,
            BaseReferences<_$AppDatabase, $KeyValuesTable, KeyValueRow>,
          ),
          KeyValueRow,
          PrefetchHooks Function()
        > {
  $$KeyValuesTableTableManager(_$AppDatabase db, $KeyValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValuesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => KeyValuesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValuesTable,
      KeyValueRow,
      $$KeyValuesTableFilterComposer,
      $$KeyValuesTableOrderingComposer,
      $$KeyValuesTableAnnotationComposer,
      $$KeyValuesTableCreateCompanionBuilder,
      $$KeyValuesTableUpdateCompanionBuilder,
      (
        KeyValueRow,
        BaseReferences<_$AppDatabase, $KeyValuesTable, KeyValueRow>,
      ),
      KeyValueRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$OrganisationsTableTableManager get organisations =>
      $$OrganisationsTableTableManager(_db, _db.organisations);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$PositionsTableTableManager get positions =>
      $$PositionsTableTableManager(_db, _db.positions);
  $$PipelinesTableTableManager get pipelines =>
      $$PipelinesTableTableManager(_db, _db.pipelines);
  $$PipelineStagesTableTableManager get pipelineStages =>
      $$PipelineStagesTableTableManager(_db, _db.pipelineStages);
  $$DealsTableTableManager get deals =>
      $$DealsTableTableManager(_db, _db.deals);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$TaggingsTableTableManager get taggings =>
      $$TaggingsTableTableManager(_db, _db.taggings);
  $$CustomFieldsTableTableManager get customFields =>
      $$CustomFieldsTableTableManager(_db, _db.customFields);
  $$SegmentsTableTableManager get segments =>
      $$SegmentsTableTableManager(_db, _db.segments);
  $$EmailTemplatesTableTableManager get emailTemplates =>
      $$EmailTemplatesTableTableManager(_db, _db.emailTemplates);
  $$EmailSequencesTableTableManager get emailSequences =>
      $$EmailSequencesTableTableManager(_db, _db.emailSequences);
  $$SequenceEnrollmentsTableTableManager get sequenceEnrollments =>
      $$SequenceEnrollmentsTableTableManager(_db, _db.sequenceEnrollments);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$OutboxTableTableManager get outbox =>
      $$OutboxTableTableManager(_db, _db.outbox);
  $$SyncErrorsTableTableManager get syncErrors =>
      $$SyncErrorsTableTableManager(_db, _db.syncErrors);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db, _db.keyValues);
}
