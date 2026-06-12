class Items {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;

  Items({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.description

});

  factory Items.fromJson(Map<String, dynamic> json){
    return Items(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      description: json['description']
    );
  }

}