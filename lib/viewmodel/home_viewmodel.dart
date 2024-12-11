import 'package:flutter/material.dart';
import 'package:ongkir_api/data/response/api_response.dart';
import 'package:ongkir_api/model/city.dart';
import 'package:ongkir_api/model/costresponse/costresponse.dart';
import 'package:ongkir_api/model/model.dart';
import 'package:ongkir_api/repository/home_respository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRespository();

  // Origin
  ApiResponse<List<Province>> originProvinceList = ApiResponse.loading();
  ApiResponse<List<City>> originCityList = ApiResponse.notStarted();

  // Destination
  ApiResponse<List<Province>> destinationProvinceList = ApiResponse.loading();
  ApiResponse<List<City>> destinationCityList = ApiResponse.notStarted();

  // New property for shipping costs
  ApiResponse<List<Costresponse>> shippingCostList = ApiResponse.notStarted();

  // Methods for Origin
  setOriginProvinceList(ApiResponse<List<Province>> response) {
    originProvinceList = response;
    notifyListeners();
  }

  Future<void> getOriginProvinceList() async {
    setOriginProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setOriginProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOriginProvinceList(ApiResponse.error(error.toString()));
    });
  }

  setOriginCityList(ApiResponse<List<City>> response) {
    originCityList = response;
    notifyListeners();
  }

  Future<void> getOriginCityList(var provId) async {
    setOriginCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setOriginCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOriginCityList(ApiResponse.error(error.toString()));
    });
  }

  // Methods for Destination
  setDestinationProvinceList(ApiResponse<List<Province>> response) {
    destinationProvinceList = response;
    notifyListeners();
  }

  Future<void> getDestinationProvinceList() async {
    setDestinationProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setDestinationProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDestinationProvinceList(ApiResponse.error(error.toString()));
    });
  }

  setDestinationCityList(ApiResponse<List<City>> response) {
    destinationCityList = response;
    notifyListeners();
  }

  Future<void> getDestinationCityList(var provId) async {
    setDestinationCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setDestinationCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDestinationCityList(ApiResponse.error(error.toString()));
    });
  }

  setShippingCostList(ApiResponse<List<Costresponse>> response) {
    shippingCostList = response;
    notifyListeners();
  }

  Future<void> calculateOngkir({
      required String origin,
      required String destination,
      required int weight,
      required String courier,
    }) async {
      setShippingCostList(ApiResponse.loading());
      notifyListeners();
      try {
        final Costresponse costs = await _homeRepo.fetchShippingCost(
          origin: origin,
          destination: destination,
          weight: weight,
          courier: courier,
        );
        setShippingCostList(ApiResponse.completed([costs]));
      } catch (e) {
        setShippingCostList(ApiResponse.error("Error fetching shipping costs: $e"));
      } finally {
      notifyListeners(); // Notify the UI again for "completed" or "error" states
      }
    }
}