import 'dart:math';
import 'package:flutter/material.dart';
import 'package:macro_counter/providers/id_provider.dart';

class IdProviderDt with ChangeNotifier implements IdProvider {
  IdProviderDt();
  @override
  int generate() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomBits = Random().nextInt(1 << 31);
    return (timestamp << 31) | randomBits;
    // Generates unique IDs by combining current timestamp (milliseconds since epoch) with random bits for improved uniqueness.
  }
}
