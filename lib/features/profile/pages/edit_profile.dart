import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool isDark = UserCachingService.getUserData(UserCachingService.isDark);
  TextEditingController nameControler = TextEditingController(
    text: UserCachingService.getUserData(UserCachingService.nameKey),
  );
  bool enabled = false;
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
                      onPressed: () {},
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
                        controller: nameControler,
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
                                UserCachingService.putUserData(
                                  UserCachingService.nameKey,
                                  nameControler.text,
                                );
                                setState(() {
                                  enabled = false;
                                });
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
}
