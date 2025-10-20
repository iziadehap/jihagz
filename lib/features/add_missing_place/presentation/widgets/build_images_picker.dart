import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/add_missing_place/data/data_source/add_missing_place_controller.dart';
import 'package:jihagz/features/add_missing_place/presentation/widgets/button_model.dart';

class BuildImagesPicker extends StatelessWidget {
  BuildImagesPicker({super.key, required this.controller});

  final AddMissingPlaceController controller;

  final appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'Images',
          style: TextStyle(
            color: appCore.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final activeImageButton = controller.activeImageButton.value;
          if (activeImageButton == null) {
            return Row(
              children: [
                ButtonModel(
                  icon: Icons.camera_alt,
                  text: 'Take Photo',
                  onPressed: () => controller.pickImage(fromCamera: true),
                ),
                const SizedBox(width: 16),
                ButtonModel(
                  icon: Icons.image,
                  text: 'Import from Gallery',
                  onPressed: () => controller.pickImage(fromCamera: false),
                  isStackAllSize: true,
                ),
              ],
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(
                  activeImageButton == 'camera'
                      ? Icons.camera_alt
                      : Icons.image,
                  color: Colors.white,
                  size: 32,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    activeImageButton == 'camera'
                        ? 'Take Photo'
                        : 'Import from Gallery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appCore.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 6,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => controller.pickImage(
                  fromCamera: activeImageButton == 'camera',
                ),
                onLongPress: controller.resetImageButtons,
              ),
            );
          }
        }),
        const SizedBox(height: 12),
        Obx(
          () =>
              _buildImagePreview(controller.imageFiles, controller.removeImage),
        ),
        const SizedBox(height: 8),

        Obx(() {
          return controller.imagesError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    controller.imagesError.value,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                )
              : SizedBox.shrink();
        }),
        Divider(color: appCore.primaryColor.withOpacity(0.15)),
      ],
    );
  }

  Widget _buildImagePreview(List<File> images, void Function(int) onRemove) {
    return images.isEmpty
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, index) => Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        images[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => onRemove(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

// class ImagePreview extends StatelessWidget {
//   final List<File> images;
//   final void Function(int) onRemove;
//   const ImagePreview({Key? key, required this.images, required this.onRemove})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (images.isEmpty) return SizedBox();
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: SizedBox(
//         height: 100,
//         child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemCount: images.length,
//           separatorBuilder: (_, __) => SizedBox(width: 12),
//           itemBuilder: (context, index) => Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.file(
//                   images[index],
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: GestureDetector(
//                   onTap: () => onRemove(index),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.close, color: Colors.white, size: 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
