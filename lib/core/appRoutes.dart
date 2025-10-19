import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/features/add_missing_place/screens/add_missing_place.dart';
import 'package:jihagz/features/details/screens/details_screen.dart';
import 'package:jihagz/features/form/form_ui/form_screen.dart';
import 'package:jihagz/features/home/widgets/inclode_homeScreeen.dart';
import 'package:jihagz/features/login/login_front/login_front_screen.dart';
import 'package:jihagz/features/settings/screens/setting_screen.dart';

class AppRoutes {
  static const String LOGIN = '/login';
  static const String HOME = '/home';
  static const String FORM = '/form';
  static const String ADD_MISSING_PLACE = '/add_missing_place';
  static const String SETTINGS = '/settings';
  static const String DETAILS = '/details';
}

List<GetPage> getPages = [
  GetPage(
    name: AppRoutes.LOGIN,
    page: () => LoginFrontScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
  GetPage(
    name: AppRoutes.HOME,
    page: () => HomeScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
  GetPage(
    name: AppRoutes.FORM,
    page: () => FormScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
  GetPage(
    name: AppRoutes.ADD_MISSING_PLACE,
    page: () => AddMissingPlaceScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
  GetPage(
    name: AppRoutes.SETTINGS,
    page: () => SettingScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
  GetPage(
    name: AppRoutes.DETAILS,
    page: () => DetailsScreen(club: Get.arguments),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
  ),
];
