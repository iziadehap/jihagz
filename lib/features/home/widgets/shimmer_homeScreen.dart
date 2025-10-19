import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jihagz/features/home/controllers/home_controller.dart';
import 'package:jihagz/features/home/widgets/build_rate.dart';
import 'package:jihagz/features/home/widgets/shimmer_homeScreen.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  final AppCore appCore = AppCore();
  final HomeController homeController = Get.put(HomeController());

  final List<Map<String, dynamic>> dummyStadiums = [
    {
      'name': 'Soccer Field - Smouha',
      'type': 'Football',
      'distance': 1.2,
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Padel Pro - Asafra',
      'type': 'Padel',
      'distance': 2.8,
      'rating': 4.0,
      'image':
          'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Tennis Club - Sidi Bishr',
      'type': 'Tennis',
      'distance': 3.5,
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCore.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF232526), Color(0xFF414345)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchAndMapFilter(context),
                const SizedBox(height: 18),
                _buildCategoryChips(),
                const SizedBox(height: 24),
                _sectionHeader(130, 30),
                const SizedBox(height: 10),
                _buildNearbyStadiums(),
                const SizedBox(height: 18),
                Divider(color: Colors.white24, thickness: 1, height: 32),
                _sectionHeader(180, 30),
                const SizedBox(height: 10),
                _buildStadiumList(),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed('/add-stadium');
      //   },
      //   backgroundColor: appCore.secondaryColor,
      //   child: const Icon(Icons.add, color: Colors.white),
      //   tooltip: 'Add Stadium',
      // ),
    );
  }

  Widget _buildSearchAndMapFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: appCore.surfaceColor,
              highlightColor: appCore.primaryColor,
              child: Container(
                decoration: BoxDecoration(
                  color: appCore.surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: appCore.primaryColor.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search for a stadium or area...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Shimmer.fromColors(
            baseColor: appCore.surfaceColor,
            highlightColor: appCore.primaryColor,
            child: Material(
              color: appCore.primaryColor,
              borderRadius: BorderRadius.circular(14),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  // TODO: Open map filter
                  homeController.fromServer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.map, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: appCore.surfaceColor,
        highlightColor: appCore.primaryColor,
        child: SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: AppCore.sportTypes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final type = AppCore.sportTypes[index];
              final label = _getSportTypeLabel(type);
              final icon = _getSportTypeIcon(type);
              return Chip(
                label: Row(
                  children: [
                    Icon(icon, color: appCore.primaryColor, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        color: appCore.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                backgroundColor: appCore.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyStadiums() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        enableInfiniteScroll: true,
      ),
      items: dummyStadiums.map((stadium) {
        return Shimmer.fromColors(
          baseColor: appCore.surfaceColor,
          highlightColor: appCore.primaryColor,
          child: _photoCard(stadium, width: 360, height: 160),
        );
      }).toList(),
    );
  }

  Widget _buildStadiumList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: appCore.surfaceColor,
        highlightColor: appCore.primaryColor,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dummyStadiums.length,
          itemBuilder: (context, index) {
            final stadium = dummyStadiums[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
              child: _photoCard(stadium, width: double.infinity, height: 220),
            );
          },
        ),
      ),
    );
  }

  Widget _photoCard(
    Map<String, dynamic> stadium, {
    double width = double.infinity,
    double height = 220,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(26),
      elevation: 10,
      shadowColor: appCore.primaryColor.withOpacity(0.18),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: () {
          Get.toNamed('/stadium-details', arguments: stadium);
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white10, width: 1.2),
            color: appCore.surfaceColor.withOpacity(0.98),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  stadium['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                // Gradient overlay at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 70,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),
                // Name, distance, and rating
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              stadium['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                shadows: [
                                  Shadow(blurRadius: 8, color: Colors.black54),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (stadium['distance'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  '${(stadium['distance'] as num).toStringAsFixed(1)} km',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      buildRatingStars(stadium['rating'] ?? 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(double width, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Shimmer.fromColors(
        baseColor: appCore.surfaceColor,
        highlightColor: appCore.primaryColor,

        child: Container(
          height: 30,
          width: 150,
          decoration: BoxDecoration(
            color: appCore.surfaceColor,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  String _getSportTypeLabel(String type) {
    switch (type) {
      case 'football':
        return 'Football';
      case 'padel':
        return 'Padel';
      case 'tennis':
        return 'Tennis';
      default:
        return 'Other';
    }
  }

  IconData _getSportTypeIcon(String type) {
    switch (type) {
      case 'football':
        return Icons.sports_soccer;
      case 'padel':
        return Icons.sports_tennis;
      case 'tennis':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }
}

class _AnimatedScaleOnTap extends StatefulWidget {
  final Widget child;
  const _AnimatedScaleOnTap({required this.child});

  @override
  State<_AnimatedScaleOnTap> createState() => _AnimatedScaleOnTapState();
}

class _AnimatedScaleOnTapState extends State<_AnimatedScaleOnTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnim.value, child: child);
        },
        child: widget.child,
      ),
    );
  }
}
