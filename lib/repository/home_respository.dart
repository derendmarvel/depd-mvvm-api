import 'package:ongkir_api/data/network/network_api_services.dart';
import 'package:ongkir_api/model/city.dart';
import 'package:ongkir_api/model/costresponse/costresponse.dart';
import 'package:ongkir_api/model/model.dart';

class HomeRespository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      rethrow;
    }
  }
  Future<Costresponse> fetchShippingCost({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        '/starter/cost',
        {
          'origin': origin,
          'destination': destination,
          'weight': weight,
          'courier': courier,
        },
      );

      if (response != null && response['rajaongkir'] != null &&
          response['rajaongkir']['status'] != null &&
          response['rajaongkir']['status']['code'] == 200) {
        
        final results = response['rajaongkir']['results'];
        if (results != null && results.isNotEmpty) {
          // Assuming Costresponse.fromJson() expects a map, not a list element.
          return Costresponse.fromJson(results[0]);
        } else {
          throw Exception("No results found in API response");
        }
      } else {
        // If the response does not have a status code 200 or the structure is different
        throw Exception("Error from API: ${response['rajaongkir']['status']['description']}");
      }
    } catch (e) {
      throw Exception("Error fetching shipping costs: $e");
    }
  }
}
