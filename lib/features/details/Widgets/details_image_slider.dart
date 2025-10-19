import 'package:flutter/material.dart';
import '../controllers/details_controller.dart';
import '../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsImageSlider extends StatefulWidget {
  final DetailsController controller;
  const DetailsImageSlider({Key? key, required this.controller})
    : super(key: key);

  @override
  State<DetailsImageSlider> createState() => _DetailsImageSliderState();
}

class _DetailsImageSliderState extends State<DetailsImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final images = widget.controller.images;
    if (images.isEmpty) {
      return Container(
        height: 320,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? appCore.surfaceColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: appCore.primaryColor.withOpacity(0.08)),
        ),
        child: Center(
          child: Icon(
            Icons.image,
            size: 80,
            color: appCore.primaryColor.withOpacity(0.3),
          ),
        ),
      )
      .animate()
      .fadeIn(duration: 400.ms)
      .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 100.ms);
    }
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIdx) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: appCore.primaryColor.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: isDark
                          ? appCore.surfaceColor
                          : Colors.grey[300],
                      child: Center(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ??
                                          1)
                                : null,
                            color: appCore.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 320,
            viewportFraction: 1.0,
            enableInfiniteScroll: images.length > 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            autoPlay: images.length > 1,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
        if (images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() => _current = entry.key),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _current == entry.key ? 18.0 : 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _current == entry.key
                        ? appCore.primaryColor
                        : appCore.primaryColor.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    )
    .animate()
    .fadeIn(duration: 400.ms)
    .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 100.ms);
  }
}
