import 'package:matrimony_final_2022/model/Meta.dart';

final String cityTable = 'cityTable';

class CityFields {
  static final String CityId = 'CityId';

  static final String CityName = 'CityName';
}

class City extends Meta {
  late int? id;
  late String CityName;

  City({
    this.id,
  }

      // this.Hobbies
      );

  static City fromMap(Map<String, dynamic> json) {
    return City(
      id: json['id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

class StateDetails extends Meta {}

class Country extends Meta {}
