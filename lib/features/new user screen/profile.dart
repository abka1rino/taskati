import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/features/home/pages/home_screen.dart';
import 'package:taskati/features/new%20user%20screen/widgets/custom_name_text_field.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  TextEditingController nameController = TextEditingController();
  String? path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && path != null) {
                UserCachingService.putUserData(
                  UserCachingService.registeredKey,
                  true,
                );
                UserCachingService.putUserData(
                  UserCachingService.nameKey,
                  nameController.text,
                );
                UserCachingService.putUserData(
                  UserCachingService.imageKey,
                  path,
                );
                UserCachingService.putUserData(
                  UserCachingService.isDark,
                  false,
                );
                pushWithReplacement(context, const HomeScreen());
              } else if (nameController.text.isEmpty && path != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter your name'),
                    backgroundColor: AppColors.redColor,
                  ),
                );
              } else if (path == null && nameController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please upload a profile picture'),
                    backgroundColor: AppColors.redColor,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please enter your name and upload a profile picture',
                    ),
                    backgroundColor: AppColors.redColor,
                  ),
                );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: path != null
                    ? FileImage(File(path ?? ''))
                    : AssetImage(AppAssets.user),
                radius: 70,
                backgroundColor: AppColors.primaryColor,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MainButton(
                  text: 'Upload From Camera',
                  onPressed: () => uplodeImage(true),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MainButton(
                  text: 'Upload From Gallery',
                  onPressed: () => uplodeImage(false),
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, indent: 25, endIndent: 25),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomNameTextField(controller: nameController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uplodeImage(bool isCamera) async {
    var picker = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (picker != null) {
      setState(() {
        path = picker.path;
      });
    }
  }
}
