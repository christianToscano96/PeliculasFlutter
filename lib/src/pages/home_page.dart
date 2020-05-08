import 'package:flutter/material.dart';
import 'package:toscapeli/src/providers/peliculas_provider.dart';

//widgets
import 'package:toscapeli/src/widgets/card_swiper_widget.dart';
import 'package:toscapeli/src/widgets/movie_horizontal.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

   //llamar la paticion http de peliculas-provider
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Peliculas Tosca'),
        backgroundColorStart: Colors.purple[300],
        backgroundColorEnd: Colors.purple[200],
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){ }                
          ),
        ],
      ),
      body: Container(//toda la pantalla
           
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _seccion1(context),
            //_seccion2(context),
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
  Widget _seccion1(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child:
              Text('Populares', style: TextStyle(color: Colors.purple ,height: 2, fontSize: 20)  ),    
          ),

          SizedBox(height: 5.0),

          StreamBuilder(
            stream:peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              //snapshot.data.forEach( (p) => print(p.title));

              if(snapshot.hasData) {

                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );

              } else {

                return Center(child: CircularProgressIndicator());

              }
            
            }
          ),
        ],
      ),
    );
  }

  
}