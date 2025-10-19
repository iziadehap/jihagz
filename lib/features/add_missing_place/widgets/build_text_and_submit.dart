import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/add_missing_place/controller/add_missing_place_controller.dart';
import 'package:jihagz/features/add_missing_place/screens/add_missing_place.dart';

class BuildTextAndSubmit extends StatelessWidget {
  const BuildTextAndSubmit({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final AddMissingPlaceController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    return Column(
      children: [
        const SizedBox(height: 28),
        Obx(
          () =>
              controller.isLocationFromCurrent.value == true &&
                  controller.activeImageButton.value == 'camera'
              ? Text(
                  'This place will be added directly (auto-verified).',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : controller.isLocationFromCurrent.value == false &&
                        controller.activeImageButton.value == 'camera' ||
                    controller.activeImageButton.value == 'gallery'
              ? Text(
                  'This place will require developer verification.',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : SizedBox(),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: Icon(Icons.check_circle, color: Colors.white),
            label: Text(
              'Submit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: appCore.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              bool valid = formKey.currentState?.validate() ?? false;
              controller.imagesError.value = '';
              controller.locationError.value = '';
              if (controller.imageFiles.isEmpty) {
                controller.imagesError.value = 'At least one image is required';
                valid = false;
              }
              if (controller.location.value == null) {
                controller.locationError.value = 'Location is required';
                valid = false;
              }
              if (valid) {
                controller.submit();
              }
            },
          ),
        ),
      ],
    );
  }
}
