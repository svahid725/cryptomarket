
import 'package:crypto_currency/models/AllCryptoModel.dart';

class ResponseModel {
  late Status status;
  late dynamic data;
  late String message ;

  ResponseModel.loading(this.message) : status = Status.LOADING;
  ResponseModel.completed(this.data) : status = Status.COMPLETED;
  ResponseModel.error(this.message) : status = Status.ERROR;


  @override
  String toString(){
    return 'Status: $status \n Message: $message \n Data: $data';
  }
}
enum Status {LOADING, COMPLETED, ERROR}