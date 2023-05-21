

import 'package:crypto_currency/models/AllCryptoModel.dart';
import 'package:crypto_currency/network/api.dart';
import 'package:crypto_currency/network/response_model.dart';
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

      print(e.toString());
    }
  }



}