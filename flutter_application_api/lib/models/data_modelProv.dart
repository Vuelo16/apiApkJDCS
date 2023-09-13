// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';


ProveedorModel dataModelFromJson(String str) => ProveedorModel.fromJson(json.decode(str));

String dataModelToJson(ProveedorModel data) => json.encode(data.toJson());

class ProveedorModel {
    ProveedorModel({
        required this.proveedors,
        // required this.total,
        // required this.skip,
        // required this.limit,
    });

    List<ProveedoresVali> proveedors;
    // int total;
    // int skip;
    // int limit;

    factory ProveedorModel.fromJson(Map<String, dynamic> json) => ProveedorModel(
        proveedors: List<ProveedoresVali>.from(json["proveedores"].map((x) => ProveedoresVali.fromJson(x))),
        // total: json["total"],
        // skip: json["skip"],
        // limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "proveedores": List<dynamic>.from(proveedors.map((x) => x.toJson())),
        // "total": total,
        // "skip": skip,
        // "limit": limit,
    };
}

class ProveedoresVali {
    ProveedoresVali({
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
    
    factory ProveedoresVali.fromJson(Map<String, dynamic> json) => ProveedoresVali(
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