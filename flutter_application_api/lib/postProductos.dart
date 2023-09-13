import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Product> createProducto(String nombreProd, String descripcion, String categoria, String stock, String stock_min, String valor_uni, String estadoProd) async {
  final response = await http.post(
    Uri.parse('https://entregable-node-back.onrender.com/api/producto'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "nombreProd": nombreProd,
      "descripcion": descripcion,
      "categoria": categoria,
      "stock": stock,
      "stock_min": stock_min,
      "valor_uni": valor_uni,
      "estadoProd": estadoProd,
    }),
  );

  if (response.statusCode == 201) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

class Product {
  final String id;
  final String nombreProd;
  final String descripcion;
  final String categoria;
  final String stock;
  final String stock_min;
  final double valor_uni;
  final bool estadoProd;

  const Product({
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
      nombreProd: json["nombreProd"],
      descripcion: json["descripcion"],
      categoria: json["categoria"],
      stock: json["stock"],
      stock_min: json["stock_min"],
      valor_uni: json["valor_uni"]?.toDouble() ?? 0.0,
      estadoProd: json["estadoProd"],
    );
  }
}

void main() {
  runApp(const CrearProducto());
}

class CrearProducto extends StatefulWidget {
  const CrearProducto({super.key});

  @override
  State<CrearProducto> createState() {
    return _CrearProductoState();
  }
}

class _CrearProductoState extends State<CrearProducto> {
  final TextEditingController _nombreProd = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _stock_min = TextEditingController();
  final TextEditingController _valor_uni = TextEditingController();
  final TextEditingController _estadoProd = TextEditingController();
  Future<Product>? _futureProduct;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crear Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _nombreProd,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _descripcion,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _categoria,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _stock,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _stock_min,
                  decoration: const InputDecoration(
                    labelText: 'Stock Minimo',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _valor_uni,
                  decoration: const InputDecoration(
                    labelText: 'Valor unitario',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),

                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _estadoProd,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    suffixIcon: Icon(Icons.check_box_outlined),
                    icon: Icon(Icons.input),
                  ),
                  onChanged: (value) {
                    print('value: $value');
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _futureProduct = createProducto(
                        _nombreProd.text,
                        _descripcion.text,
                        _categoria.text,
                        _stock.text,
                        _stock_min.text,
                        _valor_uni.text,
                        _estadoProd.text,
                      );
                    });
                  },
                  style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
                  child: const Text('Crear Producto'),
                ),
        
                const SizedBox(height: 16),
                FutureBuilder<Product>(
                  future: _futureProduct,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text('Producto creado: ${snapshot.data!.nombreProd}');
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                // Add a button to go back to the table
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigate back to the previous screen
                  },
                  style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
                  child: const Text('Volver a la tabla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}