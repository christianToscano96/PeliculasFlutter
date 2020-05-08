import 'package:flutter/material.dart';
import 'package:toscapeli/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
 

  final List<Pelicula> peliculas;

  final Function siguientePagina;

   MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3, //muestra la cantidad de card 
  );


  @override
  Widget build(BuildContext context) {

    //variable para tomar el valor del tamaño de pantalla
    final _screenSize = MediaQuery.of(context).size;

    //hacer un listener para escuchar todos los cambios en el buildController cuando llegue al final
    _pageController.addListener( () {
        if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
          //print('Cargar las imagenes');
          siguientePagina();
        }
    });


    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        //children: _tarjetas(),
        itemBuilder: ( context, i ) => _tarjeta(context, peliculas[i]),   


      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

    //para evitar el conflicto de los widgets para ir a pagina de detalle
    pelicula.uniqueId = '${pelicula.id}-poster';

     final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId, //pasarle un parametro unico            
              child: ClipRRect(//para hacer boder rendondeeados
                borderRadius: BorderRadius.circular(12.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(pelicula.getPostrImg()),            
                  fit: BoxFit.cover, //abarcar todo el ancho posible
                  height: 135.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              style: TextStyle(color: Colors.purple),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: () {
          //print('${pelicula.id}');
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
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