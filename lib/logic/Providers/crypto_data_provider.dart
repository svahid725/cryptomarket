
import 'package:crypto_currency/data/data_source/api.dart';
import 'package:crypto_currency/data/data_source/response_model.dart';
import 'package:crypto_currency/data/models/AllCryptoModel.dart';
import 'package:crypto_currency/data/repositories/crypto_data_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryptoDataProvider extends ChangeNotifier {
  CryptoDataRepository repository = CryptoDataRepository();
  ApiCallProvider apiCallProvider = ApiCallProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading('loading...');
    try {
      Response response = await ApiCallProvider().getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('please try again');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('something went wrong!');
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading('loading...');
    try{
        dataFuture = await repository.getTopGainersData();
        state = ResponseModel.completed(dataFuture);
        notifyListeners();
      }
    catch (e) {
      state = ResponseModel.error('something went wrong!');
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loading('loading...');
    try {
      Response response = await ApiCallProvider().getTopLosersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('please try again');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('something went wrong!');
      notifyListeners();
    }
  }
}
