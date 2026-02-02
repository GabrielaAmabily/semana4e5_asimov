import 'package:flutter/material.dart';
import 'classe_item.dart';
import 'item_image.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onFavoriteToggle;

  const ItemCard({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // vou tentar fazer um if entre foto asset e foto url 
            ItemImage(item.imageUrl),
            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'R\$ ${item.preco.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                item.favorito
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: item.favorito ? Colors.red : Colors.grey,
              ),
              onPressed: onFavoriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
