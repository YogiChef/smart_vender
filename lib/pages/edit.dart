import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_vendor/edit_product_tab/published_tab.dart';

import '../edit_product_tab/unpublished_tab.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Manage Products',
            style: GoogleFonts.righteous(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
          ),
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              child: Text(
                'Published',
                style: GoogleFonts.righteous(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Unpublished',
                style: GoogleFonts.righteous(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            )
          ]),
        ),
        body: TabBarView(children: [
          PublishedTab(),
          UnpublishedTab(),
        ]),
      ),
    );
  }
}
