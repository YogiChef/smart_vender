// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:smart_vendor/services/sevice.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          'Orders',
          style: styles(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const LinearProgressIndicator(color: Colors.green),
            ));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Slidable(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow.shade900),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 14,
                                  child: document['accepted'] == true
                                      ? const Icon(
                                          Icons.delivery_dining,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.access_time,
                                          color: Colors.red,
                                        ),
                                ),
                                title: document['accepted'] == true
                                    ? Text(
                                        'Accepted',
                                        style: styles(
                                            fontSize: 16, color: Colors.green),
                                      )
                                    : Text(
                                        'Not Accepted',
                                        style: styles(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                subtitle: Text(
                                  DateFormat('dd/MM/yyyy - hh:mm')
                                      .format(document['oderDate'].toDate()),
                                  style: styles(
                                      fontSize: 14,
                                      color: document['accepted'] == true
                                          ? Colors.green
                                          : Colors.yellow.shade900),
                                ),
                                trailing: Text(
                                  '฿${document['price'] * document['qty'].floor()}',
                                  style: styles(
                                      fontSize: 16,
                                      color: document['accepted'] == true
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                              document['accepted'] == true
                                  ? const SizedBox()
                                  : Positioned(
                                      left: 200,
                                      top: 0,
                                      child: Image.asset('images/new.png'),
                                      height: 60,
                                      width: 80,
                                    ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              'Order Datails',
                              style: styles(
                                  fontSize: 16,
                                  color: document['accepted'] == true
                                      ? Colors.green
                                      : Colors.black54),
                            ),
                            // subtitle: Text('View'),
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 60,
                                  width: 80,
                                  child: Image.network(
                                    document['productImage'][0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document['proName'],
                                      style: styles(),
                                    ),
                                    Text(
                                      '฿${document['price'].toStringAsFixed(0)}',
                                      style: styles(),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Quantity',
                                          style: styles(
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          document['qty'].toString(),
                                          style: styles(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                    document['accepted'] == true
                                        ? Text(
                                            'Delivery Date: ${DateFormat('dd/MM/yyyy - hh:mm').format(document['scheduleDate'].toDate())}',
                                            style: styles(
                                                fontSize: 14,
                                                color: Colors.green.shade700),
                                          )
                                        : const Text(''),
                                    ListTile(
                                        title: Text(
                                          'Buyer Details',
                                          style: styles(fontSize: 16),
                                        ),
                                        subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document['fullName'],
                                                style: styles(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                document['phone'],
                                                style: styles(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                document['email'],
                                                style: styles(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                document['address'],
                                                style: styles(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              )
                                            ])),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    // dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          await firestore
                              .collection('orders')
                              .doc(document['orderId'])
                              .update({'accepted': false});
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.eject_outlined,
                        label: 'Reject',
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          await firestore
                              .collection('orders')
                              .doc(document['orderId'])
                              .update({'accepted': true});
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.approval_outlined,
                        label: 'Accept',
                      ),
                    ],
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
