// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../global_service/global_sevice.dart';
import '../../providers/product_provider.dart';
import '../../widgets/input_textfield.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final List<String> _categoryList = [];

  getCategory() {
    return firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.category),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow.shade900, width: 2)),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      )),
                  hint: Text(
                    'Select Category',
                    style: GoogleFonts.righteous(fontSize: 16),
                  ),
                  items: _categoryList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (valur) {
                    setState(() {
                      _productProvider.getFormData(category: valur);
                    });
                  }),
            ),
            InputTextfield(
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.drive_file_rename_outline),
              hintText: 'Product Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Bussiness Name must not be empty';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(productName: value);
              },
            ),
            InputTextfield(
                textInputType: TextInputType.number,
                prefixIcon: const Icon(Icons.money_sharp),
                hintText: 'Product Price',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Email Address must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                }),
            InputTextfield(
              textInputType: TextInputType.number,
              prefixIcon: const Icon(Icons.qr_code),
              hintText: 'Product Quantity',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Phone Number must not be empty';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(qty: int.parse(value));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 400,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Product Description';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Product Description',
                      labelStyle: GoogleFonts.righteous(color: Colors.black54),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow.shade900, width: 2))),
                  onChanged: (value) {
                    _productProvider.getFormData(description: value);
                  }),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(5000),
                        ).then((value) {
                          setState(() {
                            _productProvider.getFormData(date: value);
                          });
                        });
                      },
                      child: Text(
                        'Schedule',
                        style: GoogleFonts.righteous(
                            color: Colors.yellow.shade900, fontSize: 16),
                      )),
                ),
                if (_productProvider.productData['date'] != null)
                  Text(
                    formatedDate(
                      _productProvider.productData['date'],
                    ),
                    style: GoogleFonts.righteous(
                        color: Colors.cyan.shade400, fontSize: 14),
                  )
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
