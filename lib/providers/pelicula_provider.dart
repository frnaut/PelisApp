import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pelis_app/models/actor_model.dart';

import 'package:pelis_app/models/pelicula_model.dart';


class ActorProvider{
  
  String _apiKey = "c53bb7db3e5e208c28116316e7372e77";
  String _url = "api.themoviedb.org";
  

  Future<List<Actor>> getActores(String movieId) async{
    
    final url = Uri.https(_url, '3/movie/$movieId}/credits', {
      'api_key'   :   _apiKey,
      'language'  :   'es-ES'
    });

    final resp = await  http.get(url);
    final decoded = json.decode(resp.body);
    final cast = new Actores.fromJsonMap(decoded['cast']);

    return cast.items;

  }


}

class PeliculaProvider{

  String  _apiKey = 'c53bb7db3e5e208c28116316e7372e77';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';

  int _popularPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = [];

  final _popularStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Pelicula>> get popularStream => _popularStreamController.stream;


  void dispouse(){
    _popularStreamController?.close();
  }

  Future<List<Pelicula>> getEnCine() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   :   _apiKey,
      'language'  :   _language
    });

    final resp = await  http.get(url);
    final decoded = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonMap(decoded['results']);

    return peliculas.items;
    
  }

  Future<List<Pelicula>> _procesarResp(Uri url) async{

    final resp = await  http.get(url);
    final decoded = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonMap(decoded['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getPopular() async {

    if (_cargando) return [];
    _cargando = true;

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   :   _apiKey,
      'language'  :   _language,
      'page'      :   _popularPage.toString()
    });


    final resp = await _procesarResp(url);

    _populares.addAll(resp);
    popularSink(_populares);

    _cargando = false;
    return resp;
  }
}