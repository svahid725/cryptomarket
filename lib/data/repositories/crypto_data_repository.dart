
import 'package:crypto_currency/data/data_source/response_model.dart';
import 'package:dio/dio.dart';

import '../models/AllCryptoModel.dart';
import '../data_source/api.dart';

class CryptoDataRepository{
  ApiCallProvider apiCallProvider = ApiCallProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  late Response response;

  Future<AllCryptoModel> getTopGainersData() async {
     response = await ApiCallProvider().getTopGainersData();
     if (response.statusCode == 200){
      dataFuture = AllCryptoModel.fromJson(response.data);
    }
    return dataFuture;
  }

}