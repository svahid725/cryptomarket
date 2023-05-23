import 'package:dio/dio.dart';

class ApiCallProvider {
  dynamic getTopMarketCapData() async {
    Response response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=50&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  dynamic getAllCryptoData() async {
    final response = await Dio().get(
      "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=200&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap",
    );
    return response;
  }

  getTopGainersData() async {
    var response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=50&sortBy=percent_change_24h&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  getTopLosersData() async {
    final Response response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=50&sortBy=percent_change_24h&sortType=asc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  callRegisterApi({
    required String name,
    required String email,
    required String password,
  })async {
    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password
    });
    final Response response =await Dio().post(
      'https://besenior.ir/api/register',
      data: formData
    );
    return response;
  }
}
