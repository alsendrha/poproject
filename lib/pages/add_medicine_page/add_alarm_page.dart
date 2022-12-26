import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poproject/components/poproject_color.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/pages/add_medicine_page/components/minwidgets.dart';

import 'components/add_page_widget.dart';

class AddAlarmPage extends StatefulWidget {
   const AddAlarmPage({super.key, required this.medicineImage, required this.medicienName});

  final File? medicineImage;
  final String medicienName;

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _alarms = <String>{
    '08:00',
    '13:00',
    '19:00',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Center(
            child: Text(
              '매일 복약 잊지말아요!', 
              style: Theme.of(context).textTheme.headline4,
            )
          ),
          const SizedBox(height: largeSpace,),
          Expanded(child: ListView(
            children: alarmWidgets,
          //  children: const [
          //   AlarmBox(),
          //   AlarmBox(),
          //   AlarmBox(),
          //   AlarmBox(),
          //   AddAlarmButton(),
          //  ], 
          ))
          
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtomHeight,
            child: ElevatedButton(
              onPressed:() {
                
              },
              // },
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ), 
              child: const Text('완료'),
            ),
          ),
        ),
      )
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];
    children.addAll(
      _alarms.map((alarmTime) => AlarmBox(
          time: alarmTime,
          onPressedMinus: () {
            setState(() {
              _alarms.remove(alarmTime);
            });
          },
        ),
      ),
    );
    children.add(AddAlarmButton(
      onPressedAdd: () {
        final now = DateTime.now();
        final nowTime = DateFormat('HH:mm').format(now);
        setState(() {
          // _alarms.add('${now.hour}:${now.minute}');
          _alarms.add(nowTime);
        });
    },));
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key, required this.time, required this.onPressedMinus,
  }) : super(key: key);

  final String time;
  final VoidCallback onPressedMinus;

  @override
  Widget build(BuildContext context) {
    final initTime = DateFormat('HH:mm').parse(time);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onPressedMinus,
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.subtitle2,

            ),
            onPressed: () {
              showModalBottomSheet(
                context: context, 
                builder: (context){
                  return TimePickerBottomSheet(
                    initialDateTime: initTime,
                  );
                },
              );
            }, 
            child: Text(time),
          ),
        )
      ],
    );
  }
}

class TimePickerBottomSheet extends StatelessWidget {
  const TimePickerBottomSheet({
    Key? key, required this.initialDateTime,
  }) : super(key: key);

  final DateTime initialDateTime;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children:[
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (DateTime){},
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

class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    Key? key, required this.onPressedAdd,
  }) : super(key: key);

  final VoidCallback onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 0, 
          vertical: 6
        ),
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
        
      onPressed: onPressedAdd,
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Icon(CupertinoIcons.plus_circle_fill)
          ),
          Expanded(
            flex: 5,
            child: Center(child: Text('복용시간 추가')),
          )
        ],
      ),
    );
  }
}