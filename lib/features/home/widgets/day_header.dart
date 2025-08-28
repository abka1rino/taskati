import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/add%20task%20screen/pages/add_task_screen.dart';

class DayHeader extends StatelessWidget {
  const DayHeader({super.key, this.selectedDate});
  final DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('yMMMMd').format(selectedDate ?? DateTime.now()),
                style: TextStyles.getTitle(),
              ),
              SizedBox(height: 4),
              Text(
                DateFormat('EEEE').format(selectedDate ?? DateTime.now()),
                style: TextStyles.getTitle(),
              ),
            ],
          ),
        ),
        MainButton(
          onPressed: () {
            pushTo(context, AddTaskScreen());
          },
          text: '+ Add Task',
          width: 139,
          height: 50,
        ),
      ],
    );
  }
}
