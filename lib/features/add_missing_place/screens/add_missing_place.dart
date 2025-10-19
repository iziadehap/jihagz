import 'package:flutter/material.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/add_missing_place/widgets/build_images_picker.dart';
import 'package:jihagz/features/add_missing_place/widgets/build_location_picker.dart';
import 'package:jihagz/features/add_missing_place/widgets/build_text_and_submit.dart';
import 'package:jihagz/features/add_missing_place/widgets/build_text_field.dart';
import 'package:jihagz/features/add_missing_place/widgets/top_title.dart';
import 'package:get/get.dart';
import '../controller/add_missing_place_controller.dart';

class AddMissingPlaceScreen extends StatelessWidget {
  AddMissingPlaceScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    AddMissingPlaceController controller = Get.put(AddMissingPlaceController());
    return PopScope(
      canPop: !(controller.isUploading.value),
      child: Scaffold(
        backgroundColor: appCore.backgroundColor,
        body: SafeArea(
          child: Container(
            color: appCore.surfaceColor.withOpacity(0.98),
            child: Center(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 24.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TopTitle(),
                            BuildTextField(controller: controller),
                            BuildImagesPicker(controller: controller),
                            BuildLocationPicker(controller: controller),
                            BuildTextAndSubmit(
                              controller: controller,
                              formKey: formKey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showLoading(controller: controller, appCore: appCore),
                  showUploading(controller: controller, appCore: appCore),
                  showSuccess(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class showLoading extends StatelessWidget {
  const showLoading({
    super.key,
    required this.controller,
    required this.appCore,
  });

  final AddMissingPlaceController controller;
  final AppCore appCore;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    appCore.primaryColor,
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}

class showSuccess extends StatelessWidget {
  const showSuccess({super.key, required this.controller});

  final AddMissingPlaceController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.showSuccess.value
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade600.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.celebration, color: Colors.white, size: 40),
                    SizedBox(height: 10),
                    Text(
                      '🎉 Thank you for adding the place!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '🏅 10 points have been added to your account.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}

class showUploading extends StatelessWidget {
  const showUploading({
    super.key,
    required this.controller,
    required this.appCore,
  });

  final AddMissingPlaceController controller;
  final AppCore appCore;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isUploading.value
          ? Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        appCore.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Uploading images: ${controller.uploadedCount.value}/${controller.imageFiles.length}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
