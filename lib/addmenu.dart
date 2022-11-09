import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final name = TextEditingController();
  File? image;
  Future pickimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: show,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.19,
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            'https://images.cdn2.stockunlimited.net/preview1300/restaurant-logo-design_1797600.jpg',
                          ),
                  ),
                ),
              ],
            )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Add Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'SecularOne',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text('Name of the Restaurant'),
                            alignLabelWithHint: true,
                            hintText: 'Chicken Station',
                            suffixIcon: Icon(Icons.restaurant_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text('Address'),
                            alignLabelWithHint: true,
                            hintText: 'Kathmandu,Nepal',
                            suffixIcon: Icon(Icons.location_city_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: name,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            helperText: 'Google map link(optional)',
                            alignLabelWithHint: true,
                            labelText: 'Location',
                            suffixIcon: Icon(Icons.place_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.075,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'DelaGothic'),
                        ),
                        style: ElevatedButton.styleFrom(
                            enableFeedback: false,
                            elevation: 20,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void show() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text('Camera'),
                onTap: () => pickimage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.image_rounded),
                title: Text('Gallery'),
                onTap: () => pickimage(ImageSource.gallery),
              ),
            ],
          );
        }));
  }
}
