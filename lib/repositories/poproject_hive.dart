import 'package:hive_flutter/hive_flutter.dart';

import 'package:poproject/models/medicine.dart';
import 'package:poproject/models/medicine_history.dart';

class PoprojectHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());
    Hive.registerAdapter<MedicineHistory>(MedicineHistoryAdapter());

    await Hive.openBox<Medicine>(PoprojectHiveBox.medicine);
    await Hive.openBox<MedicineHistory>(PoprojectHiveBox.medicineHistory);
  }
}

class PoprojectHiveBox {
  static const String medicine = 'medicine';
  static const String medicineHistory = 'medicine_history';
}