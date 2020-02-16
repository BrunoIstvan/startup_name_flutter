import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      
      title: 'Startup Name Generator',
  
      theme: ThemeData(
  
        primaryColor: Colors.white,
  
      ),
  
      home: RandomWords(),
      
    );
  }
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
  
        title: Text('Startup Name Generator'),
  
        actions: <Widget>[

          IconButton(icon: Icon(Icons.list), 
                    onPressed: _pushSaved,)

        ],
      ),
    
      body: _buildSuggestions(),
    
    );
  
  }

  void _pushSaved() {

    Navigator.of(context).push(
      
      MaterialPageRoute<void> (

        builder: (BuildContext context) {

          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {

              return ListTile(

                title: Text(
  
                  pair.asPascalCase,
                  style: _biggerFont,
  
                ),

              );

            },

          );

          final List<Widget> divided = ListTile
            .divideTiles(
         
              tiles: tiles, 
              context: context
         
            ).toList();

          return Scaffold(
 
            appBar: AppBar(
           
              title: Text("Saved Suggestions"),
           
            ),
 
            body: ListView(children: divided),

          );

        },

      ),

    );

  }

  Widget _buildSuggestions() {

    return ListView.builder(
    
      padding: const EdgeInsets.all(16.0),
    
      itemBuilder: (context, i) {
    
        // se for ímpar, retornar um divisor
        if (i.isOdd) return Divider(); 

        // se for par, pegar o resto da divisão por 2 
        final index = i ~/ 2;
    
        // se for maior ou igual a quantidade de itens na lista
        if (index >= _suggestions.length) {

          // pegar os 10 primeiros registros da função que gera palavras e adicionar na lista 
          _suggestions.addAll(generateWordPairs().take(10)); 
        
        }
    
        // retorna uma linha construída com um item da lista
        return _buildRow(_suggestions[index]);
    
      });

  }

  Widget _buildRow(WordPair pair) {
 
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
 
      title: Text(

        pair.asPascalCase,
        style: _biggerFont,

      ),
      trailing: Icon(

        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,

      ),
      onTap: () {

        setState(() {

          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }

        });

      }, // onTap

    );
 
  }

}


class RandomWords extends StatefulWidget {

  @override
  RandomWordsState createState() => RandomWordsState();

}

