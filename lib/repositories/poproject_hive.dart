import 'package:hive_flutter/hive_flutter.dart';

import 'package:poproject/models/medicine.dart';

class PoprojectHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());

    await Hive.openBox<Medicine>(PoprojectHiveBox.medicine);
  }
}

class PoprojectHiveBox {
  static const String medicine = 'medicine';
}