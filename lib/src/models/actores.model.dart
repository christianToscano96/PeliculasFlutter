//para agrupar los actores
class Cast {

  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList ) {

    if(jsonList == null) return;

    jsonList.forEach( (item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}



//para un solo actor
class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap(Map<String, dynamic> json ) {

      castId      = json['cast_id'];
      character   = json['character'];
      creditId    = json['credit_id'];
      gender      = json['gender'];
      id          = json['id'];
      name        = json['name'];
      order       = json['order'];
      profilePath = json['profile_path'];
  }


//metodo para obtener la imagen y ponerla en el card
  getFoto(){

    //por si el poster vienen vacias
    if ( profilePath == null ) {
      return 'https://www.payetteforward.com/wp-content/uploads/2019/06/iphone-ear-speaker-not-working-828x466.jpg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

 