class AdditionalInfoEntity {
  final String key;
  final String value;

  AdditionalInfoEntity(
    this.key,
    this.value,
  );

  AdditionalInfoEntity.fromJson(Map<String, dynamic> json)
      : key = json.containsKey('key') ? json['key'] : '',
        value = json.containsKey('value') ? json['value'] : '';

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}
