// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_vendor/global_service/global_sevice.dart';
import '../../providers/product_provider.dart';
import '../../widgets/input_textfield.dart';

class AtributesPage extends StatefulWidget {
  const AtributesPage({super.key});

  @override
  State<AtributesPage> createState() => _AtributesPageState();
}

class _AtributesPageState extends State<AtributesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _sizeController = TextEditingController();
  final List<String> _sizeList = [];
  bool _entered = false;
  final bool _isSave = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        InputTextfield(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.branding_watermark),
            hintText: 'brand',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Brand Name';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SizedBox(
                width: 200,
                child: InputTextfield(
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.tab),
                    controller: _sizeController,
                    hintText: 'Size',
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: _entered == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade900,
                      ),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);

                          _sizeController.clear();
                        });
                        _productProvider.getFormData(sizeList: _sizeList);
                      },
                      child: Text(
                        'Add',
                        style: styles(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                  : const Text(''),
            ),
          ],
        ),
        if (_sizeList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            // minimumSize: Size(70, 35),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: BorderSide(
                                width: 1, color: Colors.yellow.shade900)),
                        onPressed: () {
                          setState(() {
                            _sizeList.removeAt(index);
                          });
                        },
                        child: Text(
                          _sizeList[index],
                          style: styles(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        // if (_sizeList.isNotEmpty)
        //   _isSave
        //       ? SizedBox()
        //       : ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.cyan.shade700,
        //           ),
        //           onPressed: () {
        //             EasyLoading.show(status: 'Saving Size');
        //             setState(() {
        //               _isSave = true;
        //               _sizeList = [];
        //               EasyLoading.dismiss();
        //             });

        //           },
        //           child: Text(
        //             'Save',
        //             style: GoogleFonts.righteous(
        //               fontSize: 16,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           )),
      ],
    );
  }
}
