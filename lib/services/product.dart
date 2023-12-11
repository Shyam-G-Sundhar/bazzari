class Review {
  final String username;
  final String name;
  final double rating;

  Review({
    required this.username,
    required this.name,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      username: json['user']['username'],
      name: json['user']['name'],
      rating: json['rating'].toDouble(),
    );
  }
}

class ProductList {
  final int id;
  final String title;
  final dynamic price;
  final dynamic rating;
  final String description;
  final String image;
  final List<Review> reviews;

  ProductList({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.description,
    required this.image,
    required this.reviews,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    List<dynamic> reviewsData = json['reviews'];
    List<Review> reviews =
        reviewsData.map((reviewData) => Review.fromJson(reviewData)).toList();

    return ProductList(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      rating: json['rating'],
      description: json['description'],
      image: json['image'],
      reviews: reviews,
    );
  }

  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'title':
        return title;
      case 'price':
        return price;
      case 'rating':
        return rating;
      case 'image':
        return image;
      case 'description':
        return description;
      case 'reviews':
        return reviews;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}
