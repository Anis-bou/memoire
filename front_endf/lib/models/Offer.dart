class Offer {
  int? id;
  String? numberphone;
  String? price;
  String? bedrooms;
  String? addres;
  String? area;
  String? bathrooms;
  String? kitchen;
  String? garage;
  String? description;
  String? operation;
  String? latitude;
  String? longitude;
  String? name_agence;
  String? categorie;
  String? image;

  Offer({
    this.id,
    this.numberphone,
    this.price,
    this.bedrooms,
    this.addres,
    this.area,
    this.bathrooms,
    this.kitchen,
    this.garage,
    this.description,
    this.image,
    this.operation,
    this.latitude,
    this.longitude,
    this.name_agence,
    this.categorie,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      numberphone: json['numberphone'],
      price: json['price'],
      bedrooms: json['bedrooms'],
      addres: json['addres'],
      area: json['area'],
      bathrooms: json['bathrooms'],
      kitchen: json['kitchen'],
      garage: json['garage'],
      description: json['description'],
      operation: json['operation'],
      name_agence: json['name_agence'],
      categorie: json['categorie'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
