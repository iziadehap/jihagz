import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import '../../data/data_source/location_picker_controller.dart';

class LocationPickerScreen extends StatelessWidget {
  LocationPickerScreen({Key? key}) : super(key: key);

  final AppCore appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    final LocationPickerController controller = Get.put(
      LocationPickerController(),
    );
    final Color darkBg = appCore.backgroundColor.withOpacity(0.98);
    final Color accent = appCore.primaryColor;
    final Color buttonBg = appCore.surfaceColor.withOpacity(0.95);
    return Scaffold(
      backgroundColor: darkBg,
      body: Obx(
        () => controller.selectedLocation.value == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(accent),
                ),
              )
            : _buildBody(context, controller, accent, buttonBg),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    LocationPickerController controller,
    Color accent,
    Color buttonBg,
  ) {
    return Stack(
      children: [
        Obx(
          () => FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: LatLng(controller.selectedLocation.value!.latitude, controller.selectedLocation.value!.longitude),
              initialZoom: controller.currentZoom.value,
              onPositionChanged: (pos, _) {
                controller.setLocation(pos.center!);
                controller.setZoom(pos.zoom!);
              },
              interactionOptions: const InteractionOptions(
                flags:
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag, // disables rotation
              ),
              initialRotation: 0,
            ),
            children: [
              // TileLayer(
              //   urlTemplate: 'https://tiles.openfreemap.org/{z}/{x}/{y}.png',
              //   subdomains: ['a', 'b', 'c'], // ممكن تشيلها لو مش مستخدمة عندهم
              //   tileProvider:
              //       NetworkTileProvider(), // دا الإعداد الافتراضي، بس حلو توضيحه
              // ),
               TileLayer(
            urlTemplate:
                'https://tile.jawg.io/52c3289b-2829-4017-a2fc-34a1df57ebdb/{z}/{x}/{y}{r}.png?access-token=HKh5hllXhfPiYyNOntyTGx7EFjIHBQaRTxP46WKFuMgS0Km1p6ozg1dKpqE6n80o',
            userAgentPackageName: 'com.jihagz.app', // بدّله باسم باكدجك
            // attributionBuilder: (_) {
            //   return Text(
              //   '© Jawg | © OpenStreetMap contributors',
              //   style: TextStyle(fontSize: 12),
              // );
            // },
          ),
            ],
          ),
        ),
        // Crosshair
        Center(child: Icon(Icons.place, color: accent, size: 40)),
        // Top bar: back button (now circular and using AppCore color)
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 12.0),
              child: ClipOval(
                child: Material(
                  color: buttonBg,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.arrow_back, color: accent, size: 26),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Top right: zoom in/out buttons (now using AppCore color)
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'zoom_in',
                    mini: true,
                    backgroundColor: buttonBg,
                    onPressed: () {
                      final newZoom = controller.currentZoom.value + 1;
                      controller.mapController.move(
                        controller.selectedLocation.value!,
                        newZoom,
                      );
                      controller.setZoom(newZoom);
                    },
                    child: Icon(Icons.zoom_in, color: accent),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: 'zoom_out',
                    mini: true,
                    backgroundColor: buttonBg,
                    onPressed: () {
                      final newZoom = controller.currentZoom.value - 1;
                      controller.mapController.move(
                        controller.selectedLocation.value!,
                        newZoom,
                      );
                      controller.setZoom(newZoom);
                    },
                    child: Icon(Icons.zoom_out, color: accent),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Bottom info and button
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Zoom info row with icon
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Zoom: ${controller.currentZoom.value.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      controller.currentZoom.value >= 17.0
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 22,
                            )
                          : Icon(Icons.cancel, color: Colors.red, size: 22),
                    ],
                  ),
                ),
                // Good/Not good message
                Obx(
                  () => controller.currentZoom.value >= 17.0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Text(
                            'Zoom is good! You can pick the location.',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Text(
                            'Zoom in to 17 or more to pick a location.',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                // Coordinates
                Obx(
                  () => Text(
                    'Lat: ${controller.selectedLocation.value?.latitude.toStringAsFixed(6) ?? '--'}  |  Lng: ${controller.selectedLocation.value?.longitude.toStringAsFixed(6) ?? '--'}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.showZoomMessage.value
                      ? Text(
                          'Zoom must be 17 or more to pick location. Zooming...',
                          style: TextStyle(color: Colors.orangeAccent),
                        )
                      : SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.currentZoom.value >= 17.0
                            ? accent
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: controller.currentZoom.value >= 17.0
                          ? () {
                              Get.back(
                                result: controller.selectedLocation.value,
                              );
                            }
                          : () async {
                              await controller.animateToZoom17();
                            },
                      child: Text('Pick This Location'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
