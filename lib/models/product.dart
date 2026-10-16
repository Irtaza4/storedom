import 'package:flutter/material.dart';

class Product {
  final String name, category, subtitle, description;
  final int price, art;
  final Color stage;
  const Product(
    this.name,
    this.category,
    this.subtitle,
    this.price,
    this.art,
    this.stage,
    this.description,
  );
}

const products = [
  Product(
    'Cloud headphones',
    'Tech',
    'A little less world. A little more you.',
    129,
    0,
    Color(0xFFE9E1F4),
    'Your own quiet corner, wherever you go. Cushioned ear cups, immersive sound and a beautifully soft finish. Up to 40 hours of listening, with a travel case included.',
  ),
  Product(
    'Shroom lamp',
    'Living',
    'Good light. Great company.',
    89,
    1,
    Color(0xFFF0E8CA),
    'A small sculpture with a warm personality. Tap to cycle through three cozy brightness levels. Rechargeable, cordless, and happy on any bedside table.',
  ),
  Product(
    'Pebble speaker',
    'Tech',
    'Small object. Big mood.',
    79,
    2,
    Color(0xFFDCE7DE),
    'Room-filling sound in a pocket-sized pebble. A tactile fabric finish, simple controls and 12 hours of battery life make it an everyday companion.',
  ),
  Product(
    'Loop lounge',
    'Living',
    'Your new favorite place to do nothing.',
    349,
    3,
    Color(0xFFF2DFD4),
    'Meet your slow-Sunday seat. A sculptural curved frame wraps around generous upholstery, with a supportive low profile and a wonderfully soft touch.',
  ),
  Product(
    'Cloud mini',
    'Tech',
    'Same daydream. Smaller package.',
    99,
    0,
    Color(0xFFDDE7ED),
    'All the comfort of Cloud in a compact silhouette. Lightweight, wireless and made for your daily soundtrack. Includes a USB-C cable and soft pouch.',
  ),
  Product(
    'Shroom sunset',
    'Living',
    'A golden hour that stays.',
    95,
    1,
    Color(0xFFE9DDEA),
    'Our favorite little lamp in a sunset-inspired finish. Soft diffused light, three brightness settings, and a rechargeable battery for wherever the evening takes you.',
  ),
];
