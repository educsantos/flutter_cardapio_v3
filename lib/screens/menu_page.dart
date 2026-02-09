import 'package:flutter/material.dart';
import '../models/product.dart';
import '../repositories/menu_repository.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onLogout;
  final IMenuRepository repository = HttpMenuRepository();

  MenuPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardápio V3"),
        actions: [
          IconButton(icon: const Icon(Icons.exit_to_app), onPressed: onLogout)
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: repository.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) 
            return const Center(child: CircularProgressIndicator());
          
          final items = snapshot.data ?? [];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) => ListTile(
              leading: Image.network(items[i].imageUrl, width: 50),
              title: Text(items[i].title),
              trailing: Text("R\$ ${items[i].price}"),
            ),
          );
        },
      ),
    );
  }
}