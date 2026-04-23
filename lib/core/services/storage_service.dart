// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// class StorageService extends GetxService {
//   late Box _userBox;
//   late Box _settingsBox;

//   static const String userBoxName = 'userBox';
//   static const String settingsBoxName = 'settingsBox';

//   Future<StorageService> init() async {
//     final authDirectory = await getApplicationDocumentsDirectory();
//     Hive.init(authDirectory.path);
//     await Hive.initFlutter();
    
//     _userBox = await Hive.openBox(userBoxName);
//     _settingsBox = await Hive.openBox(settingsBoxName);
    
//     return this;
//   }

//   // Generic Read Write Delete helpers
//   T? read<T>(String key, {String boxName = userBoxName}) {
//     if (boxName == settingsBoxName) {
//       return _settingsBox.get(key) as T?;
//     }
//     return _userBox.get(key) as T?;
//   }

//   Future<void> write(String key, dynamic value, {String boxName = userBoxName}) async {
//     if (boxName == settingsBoxName) {
//       await _settingsBox.put(key, value);
//     } else {
//       await _userBox.put(key, value);
//     }
//   }

//   Future<void> clearAll() async {
//     await _userBox.clear();
//     await _settingsBox.clear();
//   }
// }
