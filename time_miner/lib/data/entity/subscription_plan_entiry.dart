import 'package:flutter/material.dart';

class SubscriptionPlan {
  final String title;
  final String price;
  final String desc;
  final bool recommended;

  SubscriptionPlan({
    required this.title,
    required this.price,
    required this.desc,
    required this.recommended,
  });
}