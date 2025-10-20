import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/core/appRoutes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final RxBool isLoading = false.obs;

  /// Sign in with Google and authenticate with Supabase
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      late final GoogleSignIn googleSignIn;
      
      // التعرف على نوع النظام واستخدام الإعدادات المناسبة
      if (Theme.of(Get.context!).platform == TargetPlatform.android) {
        // إعدادات Android
        googleSignIn = GoogleSignIn(
          serverClientId: AppCore.googleWebClientId,
        );
      } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        // إعدادات iOS
        googleSignIn = GoogleSignIn(
          clientId: AppCore.googleIOSClientId,
        );
      } else {
        // إعدادات افتراضية لأنظمة أخرى
        googleSignIn = GoogleSignIn();
      }
      
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _showNotification(
          'تم إلغاء تسجيل الدخول من قبل المستخدم',
          isError: true,
        );
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw 'لم يتم العثور على بيانات المصادقة';
      }

      final result = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (result.user != null) {
        // After successful sign in, check if the user is new or existing
        await _checkIfNewUser();
        // _showNotification('تم تسجيل الدخول بنجاح!');
      } else {
        _showNotification(
          'حدث خطأ أثناء تسجيل الدخول إلى Supabase',
          isError: true,
        );
      }
    } catch (error) {
      print('🔴 خطأ في Google Sign-In: $error');
      _showNotification('حدث خطأ أثناء تسجيل الدخول', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  /// Checks if the user has a profile in the database.
  /// If not, navigates to the profile setup form.
  /// If yes, navigates to the home screen.
  Future<void> _checkIfNewUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      print('❌ لا يوجد مستخدم مسجل دخول');
      return;
    }

    try {
      final profile = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null) {
        // New user: go to profile setup form
        print('🆕 مستخدم جديد → الذهاب إلى صفحة إعداد الحساب');
        _goToSetupProfile();
      } else {
        // Existing user: go to home
        print('👤 مستخدم موجود → الذهاب إلى الصفحة الرئيسية');
        _goToHome();
      }
    } catch (e) {
      print('⚠️ حصل خطأ أثناء التحقق من المستخدم: $e');
      // If there's an error, treat as new user for safety
      _goToSetupProfile();
    }
  }

  void _goToSetupProfile() {
    Get.toNamed(AppRoutes.FORM);
  }

  void _goToHome() {
    Get.offAllNamed(AppRoutes.HOME);
  }

  void _showNotification(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'خطأ' : 'نجاح',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
