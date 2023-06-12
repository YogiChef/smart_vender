// ignore_for_file: sort_child_properties_last

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_vendor/vendors/landing.dart';
import 'package:smart_vendor/widgets/input_textfield.dart';

import '../global_service/global_sevice.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String phone;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String taxNumber;

  Uint8List? _image;

  final List<String> _taxOptions = ['YES', 'NO'];
  String? _taxStatus;

  selectGallery() async {
    final img = await vendor.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  selectCamera() async {
    final img = await vendor.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  save() async {
    EasyLoading.show(status: 'Please wait');
    if (_formKey.currentState!.validate()) {
      await vendor
          .saveVendor(name, email, phone, countryValue, stateValue, cityValue,
              _taxStatus!, taxNumber, _image)
          .whenComplete(() {
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
        });
        EasyLoading.dismiss();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LandingPage()));
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange.shade900,
                        Colors.yellow.shade700
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white, width: 4)),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    chooseOption(context);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.photo,
                                    color: Colors.white,
                                  )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _image != null
                            ? CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      chooseOption(context);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    )))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextfield(
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.account_circle),
                    hintText: 'Bussiness Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Bussiness Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  InputTextfield(
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Email Address must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }),
                  InputTextfield(
                    textInputType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone),
                    hintText: 'Phone',
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SelectState(
                      style: GoogleFonts.righteous(color: Colors.black54),
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax Registered?',
                          style: GoogleFonts.righteous(
                              color: Colors.cyan.shade600, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 100,
                            child: DropdownButtonFormField(
                                hint: Text(
                                  'Select',
                                  style: GoogleFonts.righteous(
                                      color: Colors.cyan.shade600,
                                      fontSize: 16),
                                ),
                                items: _taxOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              child: Text(
                                                value,
                                                style: GoogleFonts.righteous(
                                                    color: Colors.deepOrange),
                                              ),
                                              value: value,
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _taxStatus = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _taxStatus == 'YES'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                taxNumber = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Tax Number must not be empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Tax Number',
                              labelStyle: GoogleFonts.righteous(
                                  color: Colors.cyan.shade600),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900,
                        ),
                        onPressed: () {
                          save();
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.righteous(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> chooseOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose option',
              style: GoogleFonts.righteous(
                fontWeight: FontWeight.w500,
                color: Colors.yellow.shade900,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      selectCamera();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        Text(
                          'Camera',
                          style: GoogleFonts.righteous(
                            fontWeight: FontWeight.w500,
                            color: Colors.cyan.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectGallery();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.green.shade900,
                          ),
                        ),
                        Text(
                          'Gallery',
                          style: GoogleFonts.righteous(
                              fontWeight: FontWeight.w500,
                              color: Colors.cyan.shade400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Remove',
                          style: GoogleFonts.righteous(
                              fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
