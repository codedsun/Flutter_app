import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());//Fat arrow notation used for one line method, functions

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return new MaterialApp(title: 'Startup Name Generator',
      home: new RandomWords(),
        );
  }
}

class RandomWords extends StatefulWidget{

  @override
  createState() => new RandomWordsState();

}

class RandomWordsState extends State<RandomWords>{
  /*
   The variable begins with underscore in Dart, and prefixing with _ gives privacy
   */

  final _suggestions = <WordPair>[];
  final _biggerfont = const TextStyle(fontSize: 18.0);
  final _save = new Set<WordPair>();

  /*function to give the word pairs*/

  Widget _buildSuggestions(){
    return new ListView.builder(
        itemBuilder: (context,i){
          if(i.isOdd) return new Divider();
          final index = i ~/ 2;
          if(index >= _suggestions.length)
            _suggestions.addAll(generateWordPairs().take(20));
          return _buildRow(_suggestions[index]);

        },

        padding: const EdgeInsets.all(16.0),
        );

  }

  Widget _buildRow(WordPair wordPair){
    final _alreadySaved = _save.contains(wordPair);
    return new ListTile(
      title: new Text(wordPair.asPascalCase, style: _biggerfont),
      trailing: new Icon(_alreadySaved? Icons.favorite : Icons.favorite_border,
      color: _alreadySaved ? Colors.red : null),

      onTap: (){
        setState((){
          if(_alreadySaved){
            _save.remove(wordPair);
          }
          else
            {
              _save.add(wordPair);
            }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
//    final WordPair wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

  return new Scaffold(appBar: new AppBar(title: new Text('Startup Text Generator'),),body: _buildSuggestions(),);
  }

}