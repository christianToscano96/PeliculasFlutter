//import el http


import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

//models
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actores.model.dart'; 

class PeliculasProvider {

  String _apikey   = 'aa2edb7104d709cf08fe6bb96f173516';
  String _url      = 'api.themoviedb.org';
  String _lenguaje ='es-ES';

  int _popularesPage = 0;

  //para tratar de no cargar todas las peliculas y solo ver las que esten mediante el scroll
  bool _cargando     = false;
 

  //1 el manejo de Stream
  List<Pelicula> _populares = new List();
  //2 crear el Stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //3 para cerrar los Streams
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  //4 crear los gets para introducir y escuchar datos al Stream
  //4-a insertar informacion al stream
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  //4-b escuchar la informacion que salen de los stream
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;



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

    if( _cargando) return [];
    //si no
    _cargando = true;


    _popularesPage++;

    final url = Uri.https( _url, '3/movie/popular', {     

      //hacer un mapa
      'api_key'  : _apikey,
      'language' : _lenguaje,
      'page'     : _popularesPage.toString()
    });

    //usar es stream
    final resp = await _procesaRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
     _cargando = false;

    return resp;
    
  }

  //obtener los actores
  Future<List<Actor>> getCast(String peliId) async {
    
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      //hacer un mapa
      'api_key'  : _apikey,
      'language' : _lenguaje,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }



}