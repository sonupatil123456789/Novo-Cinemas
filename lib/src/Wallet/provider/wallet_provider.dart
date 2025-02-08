import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/constants/ApiUrlConstants.dart';
import 'package:novocinema/core/constants/DatabaseKeyConstants.dart';
import 'package:novocinema/core/resources/SeassionManager.dart';
import 'package:novocinema/src/Wallet/models/top_up_model.dart';
import 'package:novocinema/src/Wallet/models/wallet_balance_model.dart';
import 'package:novocinema/src/Wallet/models/wallet_transaction_model.dart';

class WalletProvider extends ChangeNotifier {
  List<WalletTransactionModel> transactions = [];
  WalletBalance? balance;

  bool isAddMoney = false;

  void setIsAddMoney(bool value) {
    isAddMoney = value;
    notifyListeners();
  }

  bool isFetchingBalance = false;

  Future<void> getWalletBalance() async {
    print("Inside getWalletBalance");
    try {
      isFetchingBalance = true;
      notifyListeners();

      final token = await SeassionManager().getAccessToken(TOKEN);

      print(
          "URL: ${ApiUrlConstants.BASE_URL + ApiUrlConstants.getWalletBalance}");

      final response = await Dio()
          .get(ApiUrlConstants.BASE_URL + ApiUrlConstants.getWalletBalance,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      print("Response: $response");
      print("response.data ==============> ${response.data}");
      if (response.statusCode == 200) {
        balance = WalletBalance.fromJson(response.data['data']);

        print("balance ==============> ${balance?.balanceAmount}");
        print("balance ==============> ${balance?.toJson()}");
      }

      isFetchingBalance = false;
      notifyListeners();
    } catch (e) {
      isFetchingBalance = false;
      notifyListeners();
    }
  }

  bool isFetchingTransactions = false;

  Future<void> getWalletTransactions() async {
    print("Inside getWalletTransactions");
    try {
      isFetchingTransactions = true;
      notifyListeners();

      final token = await SeassionManager().getAccessToken(TOKEN);

      final response = await Dio()
          .get(ApiUrlConstants.BASE_URL + ApiUrlConstants.getWalletTransactions,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      print("Response: $response");
      print("transactions.data ==============> ${response.data['data']}");
      transactions.clear();
      if (response.statusCode == 200) {
        for (var item in response.data['data']) {
          transactions.add(WalletTransactionModel.fromJson(item));
          print("transactions ==============> ${transactions}");
        }

        print("transactions ==============> ${transactions}");
      }
      isFetchingTransactions = false;
      notifyListeners();
    } catch (e) {
      isFetchingTransactions = false;
      notifyListeners();
    }
  }

  bool isToppingUpWallet = false;

  Future<bool> topUpWallet(int amount, String cinemaId, String itemId) async {
    print("Inside topUpWallet");
    try {
      isToppingUpWallet = true;
      notifyListeners();

      final token = await SeassionManager().getAccessToken(TOKEN);

      final amountInCents = amount * 100;

      final topUpModel = TopUpModelRequest(
        cinemaId: cinemaId,
        itemId: itemId,
        variablePriceInCents: amountInCents,
      );

      final response = await Dio().post(
        ApiUrlConstants.BASE_URL + ApiUrlConstants.topUpWalletBalance,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: topUpModel.toJson(),
      );

      print("Response: $response");

      if (response.statusCode == 200) {
        final topUpModelResponse = TopUpModelResponse.fromJson(response.data);
        print("topUpModelResponse: $topUpModelResponse");
        final result =
            await completeOrder(topUpModelResponse.data.reservationId);
        return result;
      }
      isToppingUpWallet = false;
      notifyListeners();
      return false;
    } catch (e) {
      isToppingUpWallet = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeOrder(String reservationId) async {
    isToppingUpWallet = true;
    notifyListeners();
    print("Inside completeOrder");
    try {
      final token = await SeassionManager().getAccessToken(TOKEN);

      final response = await Dio().post(
        ApiUrlConstants.BASE_URL + ApiUrlConstants.completeWalletTopUp,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'reservationId': reservationId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }

      isToppingUpWallet = false;
      notifyListeners();
      return false;
    } catch (e) {
      isToppingUpWallet = false;
      notifyListeners();
      return false;
    }
  }
}
