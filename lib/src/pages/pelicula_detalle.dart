import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //traer los arguments de la pagina princiopl
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title, 
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage( pelicula.getBackgroundImg() ),
          placeholder: AssetImage('assets/loading.gif'), 
          fadeInDuration: Duration(microseconds: 200),
          fit: BoxFit.cover,
        ),
        
      ),
    );

  }
}