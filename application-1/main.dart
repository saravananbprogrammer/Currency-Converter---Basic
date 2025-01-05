import 'package:currency_converter/pages/currency_convertor_material_page.dart';
import 'package:flutter/material.dart';

/*
 * Currency Converter
 * 
 * Developed by Saravanan B., Currency Converter is a simple and efficient app 
 * designed exclusively for converting United States Dollars (USD) to Indian Rupees (INR).
 * 
 * Features:
 * - Quick Conversion: Instantly convert USD to INR with accurate rates.
 * - User-Friendly Design: Minimalistic and easy-to-use interface for hassle-free operation.
 * - Lightweight: Optimized for speed and performance, perfect for everyday use.
 * 
 * Ideal for travelers, students, and professionals needing a straightforward currency conversion tool.
 * 
 * Copyright Information:
 * © 2025 SB Officials. All rights reserved.
 * This application is the sole property of Saravanan B. Unauthorized copying, modification, 
 * or redistribution of this app is strictly prohibited under applicable laws.
 * 
 * For support or feedback, please contact saravanantechgenius@gmail.com.
 */

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurrencyConvertorMaterialPage(),
    );
  }
}
