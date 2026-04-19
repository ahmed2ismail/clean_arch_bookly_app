import 'package:flutter/material.dart';

SnackBar buildErrorSnackBar(String errMessage) {
  return SnackBar(
    backgroundColor: Colors.white,
    content: Text(
      errMessage,
      style: const TextStyle(
        color: Colors.redAccent,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    duration: const Duration(seconds: 3),
  );
}
