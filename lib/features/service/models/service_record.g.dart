// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServiceRecordCollection on Isar {
  IsarCollection<ServiceRecord> get serviceRecords => this.collection();
}

const ServiceRecordSchema = CollectionSchema(
  name: r'ServiceRecord',
  id: 1320320961809859071,
  properties: {
    r'carId': PropertySchema(
      id: 0,
      name: r'carId',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'intervalKilometers': PropertySchema(
      id: 2,
      name: r'intervalKilometers',
      type: IsarType.long,
    ),
    r'intervalMonths': PropertySchema(
      id: 3,
      name: r'intervalMonths',
      type: IsarType.long,
    ),
    r'kilometers': PropertySchema(
      id: 4,
      name: r'kilometers',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 5,
      name: r'note',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 6,
      name: r'price',
      type: IsarType.double,
    ),
    r'reminderEnabled': PropertySchema(
      id: 7,
      name: r'reminderEnabled',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _ServiceRecordtypeEnumValueMap,
    )
  },
  estimateSize: _serviceRecordEstimateSize,
  serialize: _serviceRecordSerialize,
  deserialize: _serviceRecordDeserialize,
  deserializeProp: _serviceRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _serviceRecordGetId,
  getLinks: _serviceRecordGetLinks,
  attach: _serviceRecordAttach,
  version: '3.1.0+1',
);

int _serviceRecordEstimateSize(
  ServiceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.note.length * 3;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _serviceRecordSerialize(
  ServiceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.carId);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeLong(offsets[2], object.intervalKilometers);
  writer.writeLong(offsets[3], object.intervalMonths);
  writer.writeLong(offsets[4], object.kilometers);
  writer.writeString(offsets[5], object.note);
  writer.writeDouble(offsets[6], object.price);
  writer.writeBool(offsets[7], object.reminderEnabled);
  writer.writeString(offsets[8], object.title);
  writer.writeByte(offsets[9], object.type.index);
}

ServiceRecord _serviceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServiceRecord(
    carId: reader.readLong(offsets[0]),
    date: reader.readDateTime(offsets[1]),
    intervalKilometers: reader.readLongOrNull(offsets[2]),
    intervalMonths: reader.readLongOrNull(offsets[3]),
    kilometers: reader.readLong(offsets[4]),
    note: reader.readString(offsets[5]),
    price: reader.readDouble(offsets[6]),
    reminderEnabled: reader.readBool(offsets[7]),
    title: reader.readStringOrNull(offsets[8]),
    type: _ServiceRecordtypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
        ServiceType.oil,
  );
  object.id = id;
  return object;
}

P _serviceRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (_ServiceRecordtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          ServiceType.oil) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ServiceRecordtypeEnumValueMap = {
  'oil': 0,
  'airFilter': 1,
  'cabinFilter': 2,
  'fuelFilter': 3,
  'brakes': 4,
  'brakeFluid': 5,
  'coolant': 6,
  'transmissionOil': 7,
  'timingBelt': 8,
  'tires': 9,
  'battery': 10,
  'inspection': 11,
  'insurance': 12,
  'annualService': 13,
  'custom': 14,
};
const _ServiceRecordtypeValueEnumMap = {
  0: ServiceType.oil,
  1: ServiceType.airFilter,
  2: ServiceType.cabinFilter,
  3: ServiceType.fuelFilter,
  4: ServiceType.brakes,
  5: ServiceType.brakeFluid,
  6: ServiceType.coolant,
  7: ServiceType.transmissionOil,
  8: ServiceType.timingBelt,
  9: ServiceType.tires,
  10: ServiceType.battery,
  11: ServiceType.inspection,
  12: ServiceType.insurance,
  13: ServiceType.annualService,
  14: ServiceType.custom,
};

Id _serviceRecordGetId(ServiceRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serviceRecordGetLinks(ServiceRecord object) {
  return [];
}

void _serviceRecordAttach(
    IsarCollection<dynamic> col, Id id, ServiceRecord object) {
  object.id = id;
}

extension ServiceRecordQueryWhereSort
    on QueryBuilder<ServiceRecord, ServiceRecord, QWhere> {
  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ServiceRecordQueryWhere
    on QueryBuilder<ServiceRecord, ServiceRecord, QWhereClause> {
  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ServiceRecordQueryFilter
    on QueryBuilder<ServiceRecord, ServiceRecord, QFilterCondition> {
  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      carIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      carIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      carIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      carIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalKilometers',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalKilometers',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalKilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalKilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalKilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalKilometersBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalKilometers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalMonths',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalMonths',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      intervalMonthsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalMonths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      kilometersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      kilometersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      kilometersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kilometers',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      kilometersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kilometers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      reminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> typeEqualTo(
      ServiceType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      typeGreaterThan(
    ServiceType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition>
      typeLessThan(
    ServiceType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterFilterCondition> typeBetween(
    ServiceType lower,
    ServiceType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ServiceRecordQueryObject
    on QueryBuilder<ServiceRecord, ServiceRecord, QFilterCondition> {}

extension ServiceRecordQueryLinks
    on QueryBuilder<ServiceRecord, ServiceRecord, QFilterCondition> {}

extension ServiceRecordQuerySortBy
    on QueryBuilder<ServiceRecord, ServiceRecord, QSortBy> {
  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByIntervalKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalKilometers', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByIntervalKilometersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalKilometers', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalMonths', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByIntervalMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalMonths', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometers', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByKilometersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometers', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      sortByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ServiceRecordQuerySortThenBy
    on QueryBuilder<ServiceRecord, ServiceRecord, QSortThenBy> {
  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByIntervalKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalKilometers', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByIntervalKilometersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalKilometers', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalMonths', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByIntervalMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalMonths', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometers', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByKilometersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometers', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy>
      thenByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ServiceRecordQueryWhereDistinct
    on QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> {
  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carId');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct>
      distinctByIntervalKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalKilometers');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct>
      distinctByIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalMonths');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByKilometers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kilometers');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct>
      distinctByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderEnabled');
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceRecord, ServiceRecord, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension ServiceRecordQueryProperty
    on QueryBuilder<ServiceRecord, ServiceRecord, QQueryProperty> {
  QueryBuilder<ServiceRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServiceRecord, int, QQueryOperations> carIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carId');
    });
  }

  QueryBuilder<ServiceRecord, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ServiceRecord, int?, QQueryOperations>
      intervalKilometersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalKilometers');
    });
  }

  QueryBuilder<ServiceRecord, int?, QQueryOperations> intervalMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalMonths');
    });
  }

  QueryBuilder<ServiceRecord, int, QQueryOperations> kilometersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kilometers');
    });
  }

  QueryBuilder<ServiceRecord, String, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<ServiceRecord, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<ServiceRecord, bool, QQueryOperations>
      reminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderEnabled');
    });
  }

  QueryBuilder<ServiceRecord, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ServiceRecord, ServiceType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
