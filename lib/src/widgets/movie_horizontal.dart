import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  const MovieHorizontal({Key key, this.peliculas}) : super(key: key);

  final List<Pelicula> peliculas;


  @override
  Widget build(BuildContext context) {

    //variable para tomar el valor del tamaño de pantalla

    final _screenSise = MediaQuery.of(context).size;

    return Container(
      height: _screenSise.height * 0.2,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3, //muestra la cantidad de card 
        ),
        children: _tarjetas(),
      ),
    );
  }

  List<Widget>_tarjetas() {

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(pelicula.getPostrImg()),            
              fit: BoxFit.cover, //abarcar todo el ancho posible
              height: 150.0,

            ),
          ],
        ),
      );

    }).toList();
  }
}