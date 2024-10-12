class BarberShop {
  final String location;
  final String name;
  final double rating;
  final String photo;
  final Map<String, String> workingHours;

  BarberShop({
    required this.location,
    required this.name,
    required this.rating,
    required this.photo,
    required this.workingHours,
  });

  factory BarberShop.fromJson(Map<String, dynamic> json) {
    return BarberShop(
      location: json['Location'],
      name: json['Name'],
      rating: json['Rating'],
      photo: json['Photo'] ?? '', // Handle null value
      workingHours: Map<String, String>.from(json['WorkingHours']),
    );
  }
}
