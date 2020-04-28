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
        pageSnapping: false,
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
            ClipRRect(//para hacer boder rendondeeados
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(pelicula.getPostrImg()),            
                fit: BoxFit.cover, //abarcar todo el ancho posible
                height: 135.0,
              ),
            ),
            SizedBox(height:5.0),
            Text(
              pelicula.title,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );

    }).toList();
  }
}