import 'package:card_carousel/card_carousel.dart';
import 'package:flutter/material.dart';

final List<CardModel> cardList = [
  CardModel(
    title: 'Карта 1',
    balance: '1 342 543 с',
    number: '6332',
    cardType: Image.asset('assets/images/4.0x/visa.png'),
    logo: Image.asset('assets/images/4.0x/logo.png'),
    gradientTopColor: Color(0xFF219978),
    gradietnBottomColor: Color(0xFF0F795C),
  ),
  CardModel(
    title: 'Карта долларовая\nпокупки',
    balance: '',
    number: '4892',
    cardType: Image.asset('assets/images/4.0x/visa.png'),
    logo: Image.asset('assets/images/4.0x/demir.png'),
    gradientTopColor: Color(0xFF991B27),
    gradietnBottomColor: Color(0xFF7A1520),
  ),
  CardModel(
    title: 'Карта Optima Мама',
    balance: '',
    number: '4892',
    cardType: Image.asset('assets/images/4.0x/visa.png'),
    logo: Image.asset('assets/images/4.0x/logo_optima_1.png'),
    gradientTopColor: Color(0xFF365BE0),
    gradietnBottomColor: Color(0xFF0832CC),
  )
];
