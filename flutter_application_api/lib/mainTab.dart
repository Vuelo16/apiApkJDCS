import 'package:flutter/material.dart';
import 'package:flutter_application_api/camara.dart';
import 'package:flutter_application_api/getClientes.dart';
import 'package:flutter_application_api/getProductos.dart';
import 'package:flutter_application_api/getProveedores.dart';


class MainTab extends StatelessWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 101, 231, 151),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Productos'),
                Tab(text: 'Proveedores'),
                Tab(text: 'Clientes'),
              ],
            ),
            title: const Text('Bienvenido a Valicor'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 101, 231, 151)),
                ),
                child: const Text('Abrir Cámara'), // Cambia el texto según lo necesites
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Home(),                    
                    ProveedorApi(),
                    ClientesAPi(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}