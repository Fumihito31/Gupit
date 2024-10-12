import 'dart:convert';

/// ServiceModel class contains the individual service object (a service is something provided by the store).
/// Contains 2 fields: 
/// - serviceName: name of the service provided, 
/// - price: price of the service.
class ServiceModel {
  ServiceModel({
    required this.serviceName,
    required this.price,
  });

  String serviceName;
  int price;

  /// Factory to convert a raw JSON string into ServiceModel elements
  factory ServiceModel.fromRawJson(String str) =>
      ServiceModel.fromJson(json.decode(str));

  /// Method to convert the model into a raw JSON string
  String toRawJson() => json.encode(toJson());

  /// Factory for converting individual JSON object into ServiceModel object
  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceName: json["ServiceName"] ?? '',
        price: json["Price"] ?? 0,
      );

  /// Converting individual ServiceModel object to a JSON object
  Map<String, dynamic> toJson() => {
        "ServiceName": serviceName,
        "Price": price,
      };
}
