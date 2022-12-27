// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poproject/components/poproject_color.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/main.dart';
import 'package:poproject/models/medicine.dart';
import 'package:poproject/pages/add_medicine_page/components/min_widgets.dart';
import 'package:poproject/service/add_medicine_service.dart';
import 'package:poproject/service/popriject_file_service.dart';

import 'components/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage({super.key, required this.medicineImage, required this.medicienName});

  final File? medicineImage;
  final String medicienName;

 
  final service = AddMedicineService();

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
          Expanded(
            child: AnimatedBuilder(
              animation: service,
              builder: (context, _) {
                return ListView(
                children: alarmWidgets,
            //  children: const [
            //   AlarmBox(),
            //   AlarmBox(),
            //   AlarmBox(),
            //   AlarmBox(),
            //   AddAlarmButton(),
            //  ], 
                );
              }, 
            ))
          
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtomHeight,
            child: ElevatedButton(
              onPressed:() async {
                bool result = false;
                // 1. add alarm
                for (var alarm in service.alarms){
                  result = await notification.addNotifcication(
                    medicineId: medicineRepository.newId,
                    alarmTimeStr: alarm, 
                    title: '$alarm 약 먹을 시간이에요!', 
                    body: '$medicienName 복약했다고 알려주세요!', 
                  );

                  if(!result) {
                    return showPermissionDenied(context, permission: '알람');
                  }
                }
                // 2. save image (local dir)
                String? imageFilePath;
                if(medicineImage != null){
                  imageFilePath = await saveImageToLocalDirectory(medicineImage!);
                }
                // 3. add medicine model (local DB, hive)
                final medicine = Medicine(
                  id: medicineRepository.newId, name: medicienName, imagePath: imageFilePath, alarms: service.alarms.toList()
                );
                medicineRepository.addMedicine(medicine);

                Navigator.popUntil(context, (route) => route.isFirst,);
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
      service.alarms.map((alarmTime) => AlarmBox(
          time: alarmTime,
          service: service,
          // onPressedMinus: () {
          //   setState(() {
          //     _alarms.remove(alarmTime);
          //   });
          // },
        ),
      ),
    );
    children.add(AddAlarmButton(
      service: service,
      // onPressedAdd: () {
      //   final now = DateTime.now();
      //   final nowTime = DateFormat('HH:mm').format(now);
      //   setState(() {
      //     _alarms.add('${now.hour}:${now.minute}');
      //     _alarms.add(nowTime);
      //   });
      // },
    ));
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key, required this.time, required this.service,
  }) : super(key: key);

  final String time;
  final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: (() {
              service.removeAlarm(time);
            }),
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
                    initialTime: time,
                    service: service,
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

// ignore: must_be_immutable
class TimePickerBottomSheet extends StatelessWidget {
    TimePickerBottomSheet({
    Key? key, required this.initialTime, required this.service,
  }) : super(key: key);

  final String initialTime;
  final AddMedicineService service;
  DateTime? _setDateTime;

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateFormat('HH:mm').parse(initialTime);
    return BottomSheetBody(
      children:[
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime){
              _setDateTime = dateTime;
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
                service.setAlarm(
                  prevTime: initialTime, 
                  setTime: _setDateTime ?? initialDateTime
                );
                Navigator.pop(context);
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
    Key? key, required this.service,
  }) : super(key: key);

  final AddMedicineService service;

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
        
      onPressed: service.addNowAlarm,
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