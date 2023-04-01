import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';

import 'package:get/get.dart';

showGetSnackbar(
    {required String message, bool isError = false, int? milliseconds = 3000}) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
      style: const TextStyle(color: AppColors.white),
    ),
    borderRadius: 10,
    duration:
        milliseconds != null ? Duration(milliseconds: milliseconds) : null,
    margin: EdgeInsets.all(6),
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: isError ? AppColors.primaryColor : AppColors.success,
    icon: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: AppColors.white,
      ),
    ),
  ));
}
