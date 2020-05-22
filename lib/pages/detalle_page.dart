

import 'package:flutter/material.dart';
import 'package:pelis_app/models/actor_model.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/providers/pelicula_provider.dart';

class DetallePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _poster(pelicula, context),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Text(pelicula.overview, textAlign: TextAlign.justify,),
                    Text(pelicula.overview, textAlign: TextAlign.justify),
                    Text(pelicula.overview, textAlign: TextAlign.justify),
                    _casting(pelicula.id.toString())
                  ],
                )
              )

            ]),
          )
        ],
      ),
    );
  }


  Widget _appBar(Pelicula pelicula){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackg()),
          placeholder: AssetImage('assets/img/no-image.jpg'),
        ),
      ),  
    );
  }

  Widget _poster(Pelicula pelicula, BuildContext context)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              height: 200.0,
              image: NetworkImage(pelicula.getPoster()),
              placeholder: AssetImage("assets/img/no-image.jpg"), 
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _casting(String peliculaId){

    final _provider = ActorProvider();

    return FutureBuilder(
      future: _provider.getActores(peliculaId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(snapshot.hasData){
          return _actorCard(snapshot.data);
        }else{
          return CircularProgressIndicator();
        }
      },
    );

  }

  Widget _actorCard(List<Actor> actores){
      
      return SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemCount: actores.length,
          itemBuilder: (context, i){
            return  Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5.0, top: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(actores[i].getPoster()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(actores[i].name)
                ],
            );
          },
        )
      );
  }

}