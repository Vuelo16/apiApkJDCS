import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_api/models/data_modelProv.dart';
import 'package:http/http.dart' as http;

final Color formBackgroundColor = Colors.grey[200]!;
const Color formLabelColor = Colors.black;
const Color formHintColor = Colors.grey;
const Color formButtonColor = Colors.deepPurpleAccent;

Future<Proveed> updateProveedor(String id, String nombreProveedor, String nit, String emailProv, String telefonoProv, String categoriaProv, String estadoProv) async {
  final response = await http.put(
    Uri.parse('https://project-valisoft-2559218.onrender.com/api/proveedores'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
       "_id": id,
      "nombreProveedor": nombreProveedor,
      "nit": int.parse(nit),
      "emailProv": emailProv,
      "telefonoProv": int.parse(telefonoProv),
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

class Proveed{
  final String id;
  final String nombreProveedor;
  final int nit;
  final String emailProv;
  final int telefonoProv;
  final String categoriaProv;
  final bool estadoProv;

  const Proveed({
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



class editarProveedor extends StatefulWidget {
  final ProveedoresVali proveed;

  const editarProveedor({required this.proveed, Key? key}) : super(key: key);

  @override
  State<editarProveedor> createState() {
    return _editarProveedorState();
  }
}

class _editarProveedorState extends State<editarProveedor> {
  final TextEditingController _nombreProveedor = TextEditingController();
  final TextEditingController _nit = TextEditingController();
  final TextEditingController _emailProv = TextEditingController();
  final TextEditingController _telefonoProv = TextEditingController();
  final TextEditingController _categoriaProv = TextEditingController();
  final TextEditingController _estadoProv = TextEditingController();

  Future<Proveed>? _futureProveed;

  @override
  void initState() {
    super.initState();
    _nombreProveedor.text = widget.proveed.nombre;
    _categoriaProv.text = widget.proveed.categoria;
    _nit.text = widget.proveed.nit.toString();
    _emailProv.text = widget.proveed.email;
    _telefonoProv.text = widget.proveed.telefono.toString();
    _estadoProv.text = widget.proveed.estado.toString();
  }

 Proveed? dataFromAPI;


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
          child: (_futureProveed == null) ? buildColumn() : buildFutureBuilder(),
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
      controller: _nombreProveedor,
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
      controller: _categoriaProv,
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
      controller: _nit,
      decoration: const InputDecoration(
        labelText: 'Nit',
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
      controller: _emailProv,
      decoration: const InputDecoration(
        labelText: 'Correo electronico',
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
      controller: _telefonoProv,
      decoration: const InputDecoration(
        labelText: 'Telefono',
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
      controller: _estadoProv,
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
              _futureProveed = updateProveedor(widget.proveed.id,_nombreProveedor.text,_nit.text,_emailProv.text,_telefonoProv.text,_categoriaProv.text,_estadoProv.text,
              );
            });
             Navigator.pop(context);

          },
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
          child: const Text('Actualizar'),
        ),
      ],
          ),
        ),
       ),
    );
  }


  FutureBuilder<Proveed> buildFutureBuilder() {
    return FutureBuilder<Proveed>(
      future: _futureProveed,
      builder: (context, snapshot) {         
          if (snapshot.hasData) {
            return Text(snapshot.data!.nombreProveedor);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
        
        return const CircularProgressIndicator();
      },
    );
  }
}
