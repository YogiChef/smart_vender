import 'package:flutter/material.dart';
import 'package:smart_vendor/pages/tab_bar_edit/published_tab.dart';
import 'package:smart_vendor/pages/tab_bar_edit/unpublished_tab.dart';
import 'package:smart_vendor/services/sevice.dart';

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
          flexibleSpace: Center(
            child: Text(
              'Manage Products',
              style: styles(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  color: Colors.white),
            ),
          ),
          title: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: styles(color: Colors.white),
              unselectedLabelColor: Colors.yellow,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  child: Text(
                    'Published',
                  ),
                ),
                Tab(
                  child: Text(
                    'Unpublished',
                  ),
                )
              ]),
        ),
        body: const TabBarView(children: [
          PublishedTab(),
          UnpublishedTab(),
        ]),
      ),
    );
  }
}
