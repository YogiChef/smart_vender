// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_vendor/pages/upload_tab/atributes.dart';
import 'package:smart_vendor/pages/upload_tab/general.dart';
import 'package:smart_vendor/pages/upload_tab/images.dart';
import 'package:smart_vendor/pages/upload_tab/shipping.dart';
import 'package:uuid/uuid.dart';

import '../global_service/global_sevice.dart';
import '../providers/product_provider.dart';
import 'main_vendor.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            bottom: TabBar(
                labelStyle: GoogleFonts.righteous(
                  fontSize: 16,
                  color: Colors.white,
                ),
                unselectedLabelColor: Colors.yellow,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: const [
                  Tab(
                    child: Text('General'),
                  ),
                  Tab(
                    child: Text(
                      'Shipping',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Attributes',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text('Images'),
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            GeneralPage(),
            ShippingPage(),
            AtributesPage(),
            ImagesPage(),
          ]),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade900,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show(status: 'Uploading...');
                    final proId = const Uuid().v4();
                    await firestore.collection('products').doc(proId).set({
                      'approved': false,
                      'proId': proId,
                      'proName': _productProvider.productData['productName'],
                      'price': _productProvider.productData['productPrice'],
                      'qty': _productProvider.productData['quantity'],
                      'category': _productProvider.productData['category'],
                      'description':
                          _productProvider.productData['description'],
                      'date': DateTime
                          .now(), // _productProvider.productData['date'],
                      'chargeShipping':
                          _productProvider.productData['chargeShipping'],
                      'shippingCharge':
                          _productProvider.productData['shippingCharge'],
                      'brandName': _productProvider.productData['brandName'],
                      'size': _productProvider.productData['sizeList'],
                      'imageUrl': _productProvider.productData['imageUrlList'],
                      'vendorId': auth.currentUser!.uid,
                    }).whenComplete(() async {
                      _productProvider.clearData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainVendorPage()));
                      EasyLoading.dismiss();
                      _formKey.currentState!.reset();
                    });
                  }
                },
                child: Text(
                  'Save',
                  style: GoogleFonts.righteous(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
