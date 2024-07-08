import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modelapi.dart';

Future<Moon> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Moon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class WorkApi_10 extends StatefulWidget {
  const WorkApi_10({super.key});

  @override
  State<WorkApi_10> createState() => _WorkApiState();
}

class _WorkApiState extends State<WorkApi_10> {
  @override
  Widget build(BuildContext context) {
    late Future<Moon> futureAlbum;

    @override
    void initState() {
      super.initState();
      futureAlbum = fetchAlbum();
    }
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
          child: FutureBuilder<Moon>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.id!.toInt().toString()),
                    Text(snapshot.data!.name.toString()),
                    Text(snapshot.data!.username.toString()),
                    Text(snapshot.data!.email.toString()),
                    Text(snapshot.data!.address!.street.toString()),
                    Text(snapshot.data!.address!.suite.toString()),
                    Text(snapshot.data!.address!.city.toString()),
                    Text(snapshot.data!.address!.zipcode.toString()),
                    Text(snapshot.data!.address!.geo!.lat.toString()),
                    Text(snapshot.data!.address!.geo!.lng.toString()),
                    Text(snapshot.data!.company!.name.toString()),
                    Text(snapshot.data!.company!.catchPhrase.toString()),
                    Text(snapshot.data!.company!.bs.toString()),
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
