import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_vendor/pages/nav_pages/eanings_page.dart';
import 'package:smart_vendor/pages/nav_pages/edit_page.dart';
import 'package:smart_vendor/pages/nav_pages/logout.dart';
import 'package:smart_vendor/pages/nav_pages/orders.dart';
import 'package:smart_vendor/pages/nav_pages/upload_page.dart';
import 'package:smart_vendor/services/sevice.dart';

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
    const OrderPage(),
    const LogOutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          currentIndex: _pageIndex,
          selectedLabelStyle: styles(
            fontSize: 16,
          ),
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          selectedItemColor: Colors.yellow.shade900,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  _pageIndex == 0 ? IconlyBold.wallet : IconlyLight.wallet,
                  // opticalSize: 20,
                ),
                label: 'Earnings'),
            BottomNavigationBarItem(
                icon: Icon(
                    _pageIndex == 1 ? IconlyBold.upload : IconlyLight.upload),
                label: 'Upload'),
            BottomNavigationBarItem(
              icon: Icon(_pageIndex == 2 ? IconlyBold.edit : IconlyLight.edit),
              label: 'Edit',
            ),
            BottomNavigationBarItem(
                icon:
                    Icon(_pageIndex == 3 ? IconlyBold.bag2 : IconlyLight.bag2),
                label: 'Orders'),
            BottomNavigationBarItem(
                icon: Icon(
                    _pageIndex == 4 ? IconlyBold.logout : IconlyLight.logout),
                label: 'Sign Out'),
          ]),
      body: _page[_pageIndex],
    );
  }
}
