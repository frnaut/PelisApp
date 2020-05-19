import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pelis_app/models/pelicula_model.dart';

class PeliculaProvider{

  String  _apiKey = 'c53bb7db3e5e208c28116316e7372e77';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';

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

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   :   _apiKey,
      'language'  :   _language
    });

    final resp = await http.get(url);
    final decoded = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonMap(decoded['results']);

    return peliculas.items; 
  }
}