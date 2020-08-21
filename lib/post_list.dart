
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_json_app/model/post.dart';
import 'package:post_json_app/post_detail.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  String url="https://jsonplaceholder.typicode.com/posts/";
  Future<List<Post>> data;

  Future<List<Post>> getPosts()async{
    var response=await http.get(url); //arkada diger islemler yapiliyor ama burayi calistirirken bu satirin asagsina burdaki veriler gelmeden inmemesi icin await dedik.
    //response'nin body'sinde artik verdigmiz linkteki butun bilgiler var.
    //var decodedJson=json.decode(response.body); //verilen yapiyi json objecte ceviriyor.
    if(response.statusCode==200){
      return (json.decode(response.body) as List).map((onePost) => Post.fromJson(onePost)).toList();
    }
    /*
      ama egerki liste degilde tek bir eleman olsaydi
      decodedJson=json.decode(response.body);
      Post post=Post.fromJson(decodedJson);
      return post; diyecektik.
    */
    else{
      throw Exception("Can not connected ${response.statusCode}");
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post App With Json Data From Api"),
      ),
      // ignore: missing_return
      body: OrientationBuilder(
        // ignore: missing_return
        builder: (context, orientation) {
          if(orientation==Orientation.portrait){
            //yani telefon dikey durumdaysa
            // ignore: missing_return
            return FutureBuilder(future:data ,builder: (context, AsyncSnapshot<List<Post>> postList) {
              if(postList.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(postList.connectionState==ConnectionState.done){
                if(postList.data==null){
                  return Center(child: Text("Check Your Connection"),);
                }
                // ignore: missing_return
                /*return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
              return Text(postList.data[index].id.toString());
            },);*/
                return GridView.count(crossAxisCount: 2, children: postList.data.map((post) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetail(post: post,),));
                    },
                    child: Hero(tag: post.id, child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/images/post.png"),
                            ),
                          ),
                          Text("Title",style: TextStyle(fontSize: 20,color: Colors.blue),),
                          Text(post.title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )),
                  );
                }).toList(),);
              }
            },);
          }else{ //yani ekrani yan cevirdiyse
            // ignore: missing_return
            return FutureBuilder(future:data ,builder: (context, AsyncSnapshot<List<Post>> postList) {
              if(postList.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(postList.connectionState==ConnectionState.done){
                // ignore: missing_return
                /*return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
              return Text(postList.data[index].id.toString());
            },);*/
                //ekran yan dondugunda GridView.extent yapti GridView.count yerine.
                return GridView.extent(maxCrossAxisExtent: 300, children: postList.data.map((post) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetail(post: post,),));
                    },
                    child: Hero(tag: post.id, child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset("assets/images/post.png"),
                          ),
                          Text("Title",style: TextStyle(fontSize: 20,color: Colors.blue),),
                          Text(post.title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )),
                  );
                }).toList(),);
              }
            },);
          }
        },
      ),
    );
  }
}
