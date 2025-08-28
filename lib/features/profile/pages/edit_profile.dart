import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool isDark = UserCachingService.getUserData(UserCachingService.isDark);
  TextEditingController nameController = TextEditingController(
    text: UserCachingService.getUserData(UserCachingService.nameKey),
  );
  bool enabled = false;
  String? path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.primaryColor),
        actions: [
          IconButton(
            onPressed: () {
              UserCachingService.putUserData(
                UserCachingService.isDark,
                !isDark,
              );
              setState(() {
                isDark = !isDark;
              });
            },
            icon: isDark
                ? Icon(Icons.sunny, color: AppColors.primaryColor)
                : Icon(Icons.dark_mode, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(
                        File(
                          UserCachingService.getUserData(
                                UserCachingService.imageKey,
                              ) ??
                              AppAssets.user,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                    ),
                                    child: MainButton(
                                      text: 'Upload From Camera',
                                      onPressed: () => uplodeImage(true),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                    ),
                                    child: MainButton(
                                      text: 'Upload From Gallery',
                                      onPressed: () => uplodeImage(false),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Divider(indent: 25, endIndent: 25, color: AppColors.primaryColor),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        controller: nameController,
                        enabled: enabled,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                      child: enabled
                          ? IconButton(
                              onPressed: () {
                                if (nameController.text == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please Enter aname'),
                                      backgroundColor: AppColors.redColor,
                                    ),
                                  );
                                } else {
                                  UserCachingService.putUserData(
                                    UserCachingService.nameKey,
                                    nameController.text,
                                  );
                                  setState(() {
                                    enabled = false;
                                  });
                                }
                              },
                              icon: Icon(Icons.check),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  enabled = true;
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                    ),
                  ),
                ],
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
      UserCachingService.putUserData(UserCachingService.imageKey, path);
      setState(() {
        path = picker.path;
      });
    }
  }
}
