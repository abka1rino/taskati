import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/profile/pages/edit_profile.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${(UserCachingService.getUserData(UserCachingService.nameKey) as String).split(' ')[0]}',
                style: TextStyles.getTitle(color: AppColors.primaryColor),
              ),
              Text('Have A Nice Day.', style: TextStyles.getBody()),
            ],
          ),
        ),
        Expanded(child: SizedBox(width: 20)),
        GestureDetector(
          onTap: () {
            pushTo(context, EditAccountScreen());
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(
              File(
                UserCachingService.getUserData(UserCachingService.imageKey) ??
                    '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
