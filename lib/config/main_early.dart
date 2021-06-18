import 'package:flutter/material.dart';
import 'package:flutter_plate/config/Env.dart';

void main() => Early();

class Early extends Env {
  final String appName = "Flutter Plate Early";

  final String baseUrl = 'https://api.testing.website.org';
  final Color primarySwatch = Colors.blue;
  EnvType environmentType = EnvType.EARLY;

  final String dbName = 'early-app.db';
}
