import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:menunepal/newmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchfield = TextEditingController();

  static List<NewMenu> newmenu = [
    NewMenu(
        name: 'ChickenStation',
        location: 'Kathmandu,Nepal',
        fav: false,
        logo:
            'https://images.foodmandu.com//Images/Vendor/1277/OriginalSize/WhatsApp_Image_2021-12-06_at_12_061221064914.09.22.jpeg'),
    NewMenu(
        name: 'The Burger House And The Crunchy Corner',
        location: 'Lalitpur,Nepal',
        fav: false,
        logo:
            'https://media-cdn.tripadvisor.com/media/photo-s/11/44/e8/e9/the-burger-house-and.jpg'),
    NewMenu(
        name: 'KFC Nepal',
        location: 'Thapathali,Nepal',
        fav: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/en/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png'),
    NewMenu(
        name: 'Michael Grills',
        location: 'Mid-Baneshwor,Nepal',
        fav: false,
        logo: 'https://menu.nepvent.com/storage/logo/michaelgrills.jpg'),
    NewMenu(
        name: 'KKFC Nepal',
        location: 'Sundhara,Nepal',
        fav: false,
        logo:
            'https://play-lh.googleusercontent.com/hlx7U2aHkexuQbIV1Xz3en_bW-p3HLVnlDN8K7Anyfv9ZQhCC27EO8vaq04s_z-r6vxT'),
  ];

  void datas(String name, String location, bool fav, String logo) {
    final newm = NewMenu(name: name, location: location, fav: fav, logo: logo);

    setState(() {
      newmenu.add(newm);
    });
  }

  List<NewMenu> display_list = List.from(newmenu);
  void updatelist(String value) {
    setState(() {
      display_list = newmenu
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
              onChanged: (value) => updatelist(value),
              textInputAction: TextInputAction.search,
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
              childAspectRatio: 0.545,
            ),
            itemCount: display_list.length,
            itemBuilder: ((context, index) {
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
                                chg(index);
                              },
                              icon: Icon(Icons.favorite_rounded),
                              splashColor: display_list[index].fav
                                  ? Colors.black.withOpacity(0.2)
                                  : Colors.red,
                              color: display_list[index].fav
                                  ? Colors.red
                                  : Colors.black.withOpacity(0.2),
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Image.network(display_list[index].logo),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 15, left: 10, right: 10),
                          width: double.infinity,
                          child: Text(
                            display_list[index].name,
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
                            display_list[index].location,
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void chg(int index) {
    setState(() {
      newmenu[index].fav = !newmenu[index].fav;
      print(newmenu[index].fav);
      print(index);
    });
  }
}
