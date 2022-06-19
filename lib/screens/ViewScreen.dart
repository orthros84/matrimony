import 'package:flutter/material.dart';
import 'package:matrimony_final_2022/database/db_service.dart';
import 'package:matrimony_final_2022/screens/AddScreen.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';

import '../model/userMeta.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  DbService dbService = DbService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: Color.fromRGBO(34, 33, 91, 1),
                    ),
                  ),
                  Text(
                    "View Details",
                    style: TextStyle(
                      color: Color.fromRGBO(34, 33, 91, 1),
                      fontSize: 16,
                      fontFamily: 'Gilroy-Semibold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Color.fromRGBO(34, 33, 91, 1),
                  )
                ],
              ),
            ),
            _fetchData(),
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
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return ListUtils.buildDataTable(
        context,
        [
          "UserName",
          "DOB",
          "Age",
          "Gender",
          "MobileNumber",
          "Email",
          "IsFavorite",
          "CountryName",
          "StateName",
          "CityName",
          ""
        ],
        [
          "UserName",
          "DOB",
          "Age",
          "Gender",
          "MobileNumber",
          "Email",
          "IsFavorite",
          "CountryName",
          "StateName",
          "CityName",
          ""
        ],
        false,
        0,
        user, (User data) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddScreen(
                    isEditMode: true,
                    user: data,
                  )));
    }, (User data) {
      return showDialog(
          context: context,
          builder: (BuildContext contex) {
            return AlertDialog(
              title: Text("Delete"),
              content: Text("Do you want to delete this record"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        dbService.deleteUser(data).then(
                          (value) {
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                        );
                      },
                      child: Text("Delete"),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No"),
                    )
                  ],
                )
              ],
            );
          });
    },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
        columnTextFontSize: 15,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columName, asc) {});
  }
}
