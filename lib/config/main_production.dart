import 'package:flutter_plate/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Production();

class Production extends Env {
  final String appName = "Flutter Plate";

  final String baseUrl = 'https://api.website.org';
  final Color primarySwatch = Colors.teal;
  EnvType environmentType = EnvType.PRODUCTION;

  final String dbName = 'prod-app.db';

}