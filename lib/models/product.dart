class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.id, 
    required this.title, 
    required this.price, 
    required this.description, 
    required this.imageUrl
  });

  // DRY: Método de fábrica para evitar repetição de parsing em outros lugares
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // Alguns mocks retornam price como int ou double, tratamos aqui:
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? "",
      imageUrl: json['image'] ?? "https://via.placeholder.com/150",
    );
  }
}