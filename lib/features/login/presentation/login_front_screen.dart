import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/features/login/data/data_source/login_controller.dart';
import 'package:jihagz/core/appCore.dart';

class LoginFrontScreen extends StatelessWidget {
  LoginFrontScreen({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());
  final AppCore appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCore.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: appCore.surfaceColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset(
                          'assets/images/icon.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Welcome to Jihagz',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appCore.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Sign in to continue',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: Image.network(
                    'https://www.google.com/favicon.ico',

                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'G',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  label: Obx(
                    () => controller.isLoading.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text('Sign in with Google'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appCore.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: appCore.primaryColor.withOpacity(0.3),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.signInWithGoogle();
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
