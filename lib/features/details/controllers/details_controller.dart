import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/my_snackbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase_model/sports_clubs_verified.dart';

class DetailsController extends GetxController {
  SportsClubsVerified? club;

  // Observables
  var name = ''.obs;
  var type = ''.obs;
  var mainImage = ''.obs;
  var images = <String>[].obs;
  var location = Rxn<LatLng>();
  var distanceFromUser = ''.obs;

  var rating = 0.0.obs;
  var isEditRating = false.obs;
  var numberRated = 0.obs;
  var ratingDistribution = <int, int>{}.obs;
  var phone = ''.obs;
  var whatsapp = ''.obs;
  var price = ''.obs;
  var workingHours = ''.obs;
  var facilities = <String>[].obs;
  var visitorImages = <String>[].obs;
  var userRateFromServer = Rxn<double>();
  var userRating = Rxn<double>();
  var ratingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    club = arg;
    fillFieldsFromClub();
    if (club != null) fetchRatingDistribution(club!.id);
    if (club != null) loadUserRating(club!.id);
  }

  void fillFieldsFromClub() {
    if (club == null) return;
    name.value = club!.name;
    type.value = club!.type;
    images.value = club!.images;
    mainImage.value = club!.images.isNotEmpty ? club!.images.first : '';
    location.value = LatLng(
      double.tryParse(club!.latitude) ?? 0,
      double.tryParse(club!.longitude) ?? 0,
    );
    distanceFromUser.value = club!.distance.toStringAsFixed(1) + ' كم';
    rating.value = double.tryParse(club!.rate) ?? 0;
    numberRated.value = int.tryParse(club!.number_rated) ?? 0;
    phone.value = club!.phone_number;
    price.value = club!.price;
    // Add more fields as needed
  }

  Future<void> fetchRatingDistribution(String stadiumId) async {
    final supabase = Supabase.instance.client;
    Map<int, int> ratingCounts = {};
    for (int i = 1; i <= 5; i++) {
      final response = await supabase
          .from('stadium_ratings')
          .select('id')
          .eq('stadium_id', stadiumId)
          .eq('rating', i);
      ratingCounts[i] = (response as List).length;
    }
    ratingDistribution.value = ratingCounts;
  }

  Future<void> loadUserRating(String stadiumId) async {
    ratingLoading.value = true;
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    final response = await supabase
        .from('stadium_ratings')
        .select('rating')
        .eq('stadium_id', stadiumId)
        .eq('user_id', userId!)
        .maybeSingle();
    if (response == null) {
      userRating.value = null;
      userRateFromServer.value = null;
    } else {
      final ratingValue = response['rating'];
      userRating.value = ratingValue == null
          ? null
          : (ratingValue is int
                ? ratingValue.toDouble()
                : ratingValue as double?);
      userRateFromServer.value = ratingValue == null
          ? null
          : (ratingValue is int
                ? ratingValue.toDouble()
                : ratingValue as double?);
    }
    ratingLoading.value = false;
  }

  Future<void> rateStadium(double? value) async {
    print('rateStadium called');
    // if (club == null) return;
    if (userRating.value == null) return;
    if (value == null &&
        (isEditRating == true && userRating != userRateFromServer)) {
      print('send rate to server');
      final supabase = Supabase.instance.client;
      // await supabase.rpc(
      //   'get_rating_distribution',
      //   params: {'stadium_id_input': club!.id, 'rating': userRating.value},
      // );
      print('update in server called');
      final response = await Supabase.instance.client
          .from('stadium_ratings')
          .upsert(
            {
              'stadium_id': club!.id,
              'user_id': supabase.auth.currentUser?.id,
              'rating': userRating.value?.toInt(),
            },
            onConflict: 'stadium_id,user_id',
          )
          .select();

      print("✅ Rating submitted: $response");

      mySnackbar(
        'Thank you!',
        'Your rating has been submitted.',
        ContentType.success,
      );
    } else {
      userRating.value = value; // Update UI immediately
      print(value);
    }
  }

  @override
  void onClose() async {
    // TODO: implement onClose

    await rateStadium(null);

    print('onClose');
    ratingDistribution.value = {};
    ratingLoading.value = false;
    super.onClose();
  }
}
