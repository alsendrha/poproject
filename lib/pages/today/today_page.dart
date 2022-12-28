import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/main.dart';
import 'package:poproject/models/medicine_alarm.dart';
import 'package:poproject/repositories/medicine_repository.dart';

import '../../models/medicine.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('오늘 복용할 약은?',
        style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: regulaSpace,),
        const Divider(height: 1, thickness: 2.0),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: medicineRepository.medicineBox.listenable(),
            builder: _buildMedicineListView
          ),
        ),
        const Divider(height: 1, thickness: 2.0),
      ],
    );
  }

  Widget _buildMedicineListView(context,Box<Medicine>box,_) {
    final medicines = box.values.toList();
    final medicineAlarms = <MedicineAlarm>[];

    for (var medicine in medicines) {
      for (var alarm in medicine.alarms) {
        medicineAlarms.add(MedicineAlarm(
          medicine.id,
          medicine.name,
          medicine.imagePath,
          alarm,
          medicine.key
        ));
      }
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: smallSpace),
      itemCount: medicineAlarms.length,
      itemBuilder: (context, index) {
        return MedicineListTile(medicineAlarm: medicineAlarms[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(height: regulaSpace,);
      },
    );
  }
}

class MedicineListTile extends StatelessWidget {
  const MedicineListTile({
    Key? key, required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    return Row(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child:CircleAvatar(
            radius: 40,
            foregroundImage: medicineAlarm.imagePath == null ? null : FileImage(File(medicineAlarm.imagePath!)),
          ),
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🕝 ${medicineAlarm.alarmTime}', style: textStyle,),
              const SizedBox(height: 6,),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('${medicineAlarm.name},', style: textStyle,),
                  TileActionButton(
                    onTap: () {
                    
                    },
                    title: '지금',  
                  ),
                  Text('|', style: textStyle),
                  TileActionButton(
                    onTap: () {
                    
                    },
                    title: '아까',  
                  ),
                  Text('먹었어요', style: textStyle),
                ],
              )
            ],
          ),
        ),
        CupertinoButton(
          onPressed: () {
            medicineRepository.deleteMedicine(medicineAlarm.key);
          },
          child: const Icon(CupertinoIcons.ellipsis_vertical),
        ),
      ],
    );
  }
}

class TileActionButton extends StatelessWidget {
  const TileActionButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title, 
          style: buttonTextStyle,
        ),
      ),
    );
  }
}