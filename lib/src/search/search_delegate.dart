import 'package:flutter/material.dart';
import 'package:toscapeli/src/models/pelicula_model.dart';
import 'package:toscapeli/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  //consumiendo la api
  final peliculasProvider = new PeliculasProvider();

  //listado creado para puebas internas
  String seleccion = '';

  final peliculas = [
    'just like angel',
    'babel',
    'pepeloco',
    'chokeee',
    'milipili',
  ];

  final peliculasRecientes = [
    'alo alo',
    'apa la papa',
  ];



  @override
  List<Widget> buildActions(BuildContext context) {
      // las acciones de nuestro appBar limpiar o cancelar 
      return[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //limpiar
            query = '';
          }
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appBar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
         //regresar a la pagina principal
         close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // crea los resultados que vamos a mostrar para ver en la misma pantallas
      return Center(
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.amberAccent,
          child: Text(seleccion),
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        
        if(snapshot.hasData) {

          final pelicula = snapshot.data;
          //crear el listado
          return ListView(
            children: pelicula.map( (pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(pelicula.getPostrImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                
                onTap: () {
                  //cerrar la busqueda
                  close(context, null);      
                  //navegar a otro lugar 
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },

    );
    
  }



  //***para consumir datos internos***  
//    @override
//  Widget buildResults(BuildContext context) {
//      // crea los resultados que vamos a mostrar para ver en la misma pantalla
//      return Center(
//        child: Container(
//          height: 200.0,
//          width: 200.0,
//          color: Colors.amberAccent,
//          child: Text(seleccion),
//        ),
//      );
//    }
//  
//    @override
//    Widget buildSuggestions(BuildContext context) {
//    // Las sugerencias que aparecen cuando la persona escribe
//    
//   //cuando el usuario escribe
//    final listaSugerida = ( query.isEmpty )
//                        ? peliculasRecientes
//                        : peliculas.where(
//                            (p) => p.toLowerCase().startsWith(query.toLowerCase())
//                          ).toList();
//    
//    return ListView.builder(
//      itemCount: listaSugerida.length,
//      itemBuilder: (context, i){
//        return ListTile(
//          leading: Icon(Icons.movie),
 //         title: Text(listaSugerida[i]),
//          onTap: () {
//            seleccion = listaSugerida[i];
//            showResults(context);
//          },
//        );
//      },
//    );
// }
  
  
}