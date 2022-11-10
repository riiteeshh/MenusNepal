import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final DatabaseReference dbref =
      FirebaseDatabase.instance.ref().child('SubmittedDetails');
  final DatabaseReference dbref1 =
      FirebaseDatabase.instance.ref().child('SubmittedMenus');
  File? image;
  bool check = false;
  List uploadmenuitem = [];

  List showmenuitem = [];
  Future pickimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        showmenuitem.add(imagetemp);
        print(imagetemp);
        uploadmenuitem.add(image.path);

        check = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = (ModalRoute.of(context)?.settings.arguments ??
        <dynamic, dynamic>{}) as Map;
    void done() {
      Map<String, dynamic> data = {
        'name': arg['name'],
        'address': arg['address'],
        'location': arg['location'],
        'logo': arg['logo'],
        // 'img': up,
      };
      dbref.push().set(data);
      dbref1.push().set(uploadmenuitem);

      Navigator.pushNamed(context, '/tabbar');
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: check
            ? FloatingActionButton.extended(
                splashColor: Colors.yellow,
                onPressed: done,
                label: Text('Upload'),
                icon: Icon(Icons.upload_rounded),
              )
            : null,
        appBar: check
            ? AppBar(
                foregroundColor: Colors.blueGrey,
                elevation: 0,
                backgroundColor: Colors.yellow.withOpacity(0.4),
                actions: <Widget>[
                  Container(
                    child: IconButton(
                        onPressed: add, icon: Icon(Icons.add_a_photo_rounded)),
                  )
                ],
              )
            : AppBar(
                foregroundColor: Colors.blueGrey,
                elevation: 0,
                backgroundColor: Colors.yellow.withOpacity(0.4),
              ),
        backgroundColor: Colors.white,
        body: check
            ? Stack(
                children: <Widget>[
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: uploadmenuitem.length,
                    addAutomaticKeepAlives: true,
                    itemBuilder: ((context, index) {
                      return Container(
                        color: Colors.yellow.withOpacity(0.4),
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 1,
                        child: Card(
                            color: Colors.white.withOpacity(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              child: Image.file(
                                uploadmenuitem[index],
                                width: MediaQuery.of(context).size.width * 1,
                                height: MediaQuery.of(context).size.height * 1,
                              ),
                            )),
                      );
                    }),
                  ),
                ],
              )
            : Center(
                child: Container(
                    color: Colors.yellow.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.075,
                      child: ElevatedButton.icon(
                          onPressed: add,
                          style: ElevatedButton.styleFrom(
                              enableFeedback: false,
                              elevation: 20,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          icon: Icon(Icons.add_a_photo_rounded),
                          label: Text(
                            'AddPhoto',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    )),
              ),
      ),
    );
  }

  void add() {
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
}
