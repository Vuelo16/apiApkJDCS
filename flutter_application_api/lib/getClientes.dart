import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ClientesAPi extends StatefulWidget {
  const ClientesAPi({Key? key}) : super(key: key);

  @override
  State<ClientesAPi> createState() => _ClientesAPiState();
}

class _ClientesAPiState extends State<ClientesAPi> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ClienteModel? dataFromAPI;

  _getData() async {
    try {
      String url = "https://proyectonodejsbackend.onrender.com/api/cliente";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = ClienteModel.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Clientes",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Cédula')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Teléfono')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Acciones'))
                      ],
                      rows: dataFromAPI!.clients.map((cliente) {
                        return DataRow(cells: [
                          DataCell(Text(cliente.nombre)),
                          DataCell(Text(cliente.cedula.toString())),
                          DataCell(Text(cliente.email)),
                          DataCell(Text(cliente.telefono.toString())),
                          DataCell(Text(cliente.estado.toString())),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {},
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
                ],
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 101, 231, 151),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
 
ClienteModel dataModelFromJson(String str) => ClienteModel.fromJson(json.decode(str));

String dataModelToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
    ClienteModel({
        required this.clients,
        
    });

    List<ClientesValicor> clients;
  

    factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        clients: List<ClientesValicor>.from(json["clientes"].map((x) => ClientesValicor.fromJson(x))),
       
    );

    Map<String, dynamic> toJson() => {
        "clientes": List<dynamic>.from(clients.map((x) => x.toJson())),
        
    };
}

class ClientesValicor {
    ClientesValicor({
        required this.id,
        required this.nombre,
        required this.cedula,
        required this.email,
        required this.telefono,
        required this.estado,
        
    });

    String id;
    String nombre;
    int cedula;
    String email;
    int telefono;
    bool estado;

    factory ClientesValicor.fromJson(Map<String, dynamic> json) => ClientesValicor(
        id: json["_id"],
        nombre: json["nombre"],
        cedula: json["cedula"],
        email: json["email"],
        telefono: json["telefono"],
        estado: json["estado"],
        
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombreProd": nombre,
        "cedula": cedula,
        "email": email,
        "telefono": telefono,
        "estado": estado,
        
    };
}