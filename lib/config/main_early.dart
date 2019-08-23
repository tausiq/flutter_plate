import 'package:flutter_plate/config/Env.dart';
import 'package:flutter/material.dart';

void main() => DevTest();

class DevTest extends Env {
  final String appName = "Flutter Plate Testing";

  final String baseUrl = 'https://api.testing.website.org';
  final Color primarySwatch = Colors.blue;
  EnvType environmentType = EnvType.EARLY;

  final String dbName = 'tst-app.db';
}
