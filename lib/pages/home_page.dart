import 'package:flutter/material.dart';
import 'package:pelis_app/widgets/swiper_card_widget.dart';

class HomePage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
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
            _cardSwiper(),
            Container(
              child: Text("Mas populares")
            )
          ],
        )
      ),
    );
  }  

  Widget _cardSwiper(){
    return SwiperCard(
      models: [1,2,3,5,6],
    );
  }
}

