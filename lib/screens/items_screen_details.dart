import 'package:ar_furniture_app/screens/virtual_screen_screen.dart';
import 'package:flutter/material.dart';

import '../models/item_model.dart';

class ItemDetialsScreen extends StatefulWidget {
  Items? clickedItemInfo;
  ItemDetialsScreen({super.key, this.clickedItemInfo});

  @override
  State<ItemDetialsScreen> createState() => _ItemDetialsScreenState();
}

class _ItemDetialsScreenState extends State<ItemDetialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.clickedItemInfo!.itemName.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Image.network(widget.clickedItemInfo!.itemImage.toString()),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                widget.clickedItemInfo!.itemName.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
            ),
            
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                child: Text(
                  widget.clickedItemInfo!.itemDescription.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ),
            Padding(padding: const EdgeInsets.all(8),child:  Text(
                  "${widget.clickedItemInfo!.itemPrice} \$",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white70,
                  ),
                ),),
                     const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 310.0),
                child: Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.white70,
                ),
              ),
          ]),
        ),
      ),
            floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pinkAccent,
        onPressed: ()
        {
          //try item virtually (arview)
          Navigator.push(context, MaterialPageRoute(builder: (c)=> VirtualARViewScreen(
            clickedItemImageLink: widget.clickedItemInfo!.itemImage.toString(),
          )));
        },
        label: const Text(
          "Try Virtually (AR View)",
        ),
        icon: const Icon(
          Icons.mobile_screen_share_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
