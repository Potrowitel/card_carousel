import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final String balance;
  final String number;
  final Image logo;
  final Image cardType;
  final Color gradientTopColor;
  final Color gradietnBottomColor;
  const CardModel(
      {required this.title,
      required this.balance,
      required this.number,
      required this.logo,
      required this.cardType,
      required this.gradientTopColor,
      required this.gradietnBottomColor,
      Key? key});
}
