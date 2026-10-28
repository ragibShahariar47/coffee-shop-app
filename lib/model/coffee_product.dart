typedef ProductID = String;

class CoffeeProduct {
  CoffeeProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.additionalText,
  });

  final ProductID id;
  final String name;
  final String description;
  final String category;
  final String additionalText;
}
