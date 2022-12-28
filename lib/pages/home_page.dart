import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poproject/components/poproject_color.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/pages/add_medicine_page/add_medicine_page.dart';
import 'package:poproject/pages/history/history_page.dart';
import 'package:poproject/pages/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final _pages = [
    TodayPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: SafeArea(child: _pages[_currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddMedicien,
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BuildBottonAppBar(),
    );
  }

  // ignore: non_constant_identifier_names
  BottomAppBar _BuildBottonAppBar() {
    return BottomAppBar(
      child: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          CupertinoButton(
            onPressed: () {
              _onCurrentPage(0);
            },
            child: Icon(
              CupertinoIcons.check_mark,
              color: _currentIndex == 0 ? PoprojectColors.primaryColor : Colors.grey[300],  
            ), 
          ),
          CupertinoButton(
            child: Icon(
              CupertinoIcons.text_badge_checkmark,
              color: _currentIndex == 1 ? PoprojectColors.primaryColor : Colors.grey[300], 
            ), 
            onPressed: () {
                _onCurrentPage(1);
            },
          )
        ],
      ),
        ),
    );
  }

  void _onCurrentPage(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }
  void _onAddMedicien() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMedicinePage()),
    );
  }
}