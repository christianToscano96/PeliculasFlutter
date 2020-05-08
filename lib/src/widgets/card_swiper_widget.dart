import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:toscapeli/src/models/pelicula_model.dart';


class CardSwiper extends StatelessWidget {
  const CardSwiper({Key key, this.peliculas}) : super(key: key);

  final List<Pelicula> peliculas;

  

  @override
  Widget build(BuildContext context) {

    //medias querys
    final _screenSize = MediaQuery.of(context).size;



    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){

            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

            return Hero(
              tag: peliculas[index].id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),             
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), 
                    image: NetworkImage(peliculas[index].getPostrImg()),
                    fit: BoxFit.cover,
                  ),
                ),                        
              ),
            );
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
      ),
    );
  }

}