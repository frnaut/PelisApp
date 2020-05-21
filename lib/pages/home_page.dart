import 'package:flutter/material.dart';
import 'package:pelis_app/providers/pelicula_provider.dart';
import 'package:pelis_app/widgets/horizontal_scroll_card.dart';
import 'package:pelis_app/widgets/swiper_card_widget.dart';

class HomePage extends StatelessWidget{
  
  final peliculas = PeliculaProvider();

  @override
  Widget build(BuildContext context) {

    peliculas.getPopular();
    

    return Scaffold(
      appBar: AppBar(
        title: Text("PelisApp"),
        actions: <Widget>[
          Container(
            child: Icon(Icons.search)
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            _cardSwiper(),
            _footer(context)
          ],
        )
      ),
    );
  }  

  Widget _cardSwiper(){

    return FutureBuilder(
      future: peliculas.getEnCine(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return SwiperCard(models: snapshot.data);
        }else{
          return Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: 25),
          Text("Populares", style: Theme.of(context).textTheme.subtitle1,),
          StreamBuilder(
             stream: peliculas.popularStream,
             builder: (BuildContext context, AsyncSnapshot<List> snapshot){

               if(snapshot.hasData){

                return HorizonalScrollWidget(models: snapshot.data, siguientePagina: peliculas.getPopular );
               }else{
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
             },
          )
        ],
      ),
    );
  }
}

