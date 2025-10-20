import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/my_snackbar.dart';
import 'package:jihagz/core/supabase_model/sports_clubs_verified.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isShimmer = true.obs;
  List<SportsClubsVerified> allStadiumsFiltered = [];
  RxString selectedCategory = 'Football'.obs;
  List<SportsClubsVerified> nearbyStadiums = [];

  @override
  void onInit() {
    super.onInit();
    checkLocalAndGetData();
  }

  void checkLocalAndGetData() async {
    isShimmer.value = true;
    // await fromServer();
    final localData = await loadStadiumsFromLocal();
    // if (localData == null) {
    //   await fromServer();
    //   print('server data');
    // } else {
    //   print('local data');
    //   print(localData);
    // }
    await fromServer();
    await getNarbyStadiums();
    isShimmer.value = false;
  }

  Future<void> getNarbyStadiums() async {
    // Get user location
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
    final locData = await location.getLocation();
    if (locData.latitude == null || locData.longitude == null) {
      mySnackbar('Error', 'Failed to get location', ContentType.failure);
      return;
    }
    final userLatLng = LatLng(locData.latitude!, locData.longitude!);
    print(
      'User location: [32m${userLatLng.latitude}, ${userLatLng.longitude}[0m',
    );

    // Calculate distance to each stadium and set it
    final Distance distance = Distance();
    for (var stadium in allStadiumsFiltered) {
      final double stadiumLat = double.tryParse(stadium.latitude) ?? 0.0;
      final double stadiumLng = double.tryParse(stadium.longitude) ?? 0.0;
      stadium.distance = distance.as(
        LengthUnit.Kilometer,
        userLatLng,
        LatLng(stadiumLat, stadiumLng),
      );
      print(
        'Stadium: [34m${stadium.name}[0m | Lat: ${stadiumLat}, Lng: ${stadiumLng} | Distance: [33m${stadium.distance.toStringAsFixed(2)} km[0m',
      );
    }

    // Sort by distance and take the 3 nearest
    allStadiumsFiltered.sort((a, b) => (a.distance).compareTo(b.distance));
    nearbyStadiums = allStadiumsFiltered.take(3).toList();
    update();
  }

  /// Loads stadiums from local storage if data is fresh (within 1 hour).
  /// Returns null if data is missing or stale.
  Future<List<Map<String, dynamic>>?> loadStadiumsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final updatedAtStr = prefs.getString(
        '${selectedCategory}_stadiums_updated_at',
      );
      if (updatedAtStr != null) {
        final updatedAt = DateTime.tryParse(updatedAtStr);
        if (updatedAt != null &&
            updatedAt.isAfter(
              DateTime.now().subtract(const Duration(hours: 1)),
            )) {
          final jsonString = prefs.getString('${selectedCategory}_stadiums');
          if (jsonString != null) {
            final List<dynamic> jsonList = jsonDecode(jsonString);
            final List<Map<String, dynamic>> stadiumMaps = jsonList
                .map((e) => Map<String, dynamic>.from(e))
                .toList();
            allStadiumsFiltered = stadiumMaps
                .map((e) => SportsClubsVerified.fromJson(e))
                .toList();
            return stadiumMaps;
          }
        }
      }
      return null;
    } catch (e) {
      mySnackbar(
        'Error',
        'Failed to load stadiums from local',
        ContentType.failure,
      );
      return null;
    }
  }

  /// Saves stadiums to local storage with the current timestamp.
  Future<void> saveStadiumsToLocal(
    List<Map<String, dynamic>> stadiums,
    String selectedCategory,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final jsonString = jsonEncode(stadiums);
      await prefs.setString('${selectedCategory}_stadiums', jsonString);
      await prefs.setString(
        '${selectedCategory}_stadiums_updated_at',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      mySnackbar(
        'Error',
        'Failed to save stadiums to local',
        ContentType.failure,
      );
    }
  }

  /// Loads stadiums from the server and saves them locally.
  Future<List<Map<String, dynamic>>?> fromServer() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('sports_clubs_verified')
          .select('*')
          .eq(
            SportsClubsVerifiedModel().type,
            selectedCategory.value.toLowerCase(),
          );

      await saveStadiumsToLocal(
        List<Map<String, dynamic>>.from(response),
        selectedCategory.value,
      );
      allStadiumsFiltered = List<Map<String, dynamic>>.from(
        response,
      ).map((e) => SportsClubsVerified.fromJson(e)).toList();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      mySnackbar(
        'Error',
        'Failed to load stadiums from server',
        ContentType.failure,
      );
      return null;
    }
  }
}
