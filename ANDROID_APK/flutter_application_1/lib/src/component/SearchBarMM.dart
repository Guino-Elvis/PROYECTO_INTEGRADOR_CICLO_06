import 'package:flutter/material.dart';

class SearchBarMM extends StatelessWidget {
  final bool isSearching;
  final Function(bool) onSearch;

  SearchBarMM({required this.isSearching, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? null
          : Text('Título de la pantalla'),
      actions: <Widget>[
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            onSearch(!isSearching); // Cambia el estado isSearching
          },
        ),
      ],
    );
  }
}
