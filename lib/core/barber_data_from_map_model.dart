import 'dart:convert';

import 'map_data_model.dart';
import 'comment_model.dart';
import 'service_model.dart';

/// BarberDataFromMapModel class that contains detailed information about the stores included in MapDataModel
/// Contains 4 fields: mapData - MapDataModel object, services - List of Service object instances, gallery - List of photos,
/// comments - List of Comment object instances.
class BarberDataFromMapModel {
  BarberDataFromMapModel({
    required this.mapData,
    required this.services,
    required this.gallery,
    required this.comments,
  });

  MapDataModel mapData;
  List<ServiceModel> services;
  List<dynamic> gallery;
  List<CommentModel> comments;

  /// Factory of converting raw JSON string to the BarberDataFromMapModel elements
  factory BarberDataFromMapModel.fromRawJson(String str) =>
      BarberDataFromMapModel.fromJson(json.decode(str));

  /// Method of converting Model into Raw JSON String
  String toRawJson() => json.encode(toJson());

  /// Factory for converting individual JSON object into BarberDataFromMapModel object
  factory BarberDataFromMapModel.fromJson(Map<String, dynamic> json) =>
      BarberDataFromMapModel(
        mapData: MapDataModel.fromJson(json["MapData"]),
        services: json["Services"] == null
            ? []
            : List<ServiceModel>.from(
                json["Services"].map((x) => ServiceModel.fromJson(x))),
        gallery: json["Gallery"] == null
            ? []
            : List<dynamic>.from(json["Gallery"].map((x) => x)),
        comments: json["Comments"] == null
            ? []
            : List<CommentModel>.from(
                json["Comments"].map((x) => CommentModel.fromJson(x))),
      );

  /// Converting individual BarberDataFromMapModel object to a JSON object
  Map<String, dynamic> toJson() => {
        "MapData": mapData.toJson(),
        "Services": List<dynamic>.from(services.map((x) => x.toJson())),
        "Gallery": List<dynamic>.from(gallery.map((x) => x)),
        "Comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
