import 'package:crypto_currency/models/AllCryptoModel.dart';
import 'package:crypto_currency/network/api.dart';
import 'package:crypto_currency/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryptoDataProvider extends ChangeNotifier {
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
    try {
      Response response = await ApiCallProvider().getTopGainersData();
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
