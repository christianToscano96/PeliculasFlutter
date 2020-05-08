import 'package:flutter/material.dart';

import 'package:toscapeli/src/models/actores.model.dart';
import 'package:toscapeli/src/models/pelicula_model.dart';

import 'package:toscapeli/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //traer los arguments de la pagina princiopl
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    
    return Scaffold(
      
      body: CustomScrollView( 
        
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula ),
                _descripcion( pelicula ),              
                _crearCasting( context, pelicula ),                        
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
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0, height: 5.0),
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
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                image: NetworkImage(pelicula.getPostrImg()),
                height: 150.0,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(pelicula.title, style:  TextStyle(color: Colors.black, fontSize: 20.0), overflow: TextOverflow.clip, ),
                    Text(pelicula.originalTitle, style: TextStyle(color: Colors.black, fontSize: 14.0,height: 2.0) , overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: Colors.yellow, size: 30.0,),
                        SizedBox(width: 5.0),
                        Text(pelicula.voteAverage.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0)),
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
        style: TextStyle(color: Colors.black, fontSize: 18.0, height: 1.4 ),
        textAlign: TextAlign.justify,
      ),
    );
  }


  Widget _crearCasting(BuildContext context, Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();


    return FutureBuilder(
      future:peliProvider.getCast(pelicula.id.toString()),
      builder:(BuildContext context, AsyncSnapshot<List> snapshot ){
        
        if( snapshot.hasData) {
          return _crearActoresPageView( snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }  
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (contex, i) => _actorTarjeta(actores[i])
      ),
    );
  }

  Widget _actorTarjeta( Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'), 
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,  
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 2.0),
          )
        ],
      ),
    );
  }
}