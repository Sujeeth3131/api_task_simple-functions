import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apimodel_1.dart';
Future<Wind > fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Wind .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class ApiWork_1 extends StatefulWidget {
  const ApiWork_1({super.key});

  @override
  State<ApiWork_1> createState() => _ApiWork_1State();
}

class _ApiWork_1State extends State<ApiWork_1> {
  late Future<Wind> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
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
          child: FutureBuilder<Wind>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.id.toString()),
                    Text(snapshot.data!.title.toString()),
                    Text(snapshot.data!.price.toString()),
                    Text(snapshot.data!.description.toString()),
                    Text(snapshot.data!.category.toString()),
                    Text(snapshot.data!.image.toString()),
                    Text(snapshot.data!.rating.toString()),
                    Text(snapshot.data!.rating!.count.toString()),
                    Text(snapshot.data!.rating!.count.toString()),
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
