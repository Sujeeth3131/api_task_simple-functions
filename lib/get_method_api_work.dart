import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apiwork.dart';
import 'get_method_api_model.dart';
import 'get_method_api_work.dart';
import 'get_method_api_work.dart';

final String zippopotam = "https://api.zippopotam.us/us/33162/";

//Future method to read the URL
Future< Zippopotam> fetchInfo() async{
  final response = await http.get(zippopotam as Uri);
  final jsonresponse = json.decode(response.body);

  return  Zippopotam.fromJson(jsonresponse);
}
class GetMethod extends StatefulWidget {
  const GetMethod({super.key});

  @override
  State<GetMethod> createState() => _GetMethodState();
}

class _GetMethodState extends State<GetMethod> {
  late Future<Zippopotam> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum() as Future<Zippopotam>;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Zippopotam>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.postCode.toString()),
                    Text(snapshot.data!.country.toString()),
                    Text(snapshot.data!.countryAbbreviation.toString()),
                    Text(snapshot.data!.places!.toString()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
