import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/home/widgets/day_header.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: UserCachingService.userBox.listenable(),
                builder: (context, userBox, child) {
                  return HomeHeader();
                },
              ),
              SizedBox(height: 20),
              DayHeader(selectedDate: selectedDate),
              SizedBox(height: 20),
              DatePicker(
                DateTime.now(),
                height: 110,
                width: 85,
                monthTextStyle: TextStyles.getBody(),
                dayTextStyle: TextStyles.getSmall(),
                dateTextStyle: TextStyles.getTitle(fontSize: 24),
                selectionColor: AppColors.primaryColor,
                initialSelectedDate: DateTime.now(),
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                    dateString = DateFormat('yyyy-MM-dd').format(date);
                  });
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: TaskCachingService.box.listenable(),
                  builder: (context, box, child) {
                    List<TaskModel> taskList = TaskCachingService.box.values
                        .toList()
                        .cast<TaskModel>();
                    List<TaskModel> filterdTaskList = [];
                    for (int i = 0; i < taskList.length; i++) {
                      if (taskList[i].date == dateString) {
                        filterdTaskList.add(taskList[i]);
                      }
                    }
                    if (filterdTaskList.isEmpty) {
                      return Center(child: Lottie.asset(AppAssets.empty));
                    } else {
                      return ListView.separated(
                        itemCount: filterdTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(taskModel: filterdTaskList[index]);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
