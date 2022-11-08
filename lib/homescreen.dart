import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchfield = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: searchfield,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: 'Search the Restaurants',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
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
                      onPressed: () {}, icon: Icon(Icons.search_rounded))),
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
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.565,
            ),
            itemCount: 5,
            itemBuilder: ((context, index) {
              return Container(
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
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Image.network(
                            'https://images.foodmandu.com//Images/Vendor/1277/OriginalSize/WhatsApp_Image_2021-12-06_at_12_061221064914.09.22.jpeg'),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: double.infinity,
                        child: Text(
                          'The Burger House And The Crunchy Corner',
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
                          'Kathmandu,Nepal',
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
