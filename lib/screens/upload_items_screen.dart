import 'dart:typed_data';

import 'package:ar_furniture_app/services/api_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

import 'home_screen.dart';

class ItmesUploadScreen extends StatefulWidget {
  const ItmesUploadScreen({super.key});

  @override
  State<ItmesUploadScreen> createState() => _ItmesUploadScreenState();
}

class _ItmesUploadScreenState extends State<ItmesUploadScreen> {
  Uint8List? imageFileUint8List;
  String donwloadUrl = '';
  bool isUploading = false;
  final TextEditingController sallerNameController = TextEditingController();
  final TextEditingController sallerPhoneController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();

  final TextEditingController itemPriceController = TextEditingController();
  //showDialogBox
  showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.black,
            title: const Text(
              'Item image ',
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureImageWithPhoneCamera();
                },
                child: const Text(
                  'Capture image With camera',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  chooseImageFormGallery();
                },
                child: const Text(
                  'choose image fom Gallery',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancell',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          );
        });
  }

  //capture Image from Camera
  captureImageWithPhoneCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();
        //remove the background
        imageFileUint8List =
            await ApiHelper().removeImageBackgroubdApi(imagePath);
        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMesg) {
      print('Error' + errorMesg.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  //choose Image From Gallery
  chooseImageFormGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();
        //remove the background
        imageFileUint8List =
            await ApiHelper().removeImageBackgroubdApi(imagePath);
        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMesg) {
      print('Error' + errorMesg.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

//textform widget
  Widget textForm(
      {String? name,
      IconData? iconData,
      TextEditingController? textEditingController}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
      ),
      title: SizedBox(
        width: 250,
        child: TextField(
          style: const TextStyle(color: Colors.grey),
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: name,
              hintStyle: const TextStyle(color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }

  validateUploadFromAndUpload() async {
    if (imageFileUint8List != null) {
      if (sallerNameController.text.isNotEmpty &&
          sallerPhoneController.text.isNotEmpty &&
          itemDescriptionController.text.isNotEmpty &&
          itemNameController.text.isNotEmpty &&
          itemPriceController.text.isNotEmpty) {
        setState(() {
          isUploading = true;
        });
        //uploda cloud storage
        // String imageUniqueName = DateTime.now().millisecond.toString();
        // fstorage.Reference firebaseStorageReference = fstorage
        //     .FirebaseStorage.instance
        //     .ref()
        //     .child('items images')
        //     .child(imageUniqueName);
        // fstorage.UploadTask uploadTask =
        //     firebaseStorageReference.putData(imageFileUint8List!);
        // fstorage.TaskSnapshot taskSnapshot =
        //     await uploadTask.whenComplete(() {});
        // await taskSnapshot.ref.getDownloadURL().then((value) {
        //    donwloadUrl=value ;
        // });
        // code of the video
                String imageUniqueName = DateTime.now().millisecondsSinceEpoch.toString();

        fstorage.Reference firebaseStorageRef = fstorage.FirebaseStorage.instance.ref()
            .child("items images")
            .child(imageUniqueName);

        fstorage.UploadTask uploadTaskImageFile = firebaseStorageRef.putData(imageFileUint8List!);

        fstorage.TaskSnapshot taskSnapshot = await uploadTaskImageFile.whenComplete(() {});

        await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl)
        {
          donwloadUrl = imageDownloadUrl;
        });
        //item info
        saveItemInfoToFirestore();
      } else {
        Fluttertoast.showToast(msg: "pleas complet upload form");
      }
    } else {
      Fluttertoast.showToast(msg: 'upload Image file');
    }
  }
    saveItemInfoToFirestore()
  {
    String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore.instance
        .collection("items")
        .doc(itemUniqueId)
        .set(
        {
          "itemID": itemUniqueId,
          "itemName": itemNameController.text,
          "itemDescription": itemDescriptionController.text,
          "itemImage": donwloadUrl,
          "sellerName": sallerNameController.text,
          "sellerPhone": sallerPhoneController.text,
          "itemPrice": itemPriceController.text,
          "publishedDate": DateTime.now(),
          "status": "available",
        });

    Fluttertoast.showToast(msg: "your new Item uploaded successfully.");

    setState(() {
      isUploading = false;
      imageFileUint8List = null;
    });

    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
  }

  //upload from screen
  Widget uploadFromScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.all(4),
              child: IconButton(
                  onPressed: () {
                    //validate upload form fields
                    if (isUploading != true) {
                      validateUploadFromAndUpload();
                    }
                  },
                  icon: const Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                  )))
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Upload New Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(children: [
        isUploading == true
            ? const LinearProgressIndicator(
                color: Colors.purpleAccent,
              )
            : Container(),
        SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
              child: imageFileUint8List != null
                  ? Image.memory(imageFileUint8List!)
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    )),
        ),
        const Divider(
          color: Colors.white,
          thickness: 2,
        ),
        //seller name
        textForm(
            iconData: Icons.person_pin_outlined,
            name: 'Saller Name',
            textEditingController: sallerNameController),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        //saller phone
        textForm(
            iconData: Icons.phone,
            name: 'Saller Phone',
            textEditingController: sallerPhoneController),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        //item name
        textForm(
            iconData: Icons.title,
            name: 'Item Name',
            textEditingController: itemNameController),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        //item description
        textForm(
            iconData: Icons.description,
            name: 'Item Description',
            textEditingController: itemDescriptionController),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        // item price
        textForm(
            iconData: Icons.price_change,
            name: 'item Price',
            textEditingController: itemPriceController),
      ]),
    );
  }

  //defult Screen
  Widget defualtScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Upload New Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_photo_alternate, color: Colors.white, size: 200),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
              onPressed: () {
                showDialogBox();
              },
              child: const Text(
                'Add new item ',
                style: TextStyle(color: Colors.white70),
              ))
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null ? defualtScreen() : uploadFromScreen();
  }
}
