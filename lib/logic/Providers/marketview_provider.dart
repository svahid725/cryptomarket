

import 'package:crypto_currency/data/data_source/api.dart';
import 'package:crypto_currency/data/data_source/response_model.dart';
import 'package:crypto_currency/data/models/AllCryptoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class MarketViewProvider extends ChangeNotifier{
  ApiCallProvider apiProvider = ApiCallProvider();

  late AllCryptoModel dataFuture;

  late ResponseModel state;
  var response;


  getCryptoData() async {

    // start loading api
    state = ResponseModel.loading("is loading...");
    // notifyListeners();

    try{
      response = await apiProvider.getAllCryptoData();
      if(response.statusCode == 200){
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("something wrong please try again...");
      }
      notifyListeners();
    }catch(e){
      state = ResponseModel.error("please check your connection...");
      notifyListeners();

    }
  }



}