import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/poproject_color.dart';
import '../../components/poproject_constants.dart';
import '../add_medicine_page/components/min_widgets.dart';

class TimeSettingBottomSheet extends StatelessWidget {
    const TimeSettingBottomSheet({
    Key? key, required this.initialTime, 
    // required this.service,
  }) : super(key: key);

  final String initialTime;
  // final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateFormat('HH:mm').parse(initialTime);
    DateTime?setDateTime = initialDateTime;
    return BottomSheetBody(
      children:[
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime){
              setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initialDateTime,
          ),
        ),
        const SizedBox(height: largeSpace,),
        Row(children: [
          Expanded(
            child: SizedBox(
              height: submitButtomHeight,
              child: ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
                backgroundColor : Colors.white,
                foregroundColor : PoprojectColors.primaryColor,
              ), 
              child: const Text('취소')),
            ),
          ),
          const SizedBox(width: smallSpace,),
          Expanded(
            child: SizedBox(
              height: submitButtomHeight,
              child: ElevatedButton(onPressed: () {
                // service.setAlarm(
                //   prevTime: initialTime, 
                //   setTime: _setDateTime ?? initialDateTime
                // );
                Navigator.pop(context, setDateTime);
              }, 
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ), 
              child: const Text('선택')),
            ),
          ),
        ],)
      ]
    );
  }
}