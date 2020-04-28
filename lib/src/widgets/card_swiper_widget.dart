import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


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
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(peliculas[index].getPostrImg()),
                fit: BoxFit.cover,
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