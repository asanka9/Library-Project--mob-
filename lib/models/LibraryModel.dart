// To parse this JSON data, do
//
//     final library = libraryFromJson(jsonString);

import 'dart:convert';

Library libraryFromJson(String str) => Library.fromJson(json.decode(str));

String libraryToJson(Library data) => json.encode(data.toJson());

class Library {
    String id;
    String name;
    String address;
    String googlelocation;
    String email;
    String tel;

    Library({
        this.id,
        this.name,
        this.address,
        this.googlelocation,
        this.email,
        this.tel,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        googlelocation: json["googlelocation"],
        email: json["email"],
        tel: json["tel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "googlelocation": googlelocation,
        "email": email,
        "tel": tel,
    };
}
