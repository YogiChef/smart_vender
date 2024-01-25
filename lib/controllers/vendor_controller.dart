// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_vendor/services/sevice.dart';

class VendorController {
  uploadImagToStorage(Uint8List image) async {
    Reference ref =
        storage.ref().child('storeImages').child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  coverImageToStorage(Uint8List coverimage) async {
    Reference ref =
        storage.ref().child('coverPick').child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(coverimage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveVendor(
    String name,
    String email,
    String phone,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxStatus,
    String taxNumber,
    Uint8List? image,
    coverImg,
  ) async {
    String res = 'some error occured';
    try {
      String storeImage = await uploadImagToStorage(
        image!,
      );
      String coverImage = await coverImageToStorage(coverImg);
      await firestore.collection('vendors').doc(auth.currentUser!.uid).set({
        'vendorId': auth.currentUser!.uid,
        'bussinessName': name,
        'email': email,
        'phone': phone,
        'country': countryValue,
        'state': stateValue,
        'city': cityValue,
        'taxStatus': taxStatus,
        'taxNo': taxNumber ,
        'image': storeImage,
        'coverImage': coverImage,
        'approved': false,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return res;
  }

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imgPicker = ImagePicker();
    XFile? _file = await _imgPicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      Fluttertoast.showToast(msg: 'No image seleted');
    }
  }
}
