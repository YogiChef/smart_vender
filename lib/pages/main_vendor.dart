import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_vendor/pages/upload.dart';

import 'order.dart';
import 'earnings.dart';
import 'edit.dart';
import 'logout.dart';

class MainVendorPage extends StatefulWidget {
  const MainVendorPage({super.key});

  @override
  State<MainVendorPage> createState() => _MainVendorPageState();
}

class _MainVendorPageState extends State<MainVendorPage> {
  int _pageIndex = 0;
  final List<Widget> _page = [
    const EarningPage(),
    const UploadPage(),
    const EditPage(),
    const CartPage(),
    const LogOutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          currentIndex: _pageIndex,
          selectedLabelStyle: GoogleFonts.righteous(
            fontSize: 16,
          ),
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          selectedItemColor: Colors.yellow.shade900,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Edit',
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart), label: 'Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout), label: 'Sign Out'),
          ]),
      body: _page[_pageIndex],
    );
  }
}
