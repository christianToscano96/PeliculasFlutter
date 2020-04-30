import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //traer los arguments de la pagina princiopl
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    
    return Scaffold(
      backgroundColor: Colors.black,

      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                
              ]
            )
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage( pelicula.getBackgroundImg() ),
          fadeInDuration: Duration(microseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }



  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
              image: NetworkImage(pelicula.getPostrImg()),
              height: 150.0,
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(pelicula.title, style:  TextStyle(color: Colors.white, fontSize: 20.0), overflow: TextOverflow.clip, ),
                    Text(pelicula.originalTitle, style: TextStyle(color: Colors.white, fontSize: 14.0,height: 2.0) , overflow: TextOverflow.ellipsis),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: Colors.yellow,),
                        Text(pelicula.voteAverage.toString(),style: TextStyle(color: Colors.white, fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
            ),
        ],
      ),
    );
  }

  
  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        style: TextStyle(color: Colors.white, ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}