import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationPickerController extends GetxController {
  var selectedLocation = Rxn<LatLng>();
  var currentZoom = 15.0.obs;
  late final MapController mapController;
  var showZoomMessage = false.obs;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    selectedLocation.value = null;
    getCurrentLocation().then((loc) {
      if (loc != null) {
        selectedLocation.value = loc;
      }
    });
  }

  void setLocation(LatLng loc,) {
    selectedLocation.value = loc;
    
  }

  void clear() {
    selectedLocation.value = null;
  }

  void setZoom(double zoom) {
    currentZoom.value = zoom;
  }

  Future<void> animateToZoom17() async {
    showZoomMessage.value = true;
    await mapController.move(selectedLocation.value!, 17.0);
    currentZoom.value = 17.0;
    await Future.delayed(Duration(seconds: 1));
    showZoomMessage.value = false;
  }

  Future<LatLng?> getCurrentLocation() async {
    try {
      Location location = Location();
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }
      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }
      if (_permissionGranted == PermissionStatus.granted) {
        final locData = await location.getLocation();
        return LatLng(locData.latitude ?? 0, locData.longitude ?? 0);
      }
    } catch (e) {
      print('Location error: $e');
    }
    return null;
  }
}
