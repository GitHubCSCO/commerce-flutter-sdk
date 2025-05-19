class KeyValuePair<K, V> {
  final K key;
  final V value;

  const KeyValuePair(this.key, this.value);

  Map<String, dynamic> toJson() {
    return {'key': key, 'value': value};
  }

  factory KeyValuePair.fromJson(Map<String, dynamic> json) {
    return KeyValuePair(json['key'] as K, json['value'] as V);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyValuePair && key == other.key && value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}
