import 'package:flutter/material.dart';

class ThemeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final VoidCallback onAdd;
  final VoidCallback onMoreInfo;

  const ThemeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.onAdd,
    required this.onMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow, width: 1.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.pink,
              height: 120,
              width: double.infinity,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "QAR $price",
                style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onAdd,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.yellow,
              side: const BorderSide(color: Colors.yellow),
            ),
            child: const Text("ADD"),
          ),
          const SizedBox(height: 5),
          OutlinedButton.icon(
            onPressed: onMoreInfo,
            icon: const Icon(Icons.info_outline, color: Colors.yellow),
            label:
                const Text("More Info", style: TextStyle(color: Colors.yellow)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
