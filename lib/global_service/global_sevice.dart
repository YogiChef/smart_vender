import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/vendor_controller.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
VendorController vendor = VendorController();
styles(
  {
    double? letterSpacing,
    double? fontSize,
    double? height,
    FontWeight? fontWeight,
    Color? color,
  }
){
  return GoogleFonts.righteous(
    height: height,
    letterSpacing:letterSpacing,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
