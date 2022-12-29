import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/poproject_color.dart';
import '../../components/poproject_constants.dart';
import '../add_medicine_page/components/min_widgets.dart';

class TimeSettingBottomSheet extends StatelessWidget {
    const TimeSettingBottomSheet({
    Key? key, required this.initialTime, this.submitTitle = '선택', this.bottomWedget, 
    // required this.service,
  }) : super(key: key);

  final String initialTime;
  final Widget? bottomWedget;
  final String submitTitle;
  // final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    final initialTimeData = DateFormat('HH:mm').parse(initialTime);
    final now = DateTime.now();
    final initialDateTime = DateTime(now.year, now.month, now.day, initialTimeData.hour, initialTimeData.minute);
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
        const SizedBox(height: smallSpace,),
        if(bottomWedget != null) bottomWedget!,
        const SizedBox(height: smallSpace,),
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
              child: Text(submitTitle)),
            ),
          ),
        ],)
      ]
    );
  }
}