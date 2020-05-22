import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelis_app/models/pelicula_model.dart';

class SwiperCard extends StatelessWidget {
  
  final List<Pelicula> models;

  SwiperCard({@required this.models});


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    return Container(
      child: Swiper(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          models[index].subId = "${models[index].id}-swiper"; 
          return GestureDetector(
            child: Hero(
              tag: models[index].subId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                      image: NetworkImage(models[index].getPoster()),
                      placeholder: AssetImage('assets/img/original.gif'),
                      fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed('detalle', arguments: models[index]);
            },
          );
        },
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
