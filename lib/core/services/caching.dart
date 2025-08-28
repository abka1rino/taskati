import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/models/task_model.dart';

class UserCachingService {
  static late Box userBox;
  static const String userBoxName = 'userBox';
  static const String nameKey = 'userName';
  static const String imageKey = 'userImage';
  static const String registeredKey = 'userRegistered';
  static const String isDark = 'isDark';

  static init() async {
    await Hive.initFlutter();
    userBox = await Hive.openBox(userBoxName);
  }

  static putUserData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getUserData(String key) {
    return userBox.get(key);
  }
}

class TaskCachingService {
  static late Box<TaskModel> box;
  static const String taskBoxName = 'taskBox';

  static init() async {
    Hive.registerAdapter(TaskModelAdapter());
    box = await Hive.openBox(taskBoxName);
  }

  static putTaskData(String key, TaskModel value) {
    box.put(key, value);
  }

  static getTaskData(String key) {
    return box.get(key);
  }
}
