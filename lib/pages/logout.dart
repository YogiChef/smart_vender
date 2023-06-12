import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_vendor/vendors/vendor_auth.dart';
import 'package:smart_vendor/widgets/dialog.dart';

import '../global_service/global_sevice.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 30),
            child: Text(
              'Sign Out',
              style: GoogleFonts.righteous(fontSize: 45, color: Colors.red),
            ),
          ),
          CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('images/signout.png'),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900,
              ),
              onPressed: () async {
                MyAlertDialog.showMyDialog(
                    contant: 'Are you sure to log out ',
                    context: context,
                    tabNo: () {
                      Navigator.pop(context);
                    },
                    tabYes: () async {
                      await auth.signOut().whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VendorAuthPage())));

                      await Future.delayed(const Duration(microseconds: 100));
                    },
                    title: 'Log Out');
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.righteous(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ))
        ],
      ),
      // child: TextButton(
      //   child:
      //   onPressed: () async{
      //

      //   },
      // ),
    );
  }
}
