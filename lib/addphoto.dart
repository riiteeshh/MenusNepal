import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? image;
  bool check = false;
  List photo = [];
  Future pickimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        photo.add(imagetemp);
        check = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: check
            ? FloatingActionButton.extended(
                splashColor: Colors.yellow,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tabbar');
                },
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
                    itemCount: photo.length,
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
                                photo[index],
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

  void done() {}

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
