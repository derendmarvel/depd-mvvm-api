import 'package:flutter/material.dart';
import 'package:ongkir_api/data/response/api_response.dart';
import 'package:ongkir_api/model/city.dart';
import 'package:ongkir_api/model/model.dart';
import 'package:ongkir_api/repository/home_respository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRespository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }
}
