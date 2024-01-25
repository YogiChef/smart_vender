import 'package:flutter/material.dart';
import 'package:smart_vendor/services/sevice.dart';
import 'package:smart_vendor/widgets/button_widget.dart';
import 'package:smart_vendor/widgets/input_textfield.dart';

class VendorProductDetail extends StatefulWidget {
  final dynamic productData;
  const VendorProductDetail({super.key, required this.productData});

  @override
  State<VendorProductDetail> createState() => _VendorProductDetailState();
}

class _VendorProductDetailState extends State<VendorProductDetail> {
  final _proNameCtl = TextEditingController();
  final _brandNameCtl = TextEditingController();
  final _qtyNameCtl = TextEditingController();
  final _proPriceCtl = TextEditingController();
  final _proDesCtl = TextEditingController();
  final _categoryCtl = TextEditingController();

  @override
  void initState() {
    _proNameCtl.text = widget.productData['proName'];
    _brandNameCtl.text = widget.productData['brandName'];
    _qtyNameCtl.text = widget.productData['qty'].toString();
    _proPriceCtl.text = widget.productData['price'].toString();
    _proDesCtl.text = widget.productData['description'];
    _categoryCtl.text = widget.productData['category'];

    super.initState();
  }

  double? productPrice;
  int? quantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          elevation: 0,
          centerTitle: true,
          title: Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(widget.productData['imageUrl'][0])),
              const SizedBox(
                width: 20,
              ),
              Text(widget.productData['proName'], style: styles(fontSize: 24)),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InputTextfield(
                controller: _proNameCtl,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.local_mall_outlined),
                hintText: 'Product Name',
                label: const Text('Product Name'),
                onChanged: (value) {},
              ),
              InputTextfield(
                controller: _brandNameCtl,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.bookmark_border_rounded),
                hintText: 'Brand Name',
                label: const Text('Brand Name'),
                onChanged: (value) {},
              ),
              InputTextfield(
                // initialValue: widget.productData['qty'].toString(),
                controller: _qtyNameCtl,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.production_quantity_limits_outlined),
                hintText: 'Quantity',
                label: const Text('Quantity'),
                onChanged: (value) {
                  quantity = int.parse(value);
                },
              ),
              InputTextfield(
                initialValue: widget.productData['price'].toString(),
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.currency_bitcoin),
                hintText: 'Price',
                label: const Text('Price'),
                onChanged: (value) {
                  productPrice = double.parse(value);
                },
              ),
              InputTextfield(
                maxLength: 400,
                controller: _proDesCtl,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.description_outlined),
                hintText: 'Description',
                label: const Text('Description'),
                onChanged: (value) {},
              ),
              InputTextfield(
                controller: _categoryCtl,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.category_outlined),
                hintText: 'Category',
                label: const Text('Category'),
                onChanged: (value) {}, 
              ),
              ButtonWidget(label: 'Update', icon: Icons.update_outlined, press:() async {
                    
                      await firestore
                          .collection('products')
                          .doc(widget.productData['proId'])
                          .update({    
                        'proName': _proNameCtl.text,
                        'brandName': _brandNameCtl.text,
                        'qty':quantity,
                        'price': widget.productData['price'],
                        'description': _proDesCtl.text,
                        'category': _categoryCtl.text,
                      // ignore: unnecessary_set_literal
                      }).whenComplete(() => {Navigator.pop(context)});
                      // if (productPrice != null) {
                      //   await firestore
                      //       .collection('products')
                      //       .doc(widget.productData['proId'])
                      //       .update({
                      //     'proName': _proNameCtl.text,
                      //     'brandName': _brandNameCtl.text,
                      //     'qty': widget.productData['qty'],
                      //     'price': productPrice,
                      //     'description': _proDesCtl.text,
                      //     'category': _categoryCtl.text,
                      //   }).whenComplete(() => {Navigator.pop(context)});
                      // } else {
                      //   await firestore
                      //       .collection('products')
                      //       .doc(widget.productData['proId'])
                      //       .update({
                      //     'proName': _proNameCtl.text,
                      //     'brandName': _brandNameCtl.text,
                      //     'qty': widget.productData['qty'],
                      //     'price': productPrice,
                      //     'description': _proDesCtl.text,
                      //     'category': _categoryCtl.text,
                      //   }).whenComplete(() => {Navigator.pop(context)});
                      // }
                    
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
