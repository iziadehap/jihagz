import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/my_snackbar.dart';
import '../../data/data_source/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  final SettingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Obx(
        () => ListView(
          children: [
            ListTile(
              title: const Text('Advanced Settings'),
              trailing: Switch(
                value: controller.advancedEnabled.value,
                onChanged: (val) async {
                  if (val) {
                    String password = '';
                    await Get.dialog(
                      AlertDialog(
                        title: const Text('Enter Password'),
                        content: TextField(
                          obscureText: true,
                          autofocus: true,
                          onChanged: (v) => password = v,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final ok = await controller
                                  .checkAndEnableAdvanced(password);
                              if (ok) {
                                Get.back();
                              } else {
                                mySnackbar(
                                  'Error',
                                  'Incorrect password',
                                  ContentType.failure,
                                );
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  } else {
                    controller.advancedEnabled.value = false;
                    controller.saveSettings();
                  }
                },
              ),
            ),
            if (controller.advancedEnabled.value)
              ListTile(
                title: const Text('Always add place in verified'),
                trailing: Switch(
                  value: controller.alwaysAddPlaceVerified.value,
                  onChanged: (val) => controller.setAlwaysAddPlaceVerified(val),
                ),
              ),
            // Add more settings here as needed
          ],
        ),
      ),
    );
  }
}
