// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryImpl _$$CountryImplFromJson(Map<String, dynamic> json) =>
    _$CountryImpl(
      name: json['name'] as String,
      capital: json['capital'] as String,
      flagUrl: json['flagUrl'] as String,
      languages: Map<String, String>.from(json['languages'] as Map),
    );

Map<String, dynamic> _$$CountryImplToJson(_$CountryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'capital': instance.capital,
      'flagUrl': instance.flagUrl,
      'languages': instance.languages,
    };
