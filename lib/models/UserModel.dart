// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String id;
    String email;
    String name;
    String password;
    String role;
    String mnumber;
    String lid;
    String address;
    String nic;
    String gender;

    User({
        this.id,
        this.email,
        this.name,
        this.password,
        this.role,
        this.mnumber,
        this.lid,
        this.address,
        this.nic,
        this.gender,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        role: json["role"],
        mnumber: json["mnumber"],
        lid: json["lid"],
        address: json["address"],
        nic: json["nic"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "password": password,
        "role": role,
        "mnumber": mnumber,
        "lid": lid,
        "address": address,
        "nic": nic,
        "gender": gender,
    };
}
