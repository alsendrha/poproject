import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poproject/components/poproject_themes.dart';
import 'package:poproject/pages/home_page.dart';
import 'package:poproject/repositories/medicine_history_repository.dart';
import 'package:poproject/repositories/medicine_repository.dart';
import 'package:poproject/repositories/poproject_hive.dart';
import 'package:poproject/service/poproject_notification_service.dart';

final notification = PoprojectNotificationService();
final hive = PoprojectHive();
final medicineRepository = MedicineRepository();
final historyRepository = MedicineHistoryRepository();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  await notification.initializeTimeZone();
  await notification.initializeNotification();

  await hive.initializeHive();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: PoprojectThems.lightTheme,
      home:  const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
