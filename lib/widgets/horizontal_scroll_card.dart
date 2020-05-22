import 'package:flutter/material.dart';
import 'package:pelis_app/models/pelicula_model.dart';

class HorizonalScrollWidget extends StatelessWidget{
  
  final List<Pelicula> models;
  final Function siguientePagina;

  HorizonalScrollWidget({@required this.models, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.4,
    );

    _pageController.addListener(() {
      
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }
    });


    return Container(
      height: _screenSize.height * 0.3,
      width: double.infinity,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, i){
          return _createCard(models[i], context);
        },
      ),
    );
  }

  Widget _createCard( Pelicula pelicula, BuildContext context ){
    
    pelicula.subId = "${pelicula.id}-subcar";

    final card = Container(
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.subId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPoster()),
                  placeholder: AssetImage('assets/img/original.gif'),
                  fit: BoxFit.fitHeight, 
                  height: 200.0,
                ),
              ),
            )
          ],
        ),
      );

      return GestureDetector(
        child: card,
        onTap: (){
          Navigator.of(context).pushNamed('detalle', arguments: pelicula);
        },
      );

  }




  // no esta en eso solo se utiliza como referencia
  // List<Widget> _cards(){

  //   return models.map((pelicula) {
      
  //     return Container(
  //       margin: EdgeInsets.only(right: 0.3),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               image: NetworkImage(pelicula.getPoster()),
  //               placeholder: AssetImage('assets/img/original.gif'),
  //               fit: BoxFit.fill, 
  //               height: 250.0,
  //             ),
  //           )
  //         ],
  //       ),
  //     );

  //   }).toList();
  // }

}