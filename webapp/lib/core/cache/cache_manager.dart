// import 'dart:convert';

// import 'package:webapp/core/cache/model/base_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CacheManager {
//   CacheManager._init();

//   static CacheManager get instance {
//     _instance ??= CacheManager._init();
//     return _instance!;
//   }

//   static CacheManager? _instance;

//   SharedPreferences? _preferences;
//   Future<SharedPreferences> get preferences async {
//     _preferences ??= await SharedPreferences.getInstance();
//     return _preferences!;
//   }

//   Future<bool> saveCacheData(String data, String key, Duration duration) async {
//     final pref = await preferences;
//     BaseCacheData local =
//         BaseCacheData(data: data, time: DateTime.now().add(duration));
//     final json = jsonEncode(local.toJson());
//     return await pref.setString(key, json);
//   }

//   Future<String?> getCacheData(String key) async {
//     final pref = await preferences;
//     final jsonString = pref.getString(key);
//     if (jsonString != null) {
//       final jsonModel = jsonDecode(jsonString);
//       final cacheData = BaseCacheData.fromJson(jsonModel);

//       if (DateTime.now().isAfter(cacheData.time)) {
//         return BaseCacheData.fromJson(jsonModel).data;
//       } else {
//         await removeCacheData(key);
//       }
//     }

//     return null;
//   }

//   Future<bool> removeAllCacheData(String key) async {
//     final pref = await preferences;
//     pref.getKeys().removeWhere((element) => element.contains(key));
//     return true;
//   }

//   Future<bool> removeCacheData(String key) async {
//     final pref = await preferences;
//     return await pref.remove(key);
//   }
// }
