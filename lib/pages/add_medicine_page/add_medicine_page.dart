// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poproject/components/poproject_constants.dart';
import 'package:poproject/pages/add_medicine_page/add_alarm_page.dart';
import 'package:poproject/pages/add_medicine_page/components/minwidgets.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();
  File? _medicineImage;
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body:  GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  '어떤 약이에요?', 
                  style: Theme.of(context).textTheme.headline4,
                 ),
                 const SizedBox(height: largeSpace,),
                  Center(
                    child: MedicineImageButton(
                      changeImageFile: (File? value) {
                        _medicineImage = value;
                      },
                    ),
                  ),
                  const SizedBox(height: largeSpace + regulaSpace,),
                 Text(
                  '약 이름', 
                  style: Theme.of(context).textTheme.subtitle1,),
                 TextFormField(
                  controller: _nameController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: '복용할 약 이름을 기입해주세요.',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    contentPadding: textFieldContentPadding,
                  ),
                  onChanged: (str){
                    setState(() {
                      
                    });
                  },
                 ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtomHeight,
            child: ElevatedButton(
              onPressed: _nameController.text.isEmpty ? null :
              // onPressed: () {
                _onAddAlrarmPage,
              // },
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ), 
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddAlrarmPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddAlarmPage(
        medicineImage: _medicineImage, 
        medicienName: _nameController.text
      ),
    ));
  }
}

class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({super.key, required this.changeImageFile});

  final ValueChanged<File?> changeImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _pickedImage == null ? null : EdgeInsets.zero,
        onPressed: _showBottomSheet,
        child: _pickedImage == null ? const Icon(
          CupertinoIcons.photo_camera_solid,
          size: 30,
          color: Colors.white,
        ) : CircleAvatar(
          foregroundImage: FileImage(_pickedImage!),
          radius: 40,
        ),
      ),
    );
  }
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context, builder: (context){
      return PickImageBottomSheet(
        onPressedCamera: () {
          _onPressed(ImageSource.camera);
        },
        onPressedGallery: () {
          _onPressed(ImageSource.gallery);
        },
      );
    });
  }
  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((Xfile) {
      if(Xfile != null){
        setState(() {
          _pickedImage = File(Xfile.path);
          widget.changeImageFile(_pickedImage);
        });
      }
      Navigator.maybePop(context);
    }); 
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({super.key, required this.onPressedCamera, required this.onPressedGallery});

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedCamera,
          child: const Text('카메라로 촬영'),
        ),
        TextButton(
          onPressed: onPressedGallery,
          child: const Text('앨범에서 가져오기'),
        ),
      ],
    );
  }
}