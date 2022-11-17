import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var document = FirebaseFirestore.instance.collection('SubmittedDetails');
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final arg = (ModalRoute.of(context)?.settings.arguments ??
        <dynamic, dynamic>{}) as Map;
    final data = arg['id'];

    List menuitem = [];
    Future<void> fireData() async {
      await document.doc(arg['path']).get().then((value) {
        menuitem.addAll(value.get('menuimages'));
      });
    }

    return Scaffold(
      floatingActionButton: (arg['location'] != null)
          ? FloatingActionButton.extended(
              onPressed: () {
                print(arg['path']);
                fireData();
              },
              label: Text('Get direction'),
              backgroundColor: Colors.blue,
              splashColor: Colors.yellow,
              foregroundColor: Colors.white,
              icon: Icon(Icons.place_rounded),
            )
          : null,
      body: FutureBuilder(
          future: fireData(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                ),
              );

            return ListView.builder(
                itemCount: menuitem.length,
                scrollDirection: Axis.horizontal,
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
                          child: Image.network(
                            menuitem[index],
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1,
                          ),
                        )),
                  );
                }));
          })),
    );
  }
}
