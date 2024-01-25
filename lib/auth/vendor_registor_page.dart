import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:smart_vendor/auth/landing_page.dart';
import 'package:smart_vendor/services/sevice.dart';
import 'package:smart_vendor/widgets/button_widget.dart';
import 'package:smart_vendor/widgets/input_textfield.dart';

class VendorRegistorPage extends StatefulWidget {
  const VendorRegistorPage({super.key});

  @override
  State<VendorRegistorPage> createState() => _VendorRegistorPageState();
}

class _VendorRegistorPageState extends State<VendorRegistorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String password;
  late String phone;
  late String taxNumber;

  late String countryValue;
  late String stateValue;
  late String cityValue;

  Uint8List? image, coverImage;

  final List<String> _taxOptions = ['YES', 'NO'];
  String? _taxStatus;

  save() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait');
      await vendorController
          .saveVendor(
        name,
        email,
        phone,
        countryValue,
        stateValue,
        cityValue,
        _taxStatus!,
       _taxStatus == 'NO' ? 'null' : taxNumber,
        image,
        coverImage,
      )
          .whenComplete(() {
        EasyLoading.dismiss();    
        _formKey.currentState!.reset();
        setState(() {
          image = null;
          coverImage = null;
        });        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(0),
                        image: coverImage != null
                            ? DecorationImage(
                                image: MemoryImage(coverImage!),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                                image: AssetImage('images/viewcover.jpg'),
                                fit: BoxFit.cover),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              image != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.yellow.shade900,
                                      backgroundImage: MemoryImage(image!),
                                    )
                                  : const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/profile.jpg'),
                                    ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.cyan.shade400,
                                  radius: 18,
                                  child: IconButton(
                                      onPressed: () {
                                        chooseOption(context);
                                      },
                                      icon: image != null
                                          ? const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          : const Icon(
                                              CupertinoIcons.photo,
                                              color: Colors.white,
                                              size: 18,
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red.shade400,
                        radius: 18,
                        child: IconButton(
                            onPressed: () {
                              chooseOptionCoverImage(context);
                            },
                            icon: coverImage != null
                                ? const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : const Icon(
                                    CupertinoIcons.photo,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Create\nVendor\'s Account',
                  textAlign: TextAlign.start,
                  style: styles(
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow.shade900,
                  ),
                ),
              ),
              InputTextfield(
                hintText: 'Enter Full Name',
                textInputType: TextInputType.text,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.yellow.shade900,
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plaese Enter your name';
                  } else {
                    return null;
                  }
                },
              ),
              InputTextfield(
                hintText: 'Enter Email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.cyan.shade400,
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email addres';
                  } else if (value.isValidEmail() == false) {
                    return 'invalid email';
                  } else if (value.isValidEmail() == true) {
                    return null;
                  } else {
                    return null;
                  }
                },
              ),
         
              InputTextfield(
                hintText: 'Enter Full Phone',
                textInputType: TextInputType.phone,
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.green.shade300,
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plaese Enter your Phone';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SelectState(
                  style: styles(color: Colors.black54),
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
                      style: styles(color: Colors.cyan.shade600, fontSize: 16),
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
                              style: styles(
                                  color: Colors.cyan.shade600, fontSize: 16),
                            ),
                            items: _taxOptions
                                .map<DropdownMenuItem<String>>((String value) =>
                                    DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: styles(color: Colors.deepOrange),
                                      ),
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
                          labelStyle: styles(color: Colors.cyan.shade600),
                        ),
                      ),
                    )
                  : const SizedBox(),
              
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ButtonWidget(
          label: 'Save',
          style: styles(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: Colors.white,
          ),
          icon: Icons.save,
          press: save,
        ),
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
              style: styles(
                fontWeight: FontWeight.w500,
                color: Colors.yellow.shade900,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      selectCameca();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        Text(
                          'Camera',
                          style: styles(
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
                            Icons.image_outlined,
                            color: Colors.green.shade900,
                          ),
                        ),
                        Text(
                          'Gallery',
                          style: styles(
                              fontWeight: FontWeight.w500,
                              color: Colors.cyan.shade400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      remove();
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
                          style: styles(
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

  selectCameca() async {
    Uint8List img = await vendorController.pickStoreImage(ImageSource.camera);
    setState(() {
      image = img;
    });
  }

  selectGallery() async {
    final img = await vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      image = img;
    });
  }

  remove() {
    Navigator.pop(context);
  }

  Future<dynamic> chooseOptionCoverImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose option',
              style: styles(
                fontWeight: FontWeight.w500,
                color: Colors.yellow.shade900,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      selectCamecaCoverImg();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        Text(
                          'Camera',
                          style: styles(
                            fontWeight: FontWeight.w500,
                            color: Colors.cyan.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectGalleryCoverImg();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.yellow.shade900,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.green.shade900,
                          ),
                        ),
                        Text(
                          'Gallery',
                          style: styles(
                              fontWeight: FontWeight.w500,
                              color: Colors.cyan.shade400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      removeCoverImg();
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
                          style: styles(
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

  selectCamecaCoverImg() async {
    Uint8List img = await vendorController.pickStoreImage(ImageSource.camera);
    setState(() {
      coverImage = img;
    });
  }

  selectGalleryCoverImg() async {
    final img = await vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      coverImage = img;
    });
  }

  removeCoverImg() {
    Navigator.pop(context);
  }
}
