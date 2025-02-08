import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:novocinema/firebase_options.dart';
import 'package:novocinema/src/Wallet/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'Application.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Branch.io deep linking initialisation
  await FlutterBranchSdk.init(enableLogging: false, disableTracking: false);
  // FlutterBranchSdk.validateSDKIntegration();

  // Firebase initialisation
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Onesignal Notification service initialisation
  // OneSignal.Debug.setLogLevel(OSLogLevel.none);
  // OneSignal.initialize(oneSignalAppId);
  // OneSignal.Notifications.requestPermission(true);
  // OneSignal.consentRequired(false);

  init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => WalletProvider()),
  ], child: const Application()));
}
