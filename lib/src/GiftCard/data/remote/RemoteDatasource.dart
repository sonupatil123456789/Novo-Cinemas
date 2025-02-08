
import 'package:novocinema/src/GiftCard/data/dto/AllGiftCardDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/GetCardBalanceDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/SendReceivedDataDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/SendReceivedGiftCardDto.dart';

import '../../../../core/resources/ResponseData.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';


abstract interface class GiftCardRemoteDatasource {

   Future<ResponseData<AllGiftCardDto>> getAllGiftCard();

   Future<ResponseData<Map<String,dynamic>>> buyGiftCard(Map<String, dynamic> data);

   Future<ResponseData<GetCardBalanceDto>> getGiftCardBalance(String cardNumber);

   Future<ResponseData<Map<String,dynamic>>> topUpGiftCard(Map<String, dynamic> data);

   Future<ResponseData<SendReceivedGiftCardDto>> sendReceivedGiftCard();


}






