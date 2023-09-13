// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';


DepartamentoModel dataModelFromJson(String str) => DepartamentoModel.fromJson(json.decode(str));

String dataModelToJson(DepartamentoModel data) => json.encode(data.toJson());

class DepartamentoModel {
    DepartamentoModel({
        required this.departamentos,
        // required this.total,
        // required this.skip,
        // required this.limit,
    });

    List<Departamentos> departamentos;
    // int total;
    // int skip;
    // int limit;

    factory DepartamentoModel.fromJson(List<dynamic> json) => DepartamentoModel(
        departamentos: List<Departamentos>.from(json.map((x) => Departamentos.fromJson(x))),
        // total: json["total"],
        // skip: json["skip"],
        // limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "departamentos": List<dynamic>.from(departamentos.map((x) => x.toJson())),
        // "total": total,
        // "skip": skip,
        // "limit": limit,
    };
}

class Departamentos {
    Departamentos({
        required this.id,
        required this.nombre,
        required this.nit,
        required this.email,
        required this.telefono,
        required this.categoria,
        required this.estado,
        
    });

    String id;
    String nombre;
    int nit;
    String email;
    int telefono;
    String categoria;
    bool estado;
    
    factory Departamentos.fromJson(Map<String, dynamic> json) => Departamentos(
        id: json["_id"],
        nombre: json["nombreProveedor"],
        nit: json["nit"],
        email: json["emailProv"],
        telefono: json["telefonoProv"],
        categoria: json["categoriaProv"],
        estado: json["estadoProv"],
        
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombreProveedor": nombre,
        "nit": nit,
        "emailProv": email,
        "telefonoProv": telefono,
        "categoriaProv": categoria,
        "estadoProv": estado,
        
    };
}