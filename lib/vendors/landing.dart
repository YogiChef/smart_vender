// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_vendor/vendors/registor.dart';

import '../global_service/global_sevice.dart';
import '../models/vender_model.dart';
import '../pages/main_vendor.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (!snapshot.data!.exists) {
          return const RegisterPage();
        }
        VenderModel vendorsModel =
            VenderModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
        return vendorsModel.approved == true
            ? const MainVendorPage()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        vendorsModel.image.toString(),
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      vendorsModel.bussinessName.toString(),
                      style: GoogleFonts.righteous(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Your application has been\n sent to shop admin.\n Admin will get back to you soon',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade200),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () async {
                         await auth.signOut();
                          
                        },
                        child: Text(
                          'Sign Out',
                          style: GoogleFonts.righteous(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.cyan.shade400,
                          ),
                        ))
                  ],
                ),
              );
      },
    ));
  }
}
