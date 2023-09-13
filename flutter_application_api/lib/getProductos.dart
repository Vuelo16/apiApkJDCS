import 'package:flutter/material.dart';
import 'package:flutter_application_api/postProductos.dart';
import 'package:flutter_application_api/putProductos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  DataModel? dataFromAPI;

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

  void _eliminarProducto(String productoId) async {
    try {
      final response = await http.delete(
          Uri.parse('https://entregable-node-back.onrender.com/api/producto'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"_id": productoId}));

      if (response.statusCode == 204) {
        setState(() {
          _getData();
        });
      } else {
        throw Exception('Error al eliminar el producto');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getData() async {
    try {
      String url = "https://entregable-node-back.onrender.com/api/producto";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModel.fromJson(json.decode(res.body));
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
                      "Productos",
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
                        DataColumn(label: Text('Descripción')),
                        DataColumn(label: Text('Categoría')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Stock Mínimo')),
                        DataColumn(label: Text('Valor Unitario')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: dataFromAPI!.products.map((product) {
                        return DataRow(cells: [
                          DataCell(Text(product.nombreProd.toString())),
                          DataCell(Text(product.descripcion.toString())),
                          DataCell(Text(product.categoria.toString())),
                          DataCell(Text(product.stock.toString())),
                          DataCell(Text(product.stock_min.toString())),
                          DataCell(Text("\$${product.valor_uni.toStringAsFixed(2)}")),
                          DataCell(product.estadoProd == true
                              ? const Text("Activo")
                              : const Text("Inactivo")),
                          DataCell(Row(children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditarProducto(producto: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                _eliminarProducto(product.id);
                                _refreshPage();
                              },
                            ),
                          ])),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CrearProducto()),
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

class DataModel {
  final List<Product> products;

  DataModel({required this.products});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    var productsList = json['productos'] as List;
    List<Product> products =
        productsList.map((product) => Product.fromJson(product)).toList();
    return DataModel(products: products);
  }
}

class Product {
  final String id;
  final String nombreProd;
  final String descripcion;
  final String categoria;
  final int stock;
  final int stock_min;
  final double valor_uni;
  final bool estadoProd;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      nombreProd: json['nombreProd'],
      descripcion: json['descripcion'],
      categoria: json['categoria'],
      stock: json['stock'],
      stock_min: json['stock_min'],
      valor_uni: json['valor_uni'].toDouble(),
      estadoProd: json['estadoProd'],
    );
  }
}