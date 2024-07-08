import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apimodel_3.dart';
Future<Dust> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.storerestapi.com/products'));

  if (response.statusCode == 200) {

    return Dust.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {

    throw Exception('Failed to load album');
  }
}
class ApiWork_3 extends StatefulWidget {
  const ApiWork_3({super.key});

  @override
  State<ApiWork_3> createState() => _ApiWork_3State();
}

class _ApiWork_3State extends State<ApiWork_3> {
  late Future<Dust> futureAlbum;

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
          child: FutureBuilder<Dust>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.message.toString()),
                    Text(snapshot.data!.status.toString()),
                    Text(snapshot.data!.message.toString()),




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
