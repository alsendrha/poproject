import 'dart:io';

import 'package:flutter/material.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({super.key, required this.medicineImage, required this.medicienName});

  final File? medicineImage;
  final String medicienName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            medicineImage == null ? Container() : Image.file(medicineImage!),
            Text(medicienName)
          ],
        ),
      ),
    );
  }
}