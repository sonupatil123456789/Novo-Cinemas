package com.novo.cinemas


import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity()
//{
//    private val CHANNEL = "com.novo.cinemas/payment_gateway_integration"
//
//
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        // Set up the MethodChannel with the same name as defined in Dart
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {  call, result ->
//            if (call.method == "initPaymentGatewayService") {
//                initialiseGatewaySDK(call.arguments, result)
//            }
//            else if (call.method == "updateSession") {
//                updateSession(call.arguments, result)
//            }
//            else {
//                result.notImplemented()
//            }
//        }
//
//
//    }
//
//}
//
//fun updateSession(arguments: Any?, result: MethodChannel.Result) {
//    // Extract and cast arguments from MethodChannel
//    val args = arguments as? Map<*, *>
//    val name = args?.get("nameOnCard") as? String ?: ""
//    val number = args?.get("number") as? String ?: ""
//    val expiryMonth = args?.get("month") as? String ?: ""
//    val expiryYear = args?.get("year") as? String ?: ""
//    val cvv = args?.get("securityCode") as? String ?: ""
//    val sessionId = args?.get("sessionId") as? String ?: ""
//    val currency = args?.get("currency") as? String ?: ""
//    val amount = args?.get("amount") as? String ?: ""
//    val orderId = args?.get("orderId") as? String ?: ""
//    val apiVersion = args?.get("apiVersion") as? String ?: ""
//
//    // The GatewayMap object provides support for building a nested map structure using key-based dot(.) notation.
//    // Each parameter is similarly defined in your online integration guide.
//    val request = GatewayMap().apply {
//        set("sourceOfFunds.provided.card.nameOnCard", name)
//        set("sourceOfFunds.provided.card.number", number)
//        set("sourceOfFunds.provided.card.securityCode", cvv)
//        set("sourceOfFunds.provided.card.expiry.month", expiryMonth)
//        set("sourceOfFunds.provided.card.expiry.year", expiryYear)
//    }
//    // Prepare session object
//    val session = Session(sessionId, amount, currency, apiVersion, orderId)
//
//    // Call the API
//    GatewayAPI.updateSession(session, request, callback)
//}
//
//fun initialiseGatewaySDK(arguments: Any?, result: MethodChannel.Result) {
//    // Extract and cast arguments
//    val args = arguments as? Map<*, *>
//    val merchantId = args?.get("merchantId") as? String ?: ""
//    val merchantName = args?.get("merchantName") as? String ?: ""
//    val merchantUrl = args?.get("merchantUrl") as? String ?: ""
//    val region = args?.get("region") as? String ?: ""
//
//    // Convert region string to GatewayRegion enum
//    val gatewayRegion = GatewayRegion.valueOf(region)
//
//    // Initialize the GatewaySDK
//    GatewaySDK.initialize(application, merchantId, merchantName, merchantUrl, gatewayRegion, UiCustomization(),
//        success = { response ->
//           result.success(response)
//        },
//        error = { throwable ->
//            result.error("error", throwable.message, throwable)
//        }
//    )
//}