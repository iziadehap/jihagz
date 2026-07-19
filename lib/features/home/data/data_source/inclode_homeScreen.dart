import 'package:get/get.dart';
import 'package:jihagz/core/mock_data/demo_mode.dart';
import 'package:jihagz/core/mock_data/mock_data.dart';
import 'package:jihagz/core/supabase_model/profiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InclodeHomeController extends GetxController {
  final profileModel = ProfileModel();
  final SupabaseClient client = Supabase.instance.client;

  final RxBool isLoading = false.obs;

  Rx<Profile?> profile_main = Rx<Profile?>(null);

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    if (kDemoMode) {
      profile_main.value = MockData.demoProfile;
      return;
    }

    final user = client.auth.currentUser;
    if (user == null) return;

    // Try to get cached profile first
    final cachedProfile = await getCachedUserProfile();
    if (cachedProfile != null && cachedProfile.id.isNotEmpty) {
      profile_main.value = cachedProfile;
      print('Loaded profile from cache:');
      print(profile_main.value);
      return;
    }

    // If not cached, fetch from Supabase
    try {
      final response = await client
          .from('profiles')
          .select('*')
          .eq('id', user.id)
          .maybeSingle();

      if (response != null) {
        final profile = Profile(
          id: response['id'] ?? '',
          email: response['email'] ?? '',
          name: response['name'] ?? '',
          phone: response['phone'] ?? '',
          gender: response['gender'] ?? '',
          age: response['age'] is int
              ? response['age'] ?? 0
              : int.tryParse(response['age']?.toString() ?? '') ?? 0,
          points: response['points'] is int
              ? response['points'] ?? 0
              : int.tryParse(response['points']?.toString() ?? '') ?? 0,
          profile_image: response['profile_image'] ?? '',
          createdAt: response['created_at'] ?? '',
        );
        profile_main.value = profile;
        print('Loaded profile from Supabase:');
        print(profile_main.value);
        await cacheUserProfile(profile);
      }
    } catch (e) {
      profile_main.value = MockData.demoProfile;
      print('Supabase profile fetch failed, using demo profile: $e');
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await deleteCachedUserProfile();
      if (kDemoMode) {
        Get.offAllNamed('/login');
        return;
      }
      await client.auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Sign out failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileModel = ProfileModel();
      // Check if cached profile exists (id is not empty)
      final cachedId = prefs.getString(profileModel.id) ?? '';
      if (cachedId.isEmpty) return;
      await prefs.remove(profileModel.id);
      await prefs.remove(profileModel.email);
      await prefs.remove(profileModel.name);
      await prefs.remove(profileModel.phone);
      await prefs.remove(profileModel.gender);
      await prefs.remove(profileModel.age);
      await prefs.remove(profileModel.points);
      await prefs.remove(profileModel.profile_image);
      await prefs.remove(profileModel.createdAt);
    } catch (e) {
      print('Error deleting cached user profile: $e');
    }
  }

  Future<void> cacheUserProfile(Profile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileModel = ProfileModel();

      await prefs.setString(profileModel.id, profile.id);
      await prefs.setString(profileModel.email, profile.email);
      await prefs.setString(profileModel.name, profile.name);
      await prefs.setString(profileModel.phone, profile.phone);
      await prefs.setString(profileModel.gender, profile.gender);
      await prefs.setString(profileModel.age, profile.age.toString());
      await prefs.setInt(profileModel.points, profile.points);
      await prefs.setString(profileModel.profile_image, profile.profile_image);
      await prefs.setString(profileModel.createdAt, profile.createdAt);
    } catch (e) {
      print('Error caching user profile: $e');
    }
  }

  Future<Profile?> getCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileModel = ProfileModel();
      return Profile(
        id: prefs.getString(profileModel.id) ?? '',
        email: prefs.getString(profileModel.email) ?? '',
        name: prefs.getString(profileModel.name) ?? '',
        phone: prefs.getString(profileModel.phone) ?? '',
        gender: prefs.getString(profileModel.gender) ?? '',
        age: int.parse(prefs.getString(profileModel.age) ?? '0'),
        points: prefs.getInt(profileModel.points) ?? 0,
        profile_image: prefs.getString(profileModel.profile_image) ?? '',
        createdAt: prefs.getString(profileModel.createdAt) ?? '',
      );
    } catch (e) {
      print('Error getting cached user profile: $e');
    }
    return null;
  }
}
