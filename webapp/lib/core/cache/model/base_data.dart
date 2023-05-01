import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BaseCacheData {
  DateTime time;
  String data;
  BaseCacheData({
    required this.time,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'data': data,
    };
  }

  factory BaseCacheData.fromMap(Map<String, dynamic> map) {
    return BaseCacheData(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseCacheData.fromJson(String source) =>
      BaseCacheData.fromMap(json.decode(source) as Map<String, dynamic>);
}
