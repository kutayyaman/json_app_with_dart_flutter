import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/post.dart';

class PostDetail extends StatelessWidget {
  Post post;

  PostDetail({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(
          post.title,
          textAlign: TextAlign.center,
        ),
      ),
      // ignore: missing_return
      body: OrientationBuilder(builder: (context, orientation) {
        if(orientation==Orientation.portrait){ //yani ekran yan yatirilmadiysa
          return verticalBody(context);
        }else{
          return horizontalBody(context);
        }
      },),
    );
  }
  Widget horizontalBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-20,
      height: MediaQuery.of(context).size.height*3/4,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child:Hero(
              tag: post.id, child: Container(
              width: 100,
              height: 100,
              child: Image.asset("assets/images/post.png"),
            ),
            ) ,
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's ID: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),))),
                      Flexible(child: Container(child: Text(post.id.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's UserID: ",style: TextStyle(color:Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.userId.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's Title: ",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's Content : ",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.body,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget verticalBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * 2 / 3,
          width: MediaQuery.of(context).size.width * 4 / 5,
          left: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.13,
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              color: Colors.white,
              elevation: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's ID: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),))),
                      Flexible(child: Container(child: Text(post.id.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's UserID: ",style: TextStyle(color:Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.userId.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's Title: ",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: Container(child: Text("Post's Content : ",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),))),
                      Flexible(child: Container(child: Text(post.body,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: post.id, child: Container(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/post.png"),
          ),
          ),
        ),
      ],
    );
  }
}
