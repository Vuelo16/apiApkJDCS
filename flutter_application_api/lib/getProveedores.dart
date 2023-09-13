import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_api/models/data_modelProv.dart';
import 'package:flutter_application_api/postProveedores.dart';
import 'package:flutter_application_api/putProveedores.dart';
import 'package:http/http.dart' as http;

class ProveedorApi extends StatefulWidget {
  const ProveedorApi({Key? key}) : super(key: key);

  @override
  State<ProveedorApi> createState() => _ProveedorApiState();
}

class _ProveedorApiState extends State<ProveedorApi> {
  bool _isLoading = true;
  ProveedorModel? dataFromAPI;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _refreshPage() {
    setState(() {
      _isLoading = true;
    });
    _getData();
  }

  void _eliminarProveedor(String proveedorId) async {
    try {
      final response = await http.delete(
          Uri.parse('https://project-valisoft-2559218.onrender.com/api/proveedores'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"_id": proveedorId}));

      if (response.statusCode == 204) {
        setState(() {
          _getData();
        });
      } else {
        throw Exception('Error al eliminar el proveedor');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getData() async {
    try {
      String url = "https://project-valisoft-2559218.onrender.com/api/proveedores";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = ProveedorModel.fromJson(json.decode(res.body));
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
                  const Text(
                    "Proveedores",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Categoría')),
                        DataColumn(label: Text('NIT')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Teléfono')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: dataFromAPI!.proveedors.map((proveedor) {
                        return DataRow(cells: [
                          DataCell(Text(proveedor.nombre.toString())),
                          DataCell(Text(proveedor.categoria.toString())),
                          DataCell(Text(proveedor.nit.toString())),
                          DataCell(Text(proveedor.email.toString())),
                          DataCell(Text(proveedor.telefono.toString())),
                          DataCell(proveedor.estado == true
                              ? const Text("Activo")
                              : const Text("Inactivo")),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          editarProveedor(proveed: proveedor),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  _eliminarProveedor(proveedor.id);
                                  _refreshPage();
                                },
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                  )
              
                ],
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CrearProveedor()),
              );
            },
            backgroundColor: const Color.fromARGB(255, 101, 231, 151),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}