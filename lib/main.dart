import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //material de la app
      debugShowCheckedModeBanner: false,
      title: 'Taller 1',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const Pinicio(), //pagina inicio
    );
  }
}

class Pinicio extends StatefulWidget {
  const Pinicio({super.key});

  @override
  State<Pinicio> createState() => _PinicioState();
}

class _PinicioState extends State<Pinicio> {
  String titulo = "hola"; //texto de pagina
  Color colorFondo = Colors.white; //color original
  int numeroAleatorio = 0;

  final Random _random = Random();

  void _cambiarTitulo() {
    //cambiar el titulo
    setState(() {
      titulo = titulo == "hola" ? "¡Titulo cambiado!" : "hola";
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("titulo actualizado")));
  }

  void _cambiarColorFondo() {
    setState(() {
      colorFondo = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        1,
      );
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Color de fondo cambiado")));
  }

  void _generarNumeroAleatorio() {
    setState(() {
      numeroAleatorio = _random.nextInt(
        10000,
      ); //puede generar una numero aleatorio entre 0 y 10.000
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Número generado: $numeroAleatorio")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondo,
      appBar: AppBar(title: Text(titulo), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Nombre: Víctor Sánchez\nCódigo: 230232040",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            //imagen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/0/0b/PET-basic.png',
                  width: 80,
                ),
                const SizedBox(width: 20),
                Image.asset('assets/flutter_logo.png', width: 80),
              ],
            ),
            const SizedBox(height: 30),

            //boton que cambia el titulo
            ElevatedButton(
              onPressed: _cambiarTitulo,
              child: const Text("Cambiar titulo"),
            ),
            const SizedBox(height: 30),

            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("Cambiar color"),
                    onTap: _cambiarColorFondo,
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("Generar numero aleatorio"),
                    onTap: _generarNumeroAleatorio,
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Text("Número actual = $numeroAleatorio"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
