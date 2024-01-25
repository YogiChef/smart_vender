import 'package:flutter/material.dart';
import 'package:smart_vendor/services/sevice.dart';
import 'package:smart_vendor/widgets/input_textfield.dart';
import 'package:uuid/uuid.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late String amount;
  late String name;
  late String mobile;
  late String bankname;
  late String bankaccount;
  late String accountnumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            'Withdraw',
            style: styles(
              fontSize: 18,
              color: Colors.white,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                InputTextfield(
                  textInputType: TextInputType.number,
                  prefixIcon: Icon(Icons.money),
                  hintText: 'Amount',
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Amount must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
                InputTextfield(
                    textInputType: TextInputType.text,
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      name = value;
                    }),
                InputTextfield(
                    textInputType: TextInputType.phone,
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: 'Mobile',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Mobile must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      mobile = value;
                    }),
                InputTextfield(
                    textInputType: TextInputType.text,
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    hintText: 'Bank Name, eg Access Bank',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Bank Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      bankname = value;
                    }),
                InputTextfield(
                    textInputType: TextInputType.text,
                    prefixIcon: Icon(Icons.account_balance_outlined),
                    hintText: 'Bank Account Name, ',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Amount must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      bankaccount = value;
                    }),
                InputTextfield(
                    textInputType: TextInputType.number,
                    prefixIcon: Icon(Icons.numbers_outlined),
                    hintText: 'Bank Account Number',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Amount must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      accountnumber = value;
                    }),
                TextButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        await firestore
                            .collection('withdrawal')
                            .doc(Uuid().v4())
                            .set({
                          'amount': amount,
                          'name': name,
                          'mobile': mobile,
                          'bankname': bankname,
                          'bankaccount': bankaccount,
                          'accountnumber': accountnumber,
                        });
                        _globalKey.currentState!.reset();
                      }
                    },
                    child: Text(
                      'Get Cash',
                      style: styles(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
