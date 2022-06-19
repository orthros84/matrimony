import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_final_2022/main.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../database/db_service.dart';
import '../model/userMeta.dart';
import 'AddScreen.dart';
import 'SearchScreen.dart';

class Favroite extends StatefulWidget {
  const Favroite({Key? key}) : super(key: key);

  @override
  State<Favroite> createState() => _FavroiteState();
}

class _FavroiteState extends State<Favroite> {
  DbService dbService = DbService();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favroite'),
        backgroundColor: const Color(0xFF9FA5D5),
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _fetchData(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: 2,
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

  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getfav(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> user) {
          if (user.hasData) {
            return _buildDataTable(user.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height - 156,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: user[index].toJson()["Gender"] as int == 1
                            ? const LinearGradient(
                                colors: [Color(0xFF9FA5D5), Color(0xFCFCF9FC)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : user[index].toJson()["Gender"] as int == 2
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFF9957F),
                                      Color(0xFCFCF9FC)
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
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddScreen(
                                isEditMode: true,
                                user: user[index],
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.black54,
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset(user[index]
                                                  .toJson()["Gender"] as int ==
                                              1
                                          ? "assets/image/man (2).png"
                                          : user[index].toJson()["Gender"]
                                                      as int ==
                                                  2
                                              ? "assets/image/woman(4).png"
                                              : "assets/image/user.png"),
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        user[index].toJson()['UserName'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: 'Gilroy-Semibold',
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
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          user[index].toJson()["DOB"],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            // color: Color.fromRGBO(
                                            //     255, 255, 255, 0.6),
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
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
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          (user[index].toJson()["Age"])
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
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
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                            user[index].toJson()["CountryName"],
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-Light',
                                              fontWeight: FontWeight.w400,
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
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                            user[index]
                                                .toJson()["CityName"]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-Light',
                                              fontWeight: FontWeight.w400,
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
  }
}
