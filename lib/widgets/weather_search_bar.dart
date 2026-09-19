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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Entrez le nom d'une ville...",
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.search, size: 24, color: Colors.white),
            suffixIcon: IconButton(
              onPressed: () => widget.controller.clear(),
              icon: const Icon(Icons.clear, color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onSubmitted: widget.onSearch,
        ),

        if (widget.suggestions.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.suggestions.map((city) {
              return ActionChip(
                label: Text(city),
                backgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  widget.controller.text = city;
                  widget.onSearch(city);
                },
              );
            }).toList(),
          ),
        ],

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: () {
            if (widget.controller.text.trim().isNotEmpty) {
              widget.onSearch(widget.controller.text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          label: const Text(
            'Obtenir la météo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
