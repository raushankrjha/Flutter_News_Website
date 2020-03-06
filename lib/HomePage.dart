import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_web/resoponsive_method.dart';
import 'package:url_launcher/url_launcher.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final String url="http://newsapi.org/v2/everything?q=Coronavirus&apiKey=d6813f30acc2434d9516bfd5da8cfeb2";
  List data;
  var isLoading = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getjsondata();
  }
   Future<String> getjsondata() async
   {
        var response=await http.get(
        //encode url
        Uri.encodeFull(url),
        );
          print(response.body);
          setState(() {
              var convertDatatoJson=json.decode(response.body)['articles'];
              data=convertDatatoJson;
          });
   }


  newswidget(int index,MediaQueryData mediaQuery)
  {
    return Padding(
      padding: responsivePadding(mediaQuery),
    child: GridView.count(
      crossAxisCount: responsiveNumGridTiles(mediaQuery),
      mainAxisSpacing: 30,
      crossAxisSpacing: 30,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(data.length, (index)
      {
        return Center(
          child:  GridTile(
          child: GestureDetector(
          onTap: (){
           launch(data[index]['url']);
          },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: responsiveImageHeight(mediaQuery),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)
                            ),
                            image: DecorationImage(
                              image: NetworkImage(data[index]['urlToImage']),
                              fit: BoxFit.cover
                            
                            )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          height: responsiveTitleHeight(mediaQuery),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                            boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 1),
                              blurRadius: 6.0,
                            ),
                          ],
                          ),
                          child: Text(data[index]['title'],textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )
                          ,
                          maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ))
                  );
                }
                )
                ),
              );
            }
            @override
            Widget build(BuildContext context) {
              final mediaquery=MediaQuery.of(context);
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff7F00FF),
                Color(0xffE100FF)
              ]),
        ),
                  child: data.isEmpty?Center(child: CircularProgressIndicator()):ListView(
                    children: <Widget>[
                      SizedBox(height: 80,),
                      Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/logo.png')),
                          Text("Corona_Virus News",textAlign: TextAlign.center,style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),),
                          SizedBox(
                  width: 20,
                ),
                          MaterialButton(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    launch("http://corona-virus.surge.sh/");
                  },
                  child: Text(
                    "Tracker",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                        ],
                      ),),
                    SizedBox(height: 15,),
                   
                  newswidget(2,mediaquery),
                    
          
                    ],
                  ),
                ),
                bottomNavigationBar: new Container(
                      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xfff12711),
                Color(0xfff5af19)
              ]),
        ),
    height: 20.0,
    child: Center(child: Text("Designed & Developed By Raushan jha",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
  ),
              );
            }
          
           
}