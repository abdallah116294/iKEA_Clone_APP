import 'package:ar_furniture_app/models/item_model.dart';
import 'package:ar_furniture_app/screens/upload_items_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../core/widget/items_ui_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cotext) => const ItmesUploadScreen()));
              },
              icon: const Icon(Icons.add))
        ],
        centerTitle: true,
        title: const Text(
          'iKEA Clone',
          style: TextStyle(
              fontSize: 19, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('items')
      //       .orderBy('publishedDate', descending: true)
      //       .snapshots(),
      //   builder: (context, AsyncSnapshot dataSnapshot) {
      //     if (dataSnapshot.hasData) {
      //       return ListView.builder(
      //           itemCount: dataSnapshot.data!.docs.length,
      //           itemBuilder: (context, index) {
      //             Items items = Items.fromJson(
      //             dataSnapshot.data!.docs[index].data() as Map<String, dynamic>
      //           );
      //             return ItemUIWidget(
      //               context: context,
      //               items: items,
      //             );
      //           });
      //     } else {
      //       return Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //         children: const [
      //           Center(
      //             child: Text(
      //               "Data is not available.",
      //               style: TextStyle(
      //                 fontSize: 30,
      //                 color: Colors.grey,
      //               ),
      //             ),
      //           ),
      //         ],
      //       );
      //     }
      //   },
      // ),
      //code form video
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot)
        {
          if(dataSnapshot.hasData)
          {
            return ListView.builder(
              itemCount: dataSnapshot.data!.docs.length,
              itemBuilder: (context, index)
              {
                Items eachItemInfo = Items.fromJson(
                  dataSnapshot.data!.docs[index].data() as Map<String, dynamic>
                );

                return ItemUIWidget(
                  items: eachItemInfo,
                  context: context,
                );
              },
            );
          }
          else
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child:CircularProgressIndicator(color: Colors.pinkAccent,)
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
