// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_location_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BaseVmiLocationQueryParametersToJson(
    BaseVmiLocationQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  return val;
}

Map<String, dynamic> _$VmiLocationQueryParametersToJson(
    VmiLocationQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('userId', instance.userId);
  writeNotNull('filter', instance.filter);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}

Map<String, dynamic> _$VmiBinQueryParametersToJson(
    VmiBinQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  writeNotNull('filter', instance.filter);
  writeNotNull('searchCriteria', instance.searchCriteria);
  writeNotNull('binNumberFrom', instance.binNumberFrom);
  writeNotNull('binNumberTo', instance.binNumberTo);
  writeNotNull('previousCountFromDate',
      instance.previousCountFromDate?.toIso8601String());
  writeNotNull(
      'previousCountToDate', instance.previousCountToDate?.toIso8601String());
  val['expand'] = instance.expand;
  return val;
}

Map<String, dynamic> _$VmiCountQueryParametersToJson(
    VmiCountQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['vmiBinId'] = instance.vmiBinId;
  return val;
}

Map<String, dynamic> _$VmiNoteQueryParametersToJson(
    VmiNoteQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['vmiBinId'] = instance.vmiBinId;
  writeNotNull('vmiNoteId', instance.vmiNoteId);
  return val;
}

Map<String, dynamic> _$VmiLocationDetailParametersToJson(
    VmiLocationDetailParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['expand'] = instance.expand;
  return val;
}

Map<String, dynamic> _$VmiBinDetailParametersToJson(
    VmiBinDetailParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['vmiBinId'] = instance.vmiBinId;
  return val;
}

Map<String, dynamic> _$VmiCountDetailParametersToJson(
    VmiCountDetailParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['vmiBinId'] = instance.vmiBinId;
  val['vmiCountId'] = instance.vmiCountId;
  return val;
}

Map<String, dynamic> _$VmiNoteDetailParametersToJson(
    VmiNoteDetailParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['vmiBinId'] = instance.vmiBinId;
  val['vmiNoteId'] = instance.vmiNoteId;
  return val;
}

Map<String, dynamic> _$VmiLocationProductParametersToJson(
    VmiLocationProductParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  val['searchCriteria'] = instance.searchCriteria;
  val['expand'] = instance.expand;
  val['filter'] = instance.filter;
  return val;
}
