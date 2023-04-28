import 'package:ar_furniture_app/models/item_model.dart';
import 'package:flutter/material.dart';

import '../../screens/items_screen_details.dart';

class ItemUIWidget extends StatefulWidget {
  Items? items;
  BuildContext? context;
  ItemUIWidget({super.key, this.items, this.context});

  @override
  State<ItemUIWidget> createState() => _ItemUIWidgetState();
}

class _ItemUIWidgetState extends State<ItemUIWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //send user to details screen
          Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetialsScreen(
          clickedItemInfo: widget.items,
        )));
      },
      splashColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            // Image
            Image.network(
              widget.items!.itemImage.toString(),
              height: 144,
              width: 140,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                //item name
                Expanded(
                    child: Text(widget.items!.itemName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16))),
                const SizedBox(
                  height: 5,
                ),
                //seller name
                Expanded(
                    child: Text(widget.items!.sellerName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.pinkAccent, fontSize: 14))),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                // show discount page
                Row(
                  children: [
                    //50%

                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.pink),
                      alignment: Alignment.topLeft,
                      height: 44,
                      width: 30,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '50%',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'OFF',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      )),
                    ),
                    //display price
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        //original price
                        Row(
                          children: [
                           const  Text(
                          'Original Price :\$',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text((double.parse(widget.items!.itemPrice!) + double.parse(widget.items!.itemPrice!)).toString(),  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),),
                          ],
                        ),
                        //new price 

                           Row(
                          children: [
                           const  Text(
                          'New Price :\$',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                            const  Text(
                          '\$',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(widget.items!.itemPrice!.toString(),  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red ,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  ),
                          ],
                        ),

                            
                      ],
                    )
                  ],
                ),
             const   Divider(
              height: 4,
              color: Colors.white70,
             )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
