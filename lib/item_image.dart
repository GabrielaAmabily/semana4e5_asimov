//imagem + origem 

import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imageUrl;

  const ItemImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: imageUrl.startsWith('http')
          ? Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          : Image.asset(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
    );
  }
}
