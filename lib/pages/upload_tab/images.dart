// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../global_service/global_sevice.dart';
import '../../providers/product_provider.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker picker = ImagePicker();

  List<File> _image = [];
  List<String> _imageUrlList = [];

  choosGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No image picked');
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  choosCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      print('No image picked');
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: _image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                chooseOption(context);
                              },
                              icon: Icon(
                                  CupertinoIcons.photo_fill_on_rectangle_fill,
                                  size: 34,
                                  color: Colors.grey),
                            ),
                            Text(
                              'Choose\nImages here.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.righteous(
                                  fontSize: 14, color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index - 1]),
                                fit: BoxFit.cover)),
                      );
              }),
        ),
        TextButton(
            onPressed: () async {
              EasyLoading.show(status: 'Saving Images');
              for (var img in _image) {
                Reference ref = storage
                    .ref()
                    .child('productImage')
                    .child(const Uuid().v4());
                await ref.putFile(img).whenComplete(() async {
                  await ref.getDownloadURL().then((value) {
                    setState(() {
                      _imageUrlList.add(value);
                    });
                  });
                });
              }
              setState(() {
                _productProvider.getFormData(imageUrlList: _imageUrlList);
                _image = [];
                EasyLoading.dismiss();
              });
            },
            child: _image.isNotEmpty
                ? Text(
                    'Upload',
                    style: GoogleFonts.righteous(
                        color: Colors.yellow.shade900, fontSize: 16),
                  )
                : const Text(''))
      ],
    );
  }

  Future<dynamic> chooseOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose option',
              style: GoogleFonts.righteous(
                fontWeight: FontWeight.w500,
                color: Colors.yellow.shade900,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      choosCamera();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        Text(
                          'Camera',
                          style: GoogleFonts.righteous(
                            fontWeight: FontWeight.w500,
                            color: Colors.cyan.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      choosGallery();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.green.shade900,
                          ),
                        ),
                        Text(
                          'Gallery',
                          style: GoogleFonts.righteous(
                              fontWeight: FontWeight.w500,
                              color: Colors.cyan.shade400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Cancel',
                          style: GoogleFonts.righteous(
                              fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
