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
  'BCH',
];

const bitcoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //Step 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    Map<String, String> cryptoPrices = {}; // create Map to store cryptoCurrency/ExchangeValue Pairs
    for (String crypto in cryptoList) {
      //Step 5: Return a Map of the results instead of a single value.
      String requestURL = '$bitcoinAverageURL/$crypto$selectedCurrency'; // change BTC to $crypto
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['last'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0); // <- this is important !!! use map key to assign value
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices; // return the entire map OUTSIDE FOR LOOP!
  }
}
