import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/add%20task%20screen/widgets/text_with_form.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.taskModel});
  final TaskModel? taskModel;
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int selectedColor = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  void initState() {
    titleController.text = widget.taskModel?.title ?? '';
    descController.text = widget.taskModel?.description ?? '';
    dateController.text =
        widget.taskModel?.date ??
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    startTimeController.text =
        widget.taskModel?.startTime ?? DateFormat.jm().format(DateTime.now());
    endTimeController.text =
        widget.taskModel?.endTime ??
        DateFormat.jm().format(DateTime.now());
    super.initState();

    // Perform any initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 23.0),
        child: MainButton(
          text: (widget.taskModel == null) ? 'Create Task' : 'Update Task',
          onPressed: () {
            if (formKey.currentState!.validate()) {
              String id = '';
              if (widget.taskModel?.id != null) {
                id = widget.taskModel!.id;
              } else {
                id = startTimeController.text + endTimeController.text;
              }
              TaskCachingService.putTaskData(
                id,
                TaskModel(
                  id: id,
                  isCompleted: false,
                  title: titleController.text,
                  description: descController.text,
                  date: dateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                  color: selectedColor,
                ),
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Task',
          style: TextStyles.getTitle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextWithForm(
                controller: titleController,
                title: 'Title',
                hintText: 'Enter task title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextWithForm(
                controller: descController,
                title: 'Description',
                hintText: 'Enter task description',
                maxLines: 3,
              ),
              SizedBox(height: 12),
              TextWithForm(
                title: 'Date',
                readOnly: true,
                controller: dateController,
                suffixIcon: Icons.calendar_today,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      dateController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDate);
                    }
                  });
                },
              ),
              SizedBox(height: 12),
              timePicker(context),
              SizedBox(height: 12),
              colorPicker(),
            ],
          ),
        ),
      ),
    );
  }

  Column colorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: TextStyles.getBody(fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Row(
          spacing: 5,
          children: List.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: colors[index],
                child: index == selectedColor
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }

  Row timePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextWithForm(
            title: 'Start Time',
            controller: startTimeController,
            suffixIcon: Icons.access_time,
            readOnly: true,
            onTap: () async {
              var selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                startTimeController.text = selectedTime.format(context);
              }
            },
          ),
        ),
        SizedBox(width: 13),
        Expanded(
          child: TextWithForm(
            title: 'End Time',
            controller: endTimeController,
            suffixIcon: Icons.access_time,
            readOnly: true,
            onTap: () async {
              var selectedEndTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedEndTime != null) {

                  endTimeController.text = selectedEndTime.format(context);
                
              }
            },
          ),
        ),
      ],
    );
  }
}
