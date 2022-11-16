import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menunepal/newmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchfield = TextEditingController();
  String search = '';

  var document = FirebaseFirestore.instance.collection('SubmittedDetails');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              controller: searchfield,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: ((value) {
                setState(() {
                  searchfield.text = value;
                  search = searchfield.text;
                });
              }),
              decoration: InputDecoration(
                  hintText: 'Search the Restaurants',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: (BorderSide(
                        width: 1.0, color: Colors.yellow.withOpacity(0.4))),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: (BorderSide(width: 1.0, color: Colors.white)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          search = searchfield.text;
                          print(search);
                        });
                      },
                      icon: Icon(Icons.search_rounded))),
            ),
          ),
          backgroundColor: Colors.yellow.withOpacity(0.1),
          elevation: 0,
        ),
        backgroundColor: Colors.yellow.withOpacity(0.4),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/addmenu');
          },
          label: Text(
            'AddMenu',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          icon: Icon(Icons.add),
          splashColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
              stream: (search.isNotEmpty)
                  ? document
                      .where("name", isEqualTo: search.toUpperCase())
                      .snapshots()
                  : document.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.545,
                    ),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];

                      return InkWell(
                        enableFeedback: false,
                        onTap: () => Navigator.pushNamed(context, '/menupage',
                            arguments: {'index': index.toString()}),
                        splashColor: Colors.redAccent,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(5),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.all(7),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.place_rounded,
                                      size: 26,
                                    ),
                                    splashColor: Colors.red,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  width: double.infinity,
                                  alignment: Alignment.topCenter,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  child:
                                      Image.network(documentSnapshot['logo']),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  width: double.infinity,
                                  child: Text(
                                    documentSnapshot['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'SecularOne',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    documentSnapshot['address'],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
              }),
        ),
      ),
    );
  }
}
