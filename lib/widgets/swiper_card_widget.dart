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
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                  image: NetworkImage(models[index].getPoster()),
                  placeholder: AssetImage('assets/img/original.gif'),
                  fit: BoxFit.fill,
            ),
          );
        },
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.4,
      ),
    );
  }
}
