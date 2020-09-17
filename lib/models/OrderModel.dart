// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
    String id;
    String bookname;
    String authorname;
    String libraryid;
    int countdays;
    String userid;
    String date01;
    String date02;

    Order({
        this.id,
        this.bookname,
        this.authorname,
        this.libraryid,
        this.countdays,
        this.userid,
        this.date01,
        this.date02,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        bookname: json["bookname"],
        authorname: json["authorname"],
        libraryid: json["libraryid"],
        countdays: json["countdays"],
        userid: json["userid"],
        date01: json["date01"],
        date02: json["date02"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bookname": bookname,
        "authorname": authorname,
        "libraryid": libraryid,
        "countdays": countdays,
        "userid": userid,
        "date01": date01,
        "date02": date02,
    };
}
