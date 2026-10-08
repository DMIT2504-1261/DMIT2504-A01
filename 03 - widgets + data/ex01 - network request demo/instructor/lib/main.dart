import 'dart:convert'; // for jsonDecode

import 'package:flutter/material.dart';
import 'package:http/http.dart'; // for HTTP requests e.g. get()

///TODO: create a stateful widget, override initState to fetch the initial
/// dog url. NOTE: will need to ensure a callback is used to be certain the
/// widget has been mounted before calling setState().

/* we're hitting the URL: 
      https://dog.ceo/api/breeds/image/random
   and getting back e.g.: 
     {
       "message": "https://images.dog.ceo/breeds/boxer/n02108089_1003.jpg",
       "status": "success"
     }
*/

// in flutter,
//  r - hot reload  - will not re-fire main() function
//  R - hot restart - (shift+r) *will* re-fire main() function 

// I can't have a stateless widget with an async build method, so I need some other way
// of setting up my dog URL before showing it:
String dogImageUrl = '';


Future<void> main() async {
  dogImageUrl = await RandomDogImage.getRandomDogUrl();
  // separate out the ^async behaviour^ from the sync widget rendering
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: RandomDogImage(),
        ),
      ),
    );
  }
}

class RandomDogImage extends StatelessWidget {

  const RandomDogImage({super.key});

  // static method, bc no inputs that change / nothing instance-dependent
  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response      = await get(Uri.parse(dogEndpoint));

    return jsonDecode(response.body)['message'];
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(dogImageUrl);
  }

}
