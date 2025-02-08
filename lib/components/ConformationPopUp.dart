import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

import 'CustomButton.dart';

Future<bool> conformationPopUp(
    {required BuildContext context,
    required String title,
    required String content,
    required Function onYes}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, style: context.textThemeDecoration.titleSmall,),
      content: Text(content ,style: context.textThemeDecoration.paragraphLarge,),
      actions: <Widget>[
        CustomButton(
          height: context.getScreenHeight(5),
          backgroundColor: context.colorPalette.transparentColor,
          text: 'No',
          textColor: context.colorPalette.accentColor,
          onTap: () async {
            Navigator.of(context).pop(false);
          },
          borderColor:Border.all(color: context.colorPalette.accentColor, width: 2.0),
          width: context.getScreenWidth(16),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomButton(
          height: context.getScreenHeight(5),
          backgroundColor: context.colorPalette.accentColor,
          text: 'Yes',
          textColor: context.colorPalette.darkGreyColor,
          onTap: () async {
            await onYes();
            Navigator.of(context).pop(true);
          },
          width: context.getScreenWidth(20),
        ),
      ],
    ),
  );
}

Future<bool> deletePopUp(BuildContext context, String title, String content,
    Function onDelete) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await onDelete();
            Navigator.of(context).pop(true);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
