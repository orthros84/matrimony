import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_final_2022/screens/AddScreen.dart';
import 'package:matrimony_final_2022/screens/SearchScreen.dart';
import 'package:matrimony_final_2022/screens/ViewScreen.dart';
import 'package:matrimony_final_2022/screens/favroite.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'database/db_service.dart';
import 'model/userMeta.dart';
import 'package:favorite_button/favorite_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbService dbService = DbService();

  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF9FA5D5),
          title: const Center(
            child: Text(
              'Matrimony',
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            child: Column(
              children: [
                _fetchData(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: 0,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddScreen()));
                },
              ),
              title: const Text("Add User"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: GestureDetector(
                child: const Icon(Icons.favorite_border),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Favroite()));
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
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> user) {
          if (user.hasData) {
            return _buildDataTable(user.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      return !isLiked;
    }

    return Container(
      height: MediaQuery.of(context).size.height - 156,
      margin: const EdgeInsets.only(top: 10),
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
                                          "Gender : ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Gilroy-Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          user[index].Gender == 1
                                              ? ('Male').toString()
                                              : user[index].Gender == 2
                                                  ? ('Female').toString()
                                                  : ('Other').toString(),
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
                                              // color: Color.fromRGBO(
                                              //     255, 255, 255, 0.6),
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
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: FavoriteButton(
                                        iconSize: 45,
                                        isFavorite: user[index].IsFavorite == 1
                                            ? true
                                            : false,
                                        valueChanged: (favbutton) {
                                          print(user[index].id);

                                          if (favbutton == true) {
                                            dbService.setFav(
                                                1,
                                                int.parse(
                                                    user[index].id.toString()));
                                          }
                                          if (favbutton == false) {
                                            dbService.setFav(
                                                0,
                                                int.parse(
                                                    user[index].id.toString()));
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScreen(
                                                    isEditMode: true,
                                                    user: user[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              dbService
                                                  .deleteUser(user[index])
                                                  .then(
                                                (value) {
                                                  setState(() {
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyHomePage()));
                                                  });
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
