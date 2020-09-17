// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    String id;
    String categoryname;
    String libraryid;
    String password;
    int numofbooks;
    String description;

    Category({
        this.id,
        this.categoryname,
        this.libraryid,
        this.password,
        this.numofbooks,
        this.description,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryname: json["categoryname"],
        libraryid: json["libraryid"],
        password: json["password"],
        numofbooks: json["numofbooks"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryname": categoryname,
        "libraryid": libraryid,
        "password": password,
        "numofbooks": numofbooks,
        "description": description,
    };
}
