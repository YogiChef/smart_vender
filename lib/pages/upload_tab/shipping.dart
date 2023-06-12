import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/input_textfield.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _chargeShipping = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
            activeColor: Colors.yellow.shade900,
            title: Text(
              'Charge Shipping',
              style: GoogleFonts.righteous(
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.black54,
              ),
            ),
            value: _chargeShipping,
            onChanged: (value) {
              setState(() {
                _chargeShipping = value!;
                productProvider.getFormData(chargeShipping: _chargeShipping);
              });
            }),
        if (_chargeShipping == true)
          InputTextfield(
              textInputType: TextInputType.number,
              prefixIcon: const Icon(CupertinoIcons.money_dollar_circle),
              hintText: 'Shipping Charge',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Shipping Charge';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(shippingCharge: int.parse(value));
              })
      ],
    );
  }
}
