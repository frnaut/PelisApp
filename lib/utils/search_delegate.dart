import 'package:flutter/material.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate{

  String selection = '';
  final _provider = PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: (){
        Navigator.of(context).pushNamed('/');
      },
      
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: _provider.searchPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshop){
        
        if (snapshop.hasData){

          final peliculas = snapshop.data;

          return ListView(
            children: peliculas.map((pelicula){
              
              pelicula.subId = "${pelicula.id}-seach";

              return GestureDetector(
                child: ListTile(
                  leading: Hero(
                    tag: pelicula.genreIds,
                    child: FadeInImage(
                      image: NetworkImage(pelicula.getPoster()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      height: 50.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('detalle', arguments: pelicula);
                },
              );

            }).toList()
          );

        }else{

          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );


  }


}