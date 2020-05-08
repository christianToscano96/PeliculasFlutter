import 'package:flutter/material.dart';

//pages
import 'package:toscapeli/src/pages/home_page.dart';
import 'package:toscapeli/src/pages/pelicula_detalle.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Peliculas',
     initialRoute: '7',
     routes: {
       '/'       : ( BuildContext context ) => HomePage(),
       'detalle' : ( BuildContext context ) => PeliculaDetalle(),
     },
    );
  }
}