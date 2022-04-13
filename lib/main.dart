import 'package:flutter/material.dart';
import 'package:untitled/domain/syncService.dart';
import 'internal/application.dart';

void main() {
  setupServiceLocator();
  runApp(const Application());
}
