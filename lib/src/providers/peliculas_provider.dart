//import el http
import 'package:http/http.dart' as http; 

import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apikey   = 'aa2edb7104d709cf08fe6bb96f173516';
  String _url      = 'api.themoviedb.org';
  String _lenguaje ='es-ES';

  //metodo para procesar respuesta y no poner 2 veces lo mismo
  Future<List<Pelicula>> _procesaRespuesta(Uri url) async {
    //2- realizamos la peticion http
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    //print(decodeData['results']);

    //mostrar los resultados
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    //obtener una pelicula
    //print(peliculas.items[1].title);


    return peliculas.items;
  }



  Future<List<Pelicula>> getEnCines() async {
    //generar el url mas facil
    final url = Uri.https( _url, '3/movie/now_playing', {
      //hacer un mapa
      'api_key'  : _apikey,
      'language' : _lenguaje,
    });
    
    //retornar _procesaRespuesta()
    return await _procesaRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
   //generar el url mas facil
    final url = Uri.https( _url, '3/movie/popular', {
      //hacer un mapa
      'api_key'  : _apikey,
      'language' : _lenguaje,
    });

      //retornar _procesaRespuesta()
      return await _procesaRespuesta(url);

    
  }

}