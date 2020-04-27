import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';


//widgets
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

   //llamar la paticion http de peliculas-provider
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas Tosca'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){ }
            
         
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      )
    );
  }

  //metodo para mostrar tarjetas principales
  Widget _swiperTarjetas() {

   return FutureBuilder(
     //llmar el metodo
     future: peliculasProvider.getEnCines(),
     builder: (BuildContext context, AsyncSnapshot <List>snapshot) {

       if ( snapshot.hasData ) {
          return CardSwiper( peliculas:snapshot.data,);
       } else {
         return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
           );
       }
     },
   );
  }


  //metodo para crear el widget footer
  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead),
          FutureBuilder(
            future:peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              //snapshot.data.forEach( (p) => print(p.title));

              if(snapshot.hasData) {

                return MovieHorizontal(peliculas: snapshot.data );

              } else {

                return CircularProgressIndicator();

              }

              
            }
          ),
        ],
      ),
    );
  }
}