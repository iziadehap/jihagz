import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/add_missing_place/controller/add_missing_place_controller.dart';
import 'package:jihagz/features/add_missing_place/screens/location_picker_screen.dart';
import 'package:jihagz/features/add_missing_place/widgets/button_model.dart';
import 'package:latlong2/latlong.dart';

class BuildLocationPicker extends StatelessWidget {
  BuildLocationPicker({super.key, required this.controller});

  final AddMissingPlaceController controller;

  final appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'Location',
          style: TextStyle(
            color: appCore.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (controller.location.value == null) {
            return Column(
              children: [
                Row(
                  children: [
                    ButtonModel(
                      icon: Icons.map,
                      text: 'Pick from Map',
                      onPressed: () async {
                        controller.isLocationFromCurrent.value = false;
                        controller.isLoading.value = true;
                        final result = await Get.to(
                          () => LocationPickerScreen(),
                        );
                        if (result != null) {
                          controller.setLocation(result);
                        }
                        controller.isLoading.value = false;
                      },
                    ),
                    const SizedBox(width: 16),
                    ButtonModel(
                      icon: Icons.my_location,
                      text: 'Pick My Location',
                      onPressed: () async {
                        controller.isLocationFromCurrent.value = true;
                        await controller.pickCurrentLocation();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LatLngInput(controller: controller),
                const SizedBox(height: 25),
              ],
            );
          } else {
            return _LocationMapPreview(
              controller: controller,
              appCore: appCore,
            );
          }
        }),
        const SizedBox(height: 8),
        Obx(() {
          return controller.locationError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    controller.locationError.value,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                )
              : SizedBox.shrink();
        }),
        Text(
          'Tip: Using current location and taking a photo is more verified.',
          style: TextStyle(color: Colors.orangeAccent, fontSize: 13),
        ),
      ],
    );
  }
}

class LatLngInput extends StatelessWidget {
  final AddMissingPlaceController controller;
  const LatLngInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller.latController,
            decoration: InputDecoration(
              labelText: 'Latitude',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller.lngController,
            decoration: InputDecoration(
              labelText: 'Longitude',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              if (controller.latController.text.isEmpty ||
                  controller.lngController.text.isEmpty) {
                controller.locationError.value = 'Please enter valid numbers.';
                return;
              }
              controller.locationError.value = '';
              controller.setLocation(
                LatLng(
                  double.parse(controller.latController.text),
                  double.parse(controller.lngController.text),
                ),
              );
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: appCore.primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(child: Text('Enter')),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddLocationUrlButton extends StatelessWidget {
  final AddMissingPlaceController controller;
  final AppCore appCore;
  const _AddLocationUrlButton({
    required this.controller,
    required this.appCore,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isAddLocationUrl.value = true;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: appCore.secondaryColor),
          const SizedBox(width: 8),
          Text('get location from url'),
        ],
      ),
    );
  }
}

class _LocationMapPreview extends StatelessWidget {
  final AddMissingPlaceController controller;
  final AppCore appCore;
  const _LocationMapPreview({required this.controller, required this.appCore});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.width * 0.7,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: appCore.primaryColor, width: 2),
            color: appCore.surfaceColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FlutterMap(
              options: MapOptions(
                initialCenter: controller.location.value!,
                initialZoom: 17,
                // interactiveFlags: InteractiveFlag.none,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.jihagz.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: controller.location.value!,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.place,
                        color: appCore.primaryColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 10),
            child: GestureDetector(
              onTap: () => controller.setLocation(null),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
