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
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){ }          
          ),
        ],
      ),
      body: Container(//toda la pantalla
      
        color: Colors.black,
        
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child:
              Text('Populares', style: TextStyle(color: Colors.white, height: 2, fontSize: 20)  ),    
          ),

          SizedBox(height: 5.0),

          FutureBuilder(
            future:peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              //snapshot.data.forEach( (p) => print(p.title));

              if(snapshot.hasData) {

                return MovieHorizontal(peliculas: snapshot.data );

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