import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/core/my_snackbar.dart';
import 'package:jihagz/features/settings/data/data_source/setting_controller.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'location_picker_controller.dart';

class AddMissingPlaceController extends GetxController {
  //=================== variables
  RxString imagesError = ''.obs;
  RxString locationError = ''.obs;

  final RxBool showSuccess = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController customTypeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationUrlController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();
  RxBool isLocationFromCurrent = false.obs;
  RxBool isAddPrice = false.obs;
  RxBool isAddPhone = false.obs;
  RxBool isAddLocationUrl = false.obs;
  var imageFiles = <File>[].obs;
  var imageUrls = <String>[].obs;
  var location = Rxn<LatLng>();
  // var verificationStatus = 'auto'.obs;
  final ImagePicker _picker = ImagePicker();
  RxnString activeImageButton = RxnString(); // 'camera' or 'gallery'
  RxBool isLoading = false.obs;
  RxString selectedType = 'Football'.obs;
  RxBool isUploading = false.obs;
  RxInt uploadedCount = 0.obs;

  //=================== functions

  Future<void> submit() async {
    final settingController = Get.find<SettingController>();
    if (nameController.text.isNotEmpty &&
        imageFiles.isNotEmpty &&
        location.value != null) {
      // check if the place is verified
      bool isVerified = false;
      if (settingController.alwaysAddPlaceVerified.value) {
        isVerified = true;
        print('--------------------------------');
        print('place is verified by admin');
        print('--------------------------------');
      } else {
        isVerified = checkVerification();
      }

      // TODO: upload images to server and get the url
      List<String> urls = await uploadFilesToCloudinary(imageFiles);
      imageUrls.value = urls;
      // print('urls: $urls');

      // TODO: upload url and data to supabase

      sendDataToServer(urls, isVerified);
    }
  }

  void sendDataToServer(List<String> urls, bool isVerified) async {
    final name = nameController.text.trim();
    final supabase = Supabase.instance.client;
    final location = this.location.value;

    // Check required fields
    if (name.isEmpty || location == null || urls.isEmpty) {
      Get.snackbar('Error', 'Type, Name, location, and images are required');
      return;
    }

    // Optional fields
    final price = isAddPrice.value
        ? double.tryParse(priceController.text.trim())
        : null;
    final type = selectedType.value.isNotEmpty ? selectedType.value : null;
    final phoneNumber = phoneController.text.trim().isNotEmpty
        ? phoneController.text.trim()
        : null;
    final userId = supabase.auth.currentUser?.id;

    final data = {
      'name': name,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'images': urls,
      'price': price,
      'type': type?.toLowerCase(),
      'phone_number': phoneNumber,
      'added_by': userId,
    };

    final tableName = isVerified
        ? 'sports_clubs_verified'
        : 'sports_clubs_unverified';

    final response = await supabase
        .from(tableName)
        .insert(data)
        .select()
        .maybeSingle();

    if (response != null) {
      showSuccess.value = true;
      addPoints();
    }
  }

  void addPoints() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    // Increase points
    if (userId != null) {
      final profileRes = await supabase
          .from('profiles')
          .select('points')
          .eq('id', userId)
          .maybeSingle();

      if (profileRes != null) {
        final currentPoints = (profileRes['points'] ?? 0) as int;

        await supabase
            .from('profiles')
            .update({'points': currentPoints + 10})
            .eq('id', userId);
      }
    }

    // Hide the message after 3 seconds and go back
    Future.delayed(Duration(seconds: 3), () {
      showSuccess.value = false;
      Get.back();
    });
  }

  bool checkVerification() {
    bool isSameType = false;
    for (int i = 0; i < AppCore.sportTypes.length; i++) {
      if (selectedType.value == AppCore.sportTypes[i]) {
        isSameType = true;
      }
    }

    if (activeImageButton.value == 'camera' &&
        isLocationFromCurrent.value == true &&
        isSameType) {
      return true;
    } else {
      return false;
    }
  }

  void addImage(File file, {bool fromCamera = false}) {
    imageFiles.add(file);
  }

  void removeImage(int index) {
    if (index >= 0 && index < imageFiles.length) {
      imageFiles.removeAt(index);
      if (imageFiles.isEmpty) {
        activeImageButton.value = null;
      }
    }
  }

  void setLocation(LatLng? loc) {
    locationError.value = '';
    location.value = loc;
  }

  ///==================== verification

  void clear() {
    isLocationFromCurrent.value = false;
    imagesError.value = '';
    locationError.value = '';
    imageFiles.clear();
    location.value = null;
  }

  Future<void> pickImage({required bool fromCamera}) async {
    isLoading.value = true;
    try {
      if (fromCamera) {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          addImage(File(pickedFile.path), fromCamera: true);
          activeImageButton.value = 'camera';
        }
      } else {
        final pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          for (final file in pickedFiles) {
            addImage(File(file.path), fromCamera: false);
          }
          activeImageButton.value = 'gallery';
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void resetImageButtons() {
    activeImageButton.value = null;
  }

  Future<void> pickCurrentLocation() async {
    isLoading.value = true;
    try {
      final currentLocation = await LocationPickerController()
          .getCurrentLocation();
      if (currentLocation != null) {
        setLocation(currentLocation);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<String>> uploadFilesToCloudinary(List<File> files) async {
    isUploading.value = true;
    uploadedCount.value = 0;
    const String cloudName = 'dnzs6jkya';
    const String uploadPreset = 'jihagz';
    final List<String> uploadedUrls = [];
    try {
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final uploadUrl =
            'https://api.cloudinary.com/v1_1/$cloudName/auto/upload';
        final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = 'public'
          ..files.add(await http.MultipartFile.fromPath('file', file.path));
        final response = await request.send();
        if (response.statusCode == 200) {
          final respStr = await response.stream.bytesToString();
          final data = json.decode(respStr);
          uploadedUrls.add(data['secure_url']);
        } else {
          isUploading.value = false;
          mySnackbar('Error', 'Failed to upload file', ContentType.failure);
          print('❌ Failed to upload file: ${response.statusCode}');
          throw Exception('❌ Failed to upload file: ${response.statusCode}');
        }
        uploadedCount.value = i + 1;
      }
    } catch (e) {
      print('Upload error: \\${e.toString()}');
      rethrow;
    } finally {
      isUploading.value = false;
    }
    return uploadedUrls;
  }
}
