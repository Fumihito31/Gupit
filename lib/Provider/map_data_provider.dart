import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/map_data_model.dart';

/// MapDataProvider is the provider of MapDataModel List 
/// that can notify changes to the whole list.
class MapDataProvider with ChangeNotifier {
  List<MapDataModel>? mapDataList; // Made nullable to support null safety

  /// Constructor, will load the list by making the necessary request.
  MapDataProvider() {
    loadData();
  }

  /// Method that loads the list with the MapDataModel objects requested from API.
  Future<void> loadData() async {
    final _mapjson =
        await rootBundle.loadString('lib/Temporary_data/map_data.json');
    final _parsed = json.decode(_mapjson).cast<Map<String, dynamic>>();
    mapDataList = _parsed
        .map<MapDataModel>((json) => MapDataModel.fromJson(json))
        .toList();

    notifyListeners();
  }

  @override
  String toString() {
    return mapDataList?.toString() ?? 'No data loaded';
  }

  /// Method will return a List consisting of a Map with 2 fields:
  /// name - name of marker on map, location - coordinates of the marker.
  List<Map<String, dynamic>> get coordinates {
    if (mapDataList == null) {
      return []; // Return an empty list if mapDataList is null
    }

    List<Map<String, dynamic>> _coordinates = []; // Initialize the list
    for (var item in mapDataList!) { // Use null assertion operator
      _coordinates.add({
        "name": item.name,
        "location": item.location,
      });
    }
    return _coordinates;
  }

  /// Method will return the complete list of MapDataModel objects.
  List<MapDataModel> get completeData {
    return mapDataList ?? []; // Return an empty list if mapDataList is null
  }

  /// Method will return a single MapDataModel object from the complete list
  /// where the name field of the MapDataModel object matches with the name provided.
  MapDataModel singleComplete(String name) {
    final foundItem = mapDataList?.singleWhere(
      (element) => element.name == name,
      orElse: () => throw Exception('MapDataModel not found: $name'),
    );
    return foundItem!;
  }
}
