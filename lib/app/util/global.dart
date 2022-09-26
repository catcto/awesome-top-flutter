import 'package:flutter/material.dart';
import '../util/log.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
