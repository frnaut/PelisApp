class Actores{

  List<Actor> items = new List();

  Actores();

  Actores.fromJsonMap(List<dynamic> jsonList){
    
    if(jsonList == null) return;

    for(var item in jsonList){
      
      final pelicula = Actor.fromJson(item);
      items.add(pelicula);
    }
  }

}


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

  Actor.fromJson(Map<String, dynamic> json){

    castId          =  json['cast_id'];
    character       =  json['character'];
    creditId        =  json['credit_id'];
    gender          =  json['gender'];
    id              =  json['id'];
    name            =  json['name'];
    order           =  json['order'];
    profilePath     =  json['profile_path'];
  }



  String getPoster(){
  if(profilePath == null){
    return 'assets/img/no-image.jpg';
  }else{
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }

  }
}
