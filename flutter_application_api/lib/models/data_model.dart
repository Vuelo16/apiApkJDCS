// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    DataModel({
        required this.products,
        // required this.total,
        // required this.skip,
        // required this.limit,
    });

    List<Product> products;
    // int total;
    // int skip;
    // int limit;

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        products: List<Product>.from(json["productos"].map((x) => Product.fromJson(x))),
        // total: json["total"],
        // skip: json["skip"],
        // limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "productos": List<dynamic>.from(products.map((x) => x.toJson())),
        // "total": total,
        // "skip": skip,
        // "limit": limit,
    };
}

class Product {
    Product({
        required this.id,
        required this.nombreProd,
        required this.descripcion,
        required this.categoria,
        required this.stock,
        required this.stock_min,
        required this.valor_uni,
        required this.estadoProd,
    });

    String id;
    String nombreProd;
    String descripcion;
    String categoria;
    int stock;
    int stock_min;
    double valor_uni;
    bool estadoProd;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        nombreProd: json["nombreProd"],
        descripcion: json["descripcion"],
        categoria: json["categoria"],
        stock: json["stock"],
        stock_min: json["stock_min"],
        valor_uni: json["valor_uni"]?.toDouble(),
        estadoProd: json["estadoProd"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombreProd": nombreProd,
        "descripcion": descripcion,
        "categoria": categoria,
        "stock": stock,
        "stock_min": stock_min,
        "valor_uni": valor_uni,
        "estadoProd": estadoProd,
    };
}