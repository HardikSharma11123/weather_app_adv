import 'package:flutter/material.dart';

BoxDecoration weatherBoxDecoration(bool isDaytime) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color:
        isDaytime
            ? Colors.indigoAccent.withOpacity(0.59)
            : Colors.grey.withOpacity(0.59),
  );
}
