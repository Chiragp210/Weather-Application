import 'package:flutter/material.dart';
import 'package:weatherapp/Model/weather_api_client.dart';
import 'package:weatherapp/Model/weather_model.dart';
import 'package:weatherapp/views/additinal_info.dart';
import 'package:weatherapp/views/current_weather.dart';

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>{

  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async{
    data = await client.getCurrentWeather("$location");
  }

  var searchController = TextEditingController();
  String location = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu),
          color: Colors.black,

        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 15.0,color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Search",
                  labelStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  errorStyle:
                  TextStyle(color: Colors.redAccent, fontSize: 15.0),
                ),
                controller: searchController,
              )
          ),
            IconButton(onPressed: (){
              setState(() {
                  location = searchController.text;
              });
            }, icon: Icon(Icons.search))
          ],),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    currentWeather(Icons.wb_sunny_rounded, "${data?.temp}", "${data?.cityName}"),
                    SizedBox(height: 20.0,),
                    Text("Additional Information",
                      style: TextStyle(fontSize: 15.0,color: Color(0xdd212121),
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(height: 10.0,),
                    additionalInformation("${data?.wind}", "${data?.humidity}", "${data?.pressure}","${data?.feels_like}"),
                  ],
                );
              }
              else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }
            ,
          )
        ],
      )
    );
  }

}