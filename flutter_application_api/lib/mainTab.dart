import 'package:flutter/material.dart';
import 'package:flutter_application_api/getClientes.dart';
import 'package:flutter_application_api/getProductos.dart';
import 'package:flutter_application_api/getProveedores.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 101, 231, 151),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Productos'),
                Tab(text: 'Proveedores'),
                Tab(text: 'Clientes'),
              ],
            ),
            title: const Text('Bienvenido a Valicor'),
          ),
          body: const Column(
            children: [
            
              Expanded(
                child: TabBarView(
                  children: [
                    Home(),
                    ProveedorApi(),
                    ClientesAPi()
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