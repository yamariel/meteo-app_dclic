import 'package:flutter/material.dart';

class WeatherSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final List<String> suggestions;
  const WeatherSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.suggestions,
  });

  @override
  State<StatefulWidget> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Rechercher une ville..',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, size: 30),
            suffixIcon: IconButton(
              onPressed: () => widget.controller.clear(),
              icon: Icon(Icons.clear),
            ),
          ),
          onSubmitted: widget.onSearch,
        ),
        if (widget.suggestions.isNotEmpty) ...[
          const SizedBox(height: 20),
          Wrap(
            children: [
              ...widget.suggestions.map((city) {
                return ActionChip(
                  label: Text(city),
                  onPressed: () {
                    widget.controller.text = city;
                    widget.onSearch(city);
                  },
                );
              }),
            ],
          ),
        ],
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            if (widget.controller.text.trim().isNotEmpty) {
              widget.onSearch(widget.controller.text);
            }
          },
          label: const Text('Obtenir la météo', style: TextStyle(color: Colors.black),),
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
