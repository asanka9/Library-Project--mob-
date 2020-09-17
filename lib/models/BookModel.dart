// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    String id;
    String bookcode;
    String name;
    String authorname;
    String blocation;
    double price;
    String categoryid;
    String libraryid;
    String borrowed;

    Book({
        this.id,
        this.bookcode,
        this.name,
        this.authorname,
        this.blocation,
        this.price,
        this.categoryid,
        this.libraryid,
        this.borrowed,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        bookcode: json["bookcode"],
        name: json["name"],
        authorname: json["authorname"],
        blocation: json["blocation"],
        price: json["price"],
        categoryid: json["categoryid"],
        libraryid: json["libraryid"],
        borrowed: json["borrowed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bookcode": bookcode,
        "name": name,
        "authorname": authorname,
        "blocation": blocation,
        "price": price,
        "categoryid": categoryid,
        "libraryid": libraryid,
        "borrowed": borrowed,
    };
}
