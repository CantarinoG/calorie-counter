import 'package:flutter/material.dart';

abstract class IdProvider with ChangeNotifier {
  int generate();
}
