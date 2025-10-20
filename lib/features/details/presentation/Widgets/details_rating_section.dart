import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/features/details/data/data_source/details_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class DetailsRatingSection extends StatelessWidget {
  final DetailsController controller;
  const DetailsRatingSection({Key? key, required this.controller})
    : super(key: key);

  Color _barColor(int star, AppCore appCore) {
    // Use appCore colors for gradient
    final colors = [
      appCore.successColor,
      appCore.secondaryColor,
      appCore.warningColor,
      appCore.primaryColor.withOpacity(0.7),
      appCore.primaryColor,
    ];
    return colors[5 - star];
  }

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      final ratingDist = controller.ratingDistribution;
      final maxCount = ratingDist.values.isNotEmpty
          ? ratingDist.values.reduce((a, b) => a > b ? a : b)
          : 1;
      final total = ratingDist.values.fold(0, (a, b) => a + b);
      return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        appCore.surfaceColor,
                        appCore.surfaceColor.withOpacity(0.95),
                      ]
                    : [Colors.white, Colors.grey[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
              ],
              border: Border.all(color: appCore.primaryColor.withOpacity(0.08)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: appCore.warningColor,
                        size: 36,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Overall Rating',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: appCore.textColor,
                        ),
                      ),
                      Spacer(),
                      if (controller.ratingLoading.value)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: appCore.primaryColor,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        controller.rating.value.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: appCore.warningColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '/ 5',
                        style: TextStyle(
                          fontSize: 18,
                          color: appCore.textColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '(${controller.numberRated.value} ratings)',
                        style: TextStyle(
                          color: appCore.textColor.withOpacity(0.6),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 28,
                    thickness: 1.2,
                    color: appCore.primaryColor.withOpacity(0.08),
                  ),
                  Center(
                    child: Obx(() {
                      return Column(
                        children: [
                          Text(
                            controller.userRating.value == null
                                ? 'Tap to rate:'
                                : 'Your Rating:',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: appCore.textColor,
                            ),
                          ),
                          SizedBox(height: 6),

                          RatingStars(
                            value: (controller.userRating.value ?? 0),
                            onValueChanged: (v) {
                              controller.isEditRating.value = true;
                              controller.userRating.value = v;
                              controller.rateStadium(v);
                            },

                            starBuilder: (index, color) => Icon(
                              Icons.star_rounded,
                              color: color,
                              size: 36,
                            ),
                            starCount: 5,
                            starSize: 36,
                            valueLabelVisibility: false,
                            maxValue: 5,
                            starSpacing: 4,
                            maxValueVisibility: false,
                            animationDuration: Duration(milliseconds: 600),
                            starColor: appCore.warningColor,
                            starOffColor: appCore.textColor.withOpacity(0.15),
                          ),
                          if (controller.userRating.value != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: appCore.successColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Thank you for rating!',
                                    style: TextStyle(
                                      color: appCore.successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  Divider(
                    height: 28,
                    thickness: 1.2,
                    color: appCore.primaryColor.withOpacity(0.08),
                  ),
                  Text(
                    'Rating Distribution',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: appCore.textColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...List.generate(5, (i) {
                    int star = 5 - i;
                    int count = ratingDist[star] ?? 0;
                    double percent = total > 0 ? count / total : 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Text(
                              '$star',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: appCore.textColor,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: appCore.warningColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: appCore.textColor.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                                AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      height: 18,
                                      width:
                                          percent *
                                          MediaQuery.of(context).size.width *
                                          0.45,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            _barColor(star, appCore),
                                            appCore.warningColor.withOpacity(
                                              0.7,
                                            ),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(
                                      duration: 400.ms,
                                      delay: (i * 80).ms,
                                    )
                                    .slideX(
                                      begin: -0.2,
                                      end: 0,
                                      duration: 400.ms,
                                      delay: (i * 80).ms,
                                    ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '$count',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: appCore.textColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${(percent * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: appCore.textColor.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
          .animate()
          .fadeIn(duration: 400.ms, delay: 300.ms)
          .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 300.ms);
    });
  }
}

// Helper function to get user rating for a stadium
Future<int?> getUserRatingForStadium(String stadiumId) async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return null;
  final response = await supabase
      .from('stadium_ratings')
      .select('rating')
      .eq('stadium_id', stadiumId)
      .eq('user_id', userId)
      .maybeSingle();
  if (response == null) {
    return null;
  }
  return response['rating'] as int?;
}
