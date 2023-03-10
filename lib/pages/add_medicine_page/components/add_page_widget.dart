import 'package:flutter/material.dart';

import '../../../components/poproject_constants.dart';

class AddPageBody extends StatelessWidget {
  const AddPageBody({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
        ),
      ),
    );
  }
}

