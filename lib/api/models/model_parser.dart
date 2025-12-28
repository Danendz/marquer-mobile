typedef JsonMap = Map<String, dynamic>;
typedef FromJson<T> = T Function(JsonMap json);

final class ModelParser {
  static List<T> listFromJson<T>(Object? json, FromJson<T> fromJson) {
    final list = json as List<dynamic>;
    return list.map((e) => fromJson(e as JsonMap)).toList();
  }

  static T objectFromJson<T>(Object? json, FromJson<T> fromJson) {
    return fromJson(json as JsonMap);
  }
}
