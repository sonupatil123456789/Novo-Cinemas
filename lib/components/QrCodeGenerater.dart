import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerater extends StatelessWidget {
  final double qrSize;
  final dynamic data ;
  final Color? qrColour ;

  const QrCodeGenerater({super.key,
    required this.qrSize,
    required this.data,
    this.qrColour
  });

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,

      version: QrVersions.auto,
      size: qrSize,
      // backgroundColor: Colors.lightBlueAccent,
      dataModuleStyle: QrDataModuleStyle(color: qrColour ?? context.colorPalette.accentColor,dataModuleShape: QrDataModuleShape.square),
      eyeStyle: QrEyeStyle(color: qrColour ?? context.colorPalette.accentColor,eyeShape: QrEyeShape.square),

    );
  }
}
