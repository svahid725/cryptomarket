
import 'package:crypto_currency/data/data_source/api.dart';
import 'package:crypto_currency/data/data_source/response_model.dart';
import 'package:crypto_currency/data/models/user_model.dart';

import 'package:flutter/material.dart';


class UserDataProvider extends ChangeNotifier{
  ApiCallProvider apiProvider = ApiCallProvider();

  late dynamic dataFuture;
  ResponseModel? registerStatus;
  var loginStatus;
  var error;
  var response;

  callRegisterApi(name, email, password) async {

    // start loading api
    registerStatus = ResponseModel.loading("is loading...");
    notifyListeners();

    try{
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name: name, email: email, password: password);
      if(response.statusCode == 201){
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);

        // have validate error
      }else if(response.statusCode == 200){
        dataFuture = ApiStatus.fromJson(response.data);
        registerStatus = ResponseModel.error(dataFuture.message);
      }
      notifyListeners();

    }catch(e) {
      // catch any error and show error
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

// callLoginApi(email, password) async {
//
//   loginStatus = Status.LOADING;
//   notifyListeners();
//
//
//   try{
//     response = await apiProvider.loginApi(email, password);
//     if(response.statusCode == 201){
//       dataFuture = UserModel.fromJson(response.data);
//       loginStatus = Status.COMPLETED;
//     }else{
//       dataFuture = ApiStatus.fromJson(response.data);
//       loginStatus = Status.ERROR;
//       error = dataFuture.message;
//     }
//
//     notifyListeners();
//
//
//   }catch(e) {
//     loginStatus = Status.ERROR;
//     error = "please check your connection...";
//     notifyListeners();
//
//     print(e.toString());
//   }
// }

// @override
// void dispose() {
//   loginStatus = null;
// }
}