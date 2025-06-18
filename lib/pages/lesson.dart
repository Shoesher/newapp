// lib/models/lesson.dart
import 'package:flutter/material.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final bool isCompleted; // To simulate completion status (can be updated later)
  final bool isLocked; // To simulate locked lessons (can be updated later)

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    this.isCompleted = false,
    this.isLocked = false,
  });
}