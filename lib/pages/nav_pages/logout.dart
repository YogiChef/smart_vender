import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_vendor/auth/vendor_auth.dart';
import 'package:smart_vendor/services/sevice.dart';
import 'package:smart_vendor/widgets/button_widget.dart';
import 'package:smart_vendor/widgets/dialig.dart';

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
              style: GoogleFonts.righteous(fontSize: 30, color: Colors.red),
            ),
          ),
          const CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('images/signout.png'),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
            ),
            width: double.infinity,
            child: ButtonWidget(
              label: 'Sign Out',
              style: styles(
                color: Colors.white,
              ),
              icon: Icons.logout,
              press: () async {
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
                              builder: (context) => const VendorAuthPage())));

                      await Future.delayed(const Duration(microseconds: 100));
                    },
                    title: 'Log Out');
              },
            ),
          )
        ],
      ),
    );
  }
}
