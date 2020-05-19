import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCard extends StatelessWidget {
  
  final List<dynamic> models;

  SwiperCard({@required this.models}){}


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.only(top: 30.0),
      width: double.infinity,
      height: _screenSize.height * 0.45,
      child: Swiper(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
                image: NetworkImage('https://i.pinimg.com/originals/3a/38/00/3a380018075cc66908049c3a081225e2.jpg'),
                fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
      ),
    );
  }
}
