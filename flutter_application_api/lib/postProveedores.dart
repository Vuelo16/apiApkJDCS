import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CrearProveedor());
}

class CrearProveedor extends StatefulWidget {
  const CrearProveedor({super.key});

  @override
  State<CrearProveedor> createState() {
    return _CrearProveedorState();
  }
}

class _CrearProveedorState extends State<CrearProveedor> {
  final TextEditingController _nombreProveedor = TextEditingController();
  final TextEditingController _nit = TextEditingController();
  final TextEditingController _emailProv = TextEditingController();
  final TextEditingController _telefonoProv = TextEditingController();
  final TextEditingController _categoriaProv = TextEditingController();
  final TextEditingController _estadoProv = TextEditingController();

  Future<Proveed>? _futureProveed;

  Future<Proveed> createProveedor(String nombreProveedor, String nit, String emailProv, String telefonoProv, String categoriaProv, String estadoProv) async {
    final response = await http.post(
      Uri.parse('https://project-valisoft-2559218.onrender.com/api/proveedores'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "nombreProveedor": nombreProveedor,
        "nit": nit,
        "emailProv": emailProv,
        "telefonoProv": telefonoProv,
        "categoriaProv": categoriaProv,
        "estadoProv": estadoProv,
      }),
    );

    if (response.statusCode == 201) {
      return Proveed.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

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
          controller: _nombreProveedor,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _categoriaProv,
          decoration: const InputDecoration(
            labelText: 'Categoria',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _nit,
          decoration: const InputDecoration(
            labelText: 'Nit',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _emailProv,
          decoration: const InputDecoration(
            labelText: 'Correo electronico',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _telefonoProv,
          decoration: const InputDecoration(
            labelText: 'Telefono',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _estadoProv,
          decoration: const InputDecoration(
            labelText: 'Estado',
            suffixIcon: Icon(Icons.check_box_outlined),
            icon: Icon(Icons.input),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureProveed = createProveedor(
                _nombreProveedor.text,
                _nit.text,
                _emailProv.text,
                _telefonoProv.text,
                _categoriaProv.text,
                _estadoProv.text,
              );
            });
          },
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
          child: const Text('Crear proveedor'),
        ),
          const SizedBox(height: 16),
          FutureBuilder<Proveed>(
            future: _futureProveed,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Text('Proveedor creado: ${snapshot.data!.nombreProveedor}');
              } else {
                  return const SizedBox.shrink();
              }
            },
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
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

class Proveed {
  final String id;
  final String nombreProveedor;
  final int nit;
  final String emailProv;
  final int telefonoProv;
  final String categoriaProv;
  final bool estadoProv;

  Proveed({
    required this.id,
    required this.nombreProveedor,
    required this.nit,
    required this.emailProv,
    required this.telefonoProv,
    required this.categoriaProv,
    required this.estadoProv,
  });

  factory Proveed.fromJson(Map<String, dynamic> json) {
    return Proveed(
      id: json["_id"],
      nombreProveedor: json["nombreProveedor"],
      nit: json["nit"],
      emailProv: json["emailProv"],
      telefonoProv: json["telefonoProv"],
      categoriaProv: json["categoriaProv"],
      estadoProv: json["estadoProv"],
    );
  }
}