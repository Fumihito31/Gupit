import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../core/comment_model.dart';
import '../core/barber_data_from_map_model.dart';
import '../core/service_model.dart';

/// BarberDataFromMapProvider is the provider of BarberDataFromMapModel List 
/// that can notify changes to the whole list. 
/// This list has elements based on the MapDataProvider List, only the elements 
/// that were marked on the Map will be fetched from here.
class BarberDataFromMapProvider with ChangeNotifier {
  List<BarberDataFromMapModel>? _barberdatalist;

  /// Constructor, it will load the necessary data into the BarberDataFromMapList
  BarberDataFromMapProvider() {
    loadData();
  }

  /// Future method, it is responsible for loading data from the JSON file into 
  /// the Model object and then into the list.
  Future<void> loadData() async {
    final _mapjson = await rootBundle
        .loadString('lib/Temporary_data/barber_data_from_map.json');
    final parsed = json.decode(_mapjson).cast<Map<String, dynamic>>();
    _barberdatalist = parsed
        .map<BarberDataFromMapModel>(
            (json) => BarberDataFromMapModel.fromJson(json))
        .toList();
    notifyListeners(); // Notify listeners after loading data
  }

  @override
  String toString() {
    return _barberdatalist?.toString() ?? 'No data loaded';
  }

  /// Get method to get the complete BarberDataList
  List<BarberDataFromMapModel> get barberDataList {
    return _barberdatalist ?? []; // Return an empty list if null
  }

  /// Method to return the list of services that the particular store offers,
  /// yields a single ServiceModel object based on the storeName provided.
  List<ServiceModel> barberDataServices({required String storeName}) {
    final store = _barberdatalist?.singleWhere(
      (element) => element.mapData.name == storeName,
      orElse: () => throw Exception('Store not found: $storeName'),
    );

    return store?.services ?? []; // Return an empty list if store is null
  }

  /// Method to return the list of comments that consumers wrote for a 
  /// particular store, yields a single CommentModel object based on 
  /// the storeName provided.
  List<CommentModel> barberDataComments({required String storeName}) {
    final store = _barberdatalist?.singleWhere(
      (element) => element.mapData.name == storeName,
      orElse: () => throw Exception('Store not found: $storeName'),
    );

    return store?.comments ?? []; // Return an empty list if store is null
  }

  /// Method to return the list of photos that the particular store uploaded 
  /// to its gallery, yields a single Gallery object based on the 
  /// storeName provided.
  List<dynamic> barberDataGallery({required String storeName}) {
    final store = _barberdatalist?.singleWhere(
      (element) => element.mapData.name == storeName,
      orElse: () => throw Exception('Store not found: $storeName'),
    );

    return store?.gallery ?? []; // Return an empty list if store is null
  }
}
