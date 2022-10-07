import 'dart:convert';

class MyArrayBuffer {
  String? barcode;
  String? time;

  MyArrayBuffer({this.barcode, this.time});

  factory MyArrayBuffer.fromJson(Map<String, dynamic> jsonData) {
    return MyArrayBuffer(barcode: jsonData['barcode'], time: jsonData['time']);
  }

  static Map<String, dynamic> toMap(MyArrayBuffer myArr) => {
        'barcode': myArr.barcode,
        'time': myArr.time,
      };

  static String encode(List<MyArrayBuffer> myArr) => json.encode(
        myArr
            .map<Map<String, dynamic>>((music) => MyArrayBuffer.toMap(music))
            .toList(),
      );

  static List<MyArrayBuffer> decode(String myArr) =>
      (json.decode(myArr) as List<dynamic>)
          .map<MyArrayBuffer>((item) => MyArrayBuffer.fromJson(item))
          .toList();
}

class User {
  String? username;
  String? password;

  User({this.username, this.password});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(username: jsonData['username'], password: jsonData['password']);
  }
}

class VersionControl {
  String? version;

  VersionControl({this.version});

  factory VersionControl.fromJson(Map<String, dynamic> jsonData) {
    return VersionControl(version: jsonData['version']);
  }
}

class LinkReceive {
  String? username;
  String? password;

  LinkReceive({this.username, this.password});

  factory LinkReceive.fromJson(Map<String, dynamic> jsonData) {
    return LinkReceive(
        username: jsonData['username'], password: jsonData['password']);
  }
}

class BarCodeControl {
  String? barcode;
  String? date;
  String? location;
  String? machineId;
  String? documentId;

  BarCodeControl(
      {this.barcode,
      this.date,
      this.location,
      this.machineId,
      this.documentId});

  factory BarCodeControl.fromJson(Map<String, dynamic> jsonData) {
    return BarCodeControl(
        barcode: jsonData['barcode'],
        date: jsonData['date'],
        location: jsonData['location'],
        machineId: jsonData['machineId'],
        documentId: jsonData['documentId']);
  }
}
