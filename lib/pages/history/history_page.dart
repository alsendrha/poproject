import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/models/medicine.dart';
import 'package:poproject/pages/today/today_take_tile.dart';

import '../../main.dart';
import '../../models/medicine_history.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('잘 복용 했어요 👏', style: Theme.of(context).textTheme.headline4,),
        const SizedBox(height: regulaSpace,),
        const Divider(height: 1, thickness: 1.0),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: historyRepository.historyBox.listenable(),
            builder: _buildListView
          )
        ),
      ],
    );
  }

  Widget _buildListView(context,Box<MedicineHistory> historyBox, _) {
   final histories = historyBox.values.toList().reversed.toList();
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        return _TimeTile(history: history);
    },);
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    Key? key,
    required this.history,
  }) : super(key: key);

  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            DateFormat('yyy\nMM.dd E', 'ko_KR').format(history.takeTime),
            textAlign: TextAlign.center,
        
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              height: 1.6,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
        const SizedBox(width: smallSpace,),
        Stack(
          alignment: const Alignment(0.0, -0.3),
          children: const [
            SizedBox(
              height: 130,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
              ),
            ),
            CircleAvatar(
              radius: 4,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: medicine.imagePath != null,
                child: MedicineImageButton(imagePath: medicine.imagePath)),
                const SizedBox(width: smallSpace,),
              Text(
                '${DateFormat('a hh:mm', 'ko_KR').format(history.takeTime)}\n${medicine.name}',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  height: 1.6,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ],
          )
        )
      ],
    );
  }

  Medicine get medicine {
    return medicineRepository.medicineBox.values.singleWhere(
      (element) => element.id == history.medicineId && element.key == history.medicineKey, 
      orElse: () => Medicine(
        id: -1, 
        imagePath: history.imagePath, 
        alarms: [],
        name: history.name//'삭제된 약입니다.' 
      ),
    );
  } 
}