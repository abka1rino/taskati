import 'package:flutter/material.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/add%20task%20screen/pages/add_task_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, AddTaskScreen(taskModel: taskModel));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            TaskCachingService.putTaskData(
              taskModel.id,
              taskModel.copyWith(isCompleted: true),
            );
          } else {
            TaskCachingService.box.delete(taskModel.id);
          }
        },
        background: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check, color: AppColors.whiteColor),
              SizedBox(width: 10),
              Text(
                'Completed',
                style: TextStyles.getBody(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.redColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: AppColors.whiteColor),
              SizedBox(width: 10),
              Text(
                'Delete',
                style: TextStyles.getBody(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: taskModel.isCompleted
                  ? Colors.green
                  : colors[taskModel.color],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.getTitle(color: Colors.white),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${taskModel.startTime} - ${taskModel.endTime}',
                              style: TextStyles.getBody(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          taskModel.description == ''
                              ? 'No Description'
                              : taskModel.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.getBody(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                      color: AppColors.greyColor,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      taskModel.isCompleted ? 'Completed' : 'TODO',
                      style: TextStyles.getTitle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
