import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_getx/presentation/pages/login_page.dart';

class ErrorDialog {
  static unAuthorizedError() {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Not authorized',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text('You have to login'),
              TextButton(
                onPressed: () {
                  log('Go to Login');
                  Get.offAll(
                    () => const LoginPage(),
                  );
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
