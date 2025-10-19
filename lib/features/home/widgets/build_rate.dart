
  import 'package:flutter/material.dart';

Widget buildRatingStars(double rating) {
    final fullStars = rating.floor();
    final halfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star, color: Colors.amber, size: 18),
        if (halfStar) Icon(Icons.star_half, color: Colors.amber, size: 18),
        for (int i = 0; i < 5 - fullStars - (halfStar ? 1 : 0); i++)
          Icon(Icons.star_border, color: Colors.amber, size: 18),
      ],
    );
  }
