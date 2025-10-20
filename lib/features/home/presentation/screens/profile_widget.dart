import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/features/home/data/data_source/inclode_homeScreen.dart';
import 'package:jihagz/core/appCore.dart';

class ProfileWidget extends StatelessWidget {
  final InclodeHomeController controller = Get.find<InclodeHomeController>();
  final AppCore appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final profile = controller.profile_main.value;
      if (profile == null) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appCore.primaryColor),
          ),
        );
      }
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Card(
                    color: appCore.surfaceColor.withOpacity(0.98),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 36.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (profile.profile_image.isNotEmpty)
                            CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage(
                                profile.profile_image,
                              ),
                              backgroundColor: appCore.primaryColor.withOpacity(
                                0.15,
                              ),
                            )
                          else
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: appCore.primaryColor.withOpacity(
                                0.15,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 54,
                                color: appCore.primaryColor,
                              ),
                            ),
                          const SizedBox(height: 18),
                          Text(
                            profile.name,
                            style: TextStyle(
                              color: appCore.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: appCore.backgroundColor.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: appCore.secondaryColor,
                                  size: 20,
                                ),
                                Text(
                                  profile.email,
                                  style: TextStyle(
                                    color: appCore.secondaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _profileDetailRow(
                            Icons.phone,
                            'Phone',
                            profile.phone,
                            appCore,
                          ),
                          _profileDetailRow(
                            Icons.transgender,
                            'Gender',
                            profile.gender,
                            appCore,
                          ),
                          _profileDetailRow(
                            Icons.cake,
                            'Age',
                            profile.age.toString(),
                            appCore,
                          ),
                          _profileDetailRow(
                            Icons.star,
                            'Points',
                            profile.points.toString(),
                            appCore,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, right: 32),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: appCore.primaryColor,
                        size: 28,
                      ),
                      tooltip: 'Settings',
                      onPressed: () {
                        goToSettings();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          appCore.primaryColor,
                        ),
                      )
                    : SizedBox(
                        width: 180,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: controller.signOut,
                          icon: Icon(Icons.logout, color: Colors.white),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appCore.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            shadowColor: appCore.primaryColor.withOpacity(0.18),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _profileDetailRow(
    IconData icon,
    String label,
    String value,
    AppCore appCore,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: appCore.secondaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: appCore.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

void goToSettings() {
  Get.toNamed('/settings');
}
