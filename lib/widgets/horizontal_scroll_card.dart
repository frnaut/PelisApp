import 'package:flutter/material.dart';
import 'package:pelis_app/models/pelicula_model.dart';

class HorizonalScrollWidget extends StatelessWidget{
  
  final List<Pelicula> models;

  HorizonalScrollWidget({@required this.models});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    return Container(
      height: _screenSize.height * 0.4,
      width: double.infinity,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.5,
        ),
        children: _cards(),
      ),
    );
  }

  List<Widget> _cards(){

    return models.map((pelicula) {
      
      return Container(
        margin: EdgeInsets.only(right: 0.3),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPoster()),
                placeholder: AssetImage('assets/img/original.gif'),
                fit: BoxFit.fill, 
                height: 250.0,
              ),
            )
          ],
        ),
      );

    }).toList();
  }

}