import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poproject/pages/today/image_detail_page.dart';

import '../../components/min_page.route.dart';
import '../../components/poproject_constants.dart';
import '../../main.dart';
import '../../models/medicine_alarm.dart';
import '../../models/medicine_history.dart';
import '../bottomsheet/time_setting_bottomsheet.dart';

class BeforeTakeTile extends StatelessWidget {
  const BeforeTakeTile({
    Key? key, required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    return Row(
      children: [
        _MedicineImageButton(medicineAlarm: medicineAlarm),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context),
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
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
              showModalBottomSheet(
                context: context, 
                builder:(context) => TimeSettingBottomSheet(
                  initialTime: medicineAlarm.alarmTime
                ),
              ).then((takeDateTime) {
                if(takeDateTime == null || takeDateTime is! DateTime){
                  return;
                }
                historyRepository.addHistory(
                  MedicineHistory(
                    medicineId: medicineAlarm.id, 
                    alarmTime: medicineAlarm.alarmTime, 
                    takeTime: takeDateTime,
                  )
                );
              });
            },
            title: '아까',  
          ),
          Text('먹었어요', style: textStyle),
        ],
      )
    ];
  }
}
class AfterTakeTile extends StatelessWidget {
  const AfterTakeTile({
    Key? key, required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    return Row(
      children: [
        Stack(
          children: [
            _MedicineImageButton(medicineAlarm: medicineAlarm),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green.withOpacity(0.7),
              child: const Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context),
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
      Text.rich(
        TextSpan(
          text: '✅${medicineAlarm.alarmTime} ->',
          style: textStyle,
          children: [
            TextSpan(text: '20: 19', style: textStyle?.copyWith(fontWeight: FontWeight.w500)),
          ]
        ),
      ),
      // Text(' ', style: textStyle,),
      const SizedBox(height: 6,),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('${medicineAlarm.name},', style: textStyle,),
          TileActionButton(
            onTap: () {
            
            },
            title: '20시 19분에',  
          ),
          Text('먹었어요', style: textStyle),
        ],
      )
    ];
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        medicineRepository.deleteMedicine(medicineAlarm.key);
      },
      child: const Icon(CupertinoIcons.ellipsis_vertical),
    );
  }
}

class _MedicineImageButton extends StatelessWidget {
  const _MedicineImageButton({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: medicineAlarm.imagePath == null ? null : () {
        Navigator.push(
          context, 
          FadePageRoute(
            page: ImageDetailPage(medicineAlarm: medicineAlarm)
          )
        );
      },
      child:CircleAvatar(
        radius: 40,
        foregroundImage: medicineAlarm.imagePath == null ? null : FileImage(File(medicineAlarm.imagePath!)),
      ),
    );
  }
}