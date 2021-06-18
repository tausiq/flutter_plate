import 'package:flutter/material.dart';
import 'package:flutter_plate/config/env.dart';

void main() => Staging();

class Staging extends Env {
  final String appName = "Flutter Plate Staging";

  final String baseUrl = 'https://api.staging.website.org';
  final Color primarySwatch = Colors.indigo;
  final EnvType environmentType = EnvType.STAGING;

  final String dbName = 'stg-app.db';
}
