import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProgressDialog {
  static void show({
    String? message,
    Color color = Colors.red,  // Default color
    double size = 40.0,         // Default size
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Widget body = Center(
        child: CircularProgressIndicator(
          color: color,  // Set the color here
          strokeWidth: 5.0,  // Optionally set the stroke width
        ),
      );

      if (message != null) {
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                color: color,  // Set the color here
                strokeWidth: 5.0,  // Optionally set the stroke width
              ),
            ),
            const SizedBox(height: 20),  // Reduced spacing
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,  // Adjust text size if needed
              ),
            ),
          ],
        );
      }

      Get.dialog(
        body,
        barrierDismissible: false,
      );
    });
  }

  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
