import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/details_controller.dart';
import '../widgets/details_header.dart';
import '../widgets/details_image_slider.dart';
import '../widgets/details_location_map.dart';
import '../widgets/details_rating_section.dart';
import '../widgets/details_contact_section.dart';
import '../widgets/details_additional_info.dart';
import '../widgets/details_action_buttons.dart';
import '../../../core/supabase_model/sports_clubs_verified.dart';

class DetailsScreen extends StatelessWidget {
  final SportsClubsVerified club;
  const DetailsScreen({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
      init: DetailsController()..club = club,
      builder: (controller) => Scaffold(
        appBar: AppBar(title: Text(controller.name.value)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsHeader(controller: controller),
              DetailsImageSlider(controller: controller),
              DetailsLocationMap(controller: controller),
              DetailsContactSection(controller: controller),
              DetailsRatingSection(controller: controller),
              DetailsAdditionalInfo(controller: controller),
              DetailsActionButtons(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
  
  
}
