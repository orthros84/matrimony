import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:snippet_coder_utils/list_helper.dart';

import '../database/database_helper.dart';
import '../database/db_service.dart';
import '../main.dart';
import '../model/userMeta.dart';
import 'AddScreen.dart';
import 'favroite.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController myController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  String a = "";
  late List<User> nb = [];

  void cont() async {
    setState(() {
      a = myController.text.trim();
    });
    if (a.isNotEmpty) {
      nb = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < nb.length; i++) {
          nb[i].toJson()["UserName"];
        }
      });
    }
  }

  void blank() async {
    setState(() {
      a = "1234";
    });
    if (a.isNotEmpty) {
      nb = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < nb.length; i++) {
          nb[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  dynamic getSearch() async {
    nb = await dbService.getSearch(a);
    setState(() {
      for (int i = 0; i < nb.length; i++) {
        nb[i].toJson()["UserName"];
      }
    });
  }

  DbService dbService = DbService();
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search User'),
        backgroundColor: const Color(0xFF9FA5D5),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (b) {
                    a = myController.text.trim();
                    if (a.isNotEmpty) {
                      cont();
                    } else {
                      blank();
                    }
                  },
                  controller: myController,
                  onEditingComplete: cont,
                  decoration: InputDecoration(
                    suffixIcon: myController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              myController.clear();
                              blank();
                            },
                          ),
                    border: InputBorder.none,
                    hintText: 'Type Anything',
                    contentPadding: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 6.0,
                      top: 6.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF9FA5D5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                _fetchData(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: 3,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddScreen()));
              },
            ),
            title: const Text("Add User"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.favorite_border),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Favroite()));
              },
            ),
            title: const Text("favroite"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.search),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
            ),
            title: const Text("Search"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  //
  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, nb) {
          if (nb.hasData) {
            return _buildDataTable(nb.data!);
          }
          return const Center(child: const CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return Container(
        height: 500,
        child: ListView.builder(
            itemCount: nb.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height - 90,
                child: ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 10,
                              // color: user[index].toJson()["Gender"] as int == 1
                              //     ? Color.fromRGBO(34, 33, 91, 1)
                              //     : Colors.pink,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                      user[index].toJson()["Gender"] as int == 1
                                          ? const LinearGradient(
                                              colors: [
                                                Color(0xFF9FA5D5),
                                                Color(0xFCFCF9FC)

                                                // Color(0xFFA0F1EA),
                                                // Color(0xFFEAD6EE),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : user[index].toJson()["Gender"]
                                                      as int ==
                                                  2
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color(0xFFF9957F),
                                                    Color(0xFCFCF9FC)

                                                    // Color(0xFFA0F1EA),
                                                    // Color(0xFFEAD6EE),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : const LinearGradient(
                                                  colors: [
                                                    Color(0xFF07A3B2),
                                                    Color(0xFCFCF9FC)

                                                    // Color(0xFFA0F1EA),
                                                    // Color(0xFFEAD6EE),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: Colors.black54,
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(user[index]
                                                                .toJson()[
                                                            "Gender"] as int ==
                                                        1
                                                    ? "assets/image/man (2).png"
                                                    : user[index].toJson()[
                                                                    "Gender"]
                                                                as int ==
                                                            2
                                                        ? "assets/image/woman(4).png"
                                                        : "assets/image/user.png"),
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 50,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  user[index]
                                                      .toJson()['UserName'],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'Gilroy-Semibold',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Date of birth : ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    user[index].toJson()["DOB"],
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      // color: Color.fromRGBO(
                                                      //     255, 255, 255, 0.6),
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Age :",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    (user[index]
                                                            .toJson()["Age"])
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Country: ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                      user[index].toJson()[
                                                          "CountryName"],
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        // color: Color.fromRGBO(
                                                        //     255, 255, 255, 0.6),
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "City :",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                      user[index]
                                                          .toJson()["CityName"]
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      );
                    }),
              );
            }));
  }
}
