import 'package:hive_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
  final int color;
  @HiveField(6)
  final String id;
  @HiveField(7)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.isCompleted,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
  });

  copyWith({
    String? title,
    bool? isCompleted,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
  }) {
    return TaskModel(
      id: id,
      isCompleted: isCompleted ?? this.isCompleted,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
    );
  }
}
