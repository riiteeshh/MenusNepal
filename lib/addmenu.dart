import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
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
  final address = TextEditingController();
  final location = TextEditingController();
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
              child: Container(
                width: 180,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: show,
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: image != null
                              ? Image.file(
                                  image!,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Center(
                                  child: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 100,
                                  color: Colors.blue,
                                )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                        width: double.infinity,
                        child: Text(
                          name.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SecularOne',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          address.text,
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                        onFieldSubmitted: (value) => setState(() {
                          name.text = value;
                        }),
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
                        controller: address,
                        onFieldSubmitted: (value1) => setState(() {
                          address.text = value1;
                        }),
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
                        keyboardType: TextInputType.url,
                        controller: location,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.075,
                          child: ElevatedButton.icon(
                            onPressed: clear,
                            icon: Icon(Icons.clear),
                            label: Text(
                              'ClearAll',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'DelaGothic'),
                            ),
                            style: ElevatedButton.styleFrom(
                                enableFeedback: false,
                                elevation: 20,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 15),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.075,
                          child: ElevatedButton.icon(
                            onPressed: submit,
                            icon: Icon(Icons.add_a_photo_rounded),
                            label: Text(
                              'AddPhoto',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'DelaGothic'),
                            ),
                            style: ElevatedButton.styleFrom(
                                enableFeedback: false,
                                elevation: 20,
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ],
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
                onTap: () {
                  pickimage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image_rounded),
                title: Text('Gallery'),
                onTap: () {
                  pickimage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }));
  }

  void submit() {
    Navigator.pushNamed(context, '/addphoto', arguments: {
      'name': name.text.toUpperCase(),
      'address': address.text.toUpperCase(),
      'location': location.text,
      'logo': image!.path
    });
  }

  void clear() {
    setState(() {
      name.clear();
      address.clear();
      location.clear();
      image = null;
    });
  }
}
