import 'package:matrimony_final_2022/model/Meta.dart';

const String userTable = 'userTable';
const String cityTable = 'cityTable';
const String countryTable = 'countryTable';
const String stateTable = 'stateTable';

class UserFields {
  static const String id = 'id';
  static const String UserName = 'UserName';
  static const String DOB = 'DOB';
  static const String Age = 'Age';
  static const String Gender = 'Gender';
  static const String MobileNumber = 'MobileNumber';
  static const String Email = 'Email';
  static const String CityName = 'CityName';
  static const String IsFavorite = 'IsFavorite';
  static const String StateName = 'StateName';
  static const String CountryName = 'CountryName';
//  static final String Hobbies = '_Hobbies';
}

class User extends Meta {
  late int? id;
  late String UserName;
  late String DOB;
  late int Age;
  late int Gender;
  late String? MobileNumber;
  late String? Email;
  late int? IsFavorite;
  late String CityName;
  late String CountryName;
  late String StateName;

  User(
      {this.id,
      required this.UserName,
      required this.DOB,
      required this.Age,
      required this.Gender,
      this.MobileNumber,
      this.Email,
      required this.IsFavorite,
      required this.CityName,
      required this.StateName,
      required this.CountryName}

      // this.Hobbies
      );

  static User fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      UserName: json['UserName'].toString(),
      DOB: json['DOB'].toString(),
      Age: json['Age'],
      Gender: json['Gender'],
      MobileNumber: json['MobileNumber'].toString(),
      Email: json['Email'].toString(),
      IsFavorite: json['IsFavorite'],
      CityName: json['CityName'],
      StateName: json['StateName'],
      CountryName: json['CountryName'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'UserName': UserName,
      'DOB': DOB,
      'Age': Age,
      'Gender': Gender,
      'MobileNumber': MobileNumber,
      'Email': Email,
      'CityName': CityName,
      'StateName': StateName,
      'CountryName': CountryName,
      'IsFavorite': IsFavorite,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
