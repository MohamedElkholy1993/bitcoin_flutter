import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '067755A1-98E4-4B59-8BA1-8959E5AFE828';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    Map<String,String> results = {};

    for (String cryptoCurrency in cryptoList){
      String url = '$coinAPIURL/$cryptoCurrency/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200){
        var data = response.body;
        var lastPrice = jsonDecode(data)['rate'];
        results[cryptoCurrency] = lastPrice.toStringAsFixed(0);
      }else{
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return results;

  }
}
