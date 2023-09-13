import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'getProductos.dart'; // Make sure to import this if it's required

class EditarProducto extends StatefulWidget {
  final Product producto;

  const EditarProducto({Key? key, required this.producto}) : super(key: key);

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  final TextEditingController _nombreProd = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _stock_min = TextEditingController();
  final TextEditingController _valor_uni = TextEditingController();
  final TextEditingController _estadoProd = TextEditingController();

  Future<Product>? _futureProduct;

  @override
  void initState() {
    super.initState();
    _nombreProd.text = widget.producto.nombreProd;
    _descripcion.text = widget.producto.descripcion;
    _categoria.text = widget.producto.categoria;
    _stock.text = widget.producto.stock.toString();
    _stock_min.text = widget.producto.stock_min.toString();
    _valor_uni.text = widget.producto.valor_uni.toString();
    _estadoProd.text = widget.producto.estadoProd.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Editar Proveedores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: (_futureProduct == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Scaffold buildColumn() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _futureProduct = actualizarProducto(
                      widget.producto.id,
                      _nombreProd.text,
                      _descripcion.text,
                      _categoria.text,
                      _stock.text,
                      _stock_min.text,
                      _valor_uni.text,
                      _estadoProd.text,
                    );
                  });
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
                child: const Text('Editar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Product> buildFutureBuilder() {
    return FutureBuilder<Product>(
      future: _futureProduct!,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombreProd);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<Product> actualizarProducto(
    String id,
    String nuevoNombreProd,
    String nuevaDescripcion,
    String nuevaCategoria,
    String nuevoStock,
    String nuevoStockMin,
    String nuevoValorUni,
    String nuevoEstadoProd,
    ) async {
  final response = await http.put(
    Uri.parse('https://entregable-node-back.onrender.com/api/producto/'), // Provide the correct URL with the product ID
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      '_id': id,
      'nombreProd': nuevoNombreProd,
      'descripcion': nuevaDescripcion,
      'categoria': nuevaCategoria,
      'stock': nuevoStock,
      'stock_min': nuevoStockMin,
      'valor_uni': nuevoValorUni,
      'estadoProd': nuevoEstadoProd,
    }),
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}