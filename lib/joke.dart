import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Joke {
  final String category;
  final String type;
  final String joke;
  final bool safe;

  Joke({
    required this.category,
    required this.type,
    required this.joke,
    required this.safe,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'],
      type: json['type'],
      joke: json['joke'],
      safe: json['safe'] ?? true,
    );
  }
}

class JokeList extends StatefulWidget {
  static String id = 'jokes';

  @override
  _JokeListState createState() => _JokeListState();
}

class _JokeListState extends State<JokeList> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    loadJokes();
  }

  Future<void> loadJokes() async {
    final String response =
    await rootBundle.loadString('assets/jokes.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> jokesList = data['jokes'];

    setState(() {
      jokes = jokesList.map((dynamic jokeJson) {
        return Joke.fromJson(jokeJson);
      }).toList();

      // Shuffle the list for randomness
      jokes.shuffle();
    });
  }

  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke List'),
        backgroundColor: Colors.indigo,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          loadJokes();
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: jokes.map((Joke joke) {
                return GestureDetector(
                  onTap: () {
                    _showJokeDialog(joke);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height /6,
                      decoration: BoxDecoration(
                        color: _getRandomColor(), // Random color
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(
                          joke.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showJokeDialog(Joke joke) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(joke.category),
          content: Text(joke.joke),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
