import 'package:flutter/material.dart';
import 'package:flutter_application_api/loginNuevo.dart';



class InicioIcono extends StatelessWidget {
  const InicioIcono({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginViewComponent(),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 101, 231, 151),
            child: const Icon(Icons.account_balance_sharp, size: 40 ) ,
          ),
        ],
      ),
    );
  }
}
