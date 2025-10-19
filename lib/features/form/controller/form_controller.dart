import 'package:get/get.dart';
import 'package:jihagz/core/appRoutes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormController extends GetxController {
  final SupabaseClient client = Supabase.instance.client;
  final int phoneNumberLength = 10;
  final RxString name = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString gender = ''.obs;
  final RxString age = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isProfileComplete = false.obs;
  final RxBool isPhoneNumberValid = false.obs;

  // Add error observables
  final RxString nameError = ''.obs;
  final RxString phoneError = ''.obs;
  final RxString ageError = ''.obs;
  final RxString genderError = ''.obs;

  Future<void> saveProfile() async {
    bool valid = true;

    // Name validation
    if (name.value.trim().isEmpty) {
      nameError.value = 'Please enter your name';
      valid = false;
    } else {
      nameError.value = '';
    }

    // Phone validation
    if (phoneNumber.value.length != phoneNumberLength) {
      phoneError.value = 'Enter a valid $phoneNumberLength-digit phone number';
      isPhoneNumberValid.value = false;
      valid = false;
    } else {
      phoneError.value = '';
      isPhoneNumberValid.value = true;
    }

    // Age validation
    if (age.value.trim().isEmpty) {
      ageError.value = 'Please enter your age';
      valid = false;
    } else {
      ageError.value = '';
    }

    // Gender validation
    if (gender.value.trim().isEmpty) {
      genderError.value = 'Please select your gender';
      valid = false;
    } else {
      genderError.value = '';
    }

    if (!valid) return;

    try {
      isLoading.value = true;
      final user = client.auth.currentUser;
      if (user != null) {
        await client.from('profiles').upsert({
          'id': user.id,
          'email': user.email,
          'name': name.value.trim(),
          'phone': "+20" + phoneNumber.value.trim(),
          'gender': gender.value.trim(),
          'age': int.tryParse(age.value.trim()),
          'points': 0,
        });
        isProfileComplete.value = true;
        Get.snackbar('Success', 'Profile saved successfully!');
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateName(String value) {
    name.value = value;
    if (value.trim().isNotEmpty) nameError.value = '';
  }

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
    if (value.length == phoneNumberLength) {
      isPhoneNumberValid.value = true;
      phoneError.value = '';
    } else {
      isPhoneNumberValid.value = false;
      phoneError.value = 'Enter a valid $phoneNumberLength-digit phone number';
    }
  }

  void updateGender(String value) {
    gender.value = value;
    if (value.trim().isNotEmpty) genderError.value = '';
  }

  void updateAge(String value) {
    age.value = value;
    if (value.trim().isNotEmpty) ageError.value = '';
  }
}
