import 'package:flutter/material.dart';

class Alerts {
  static void showTextSnackBar(BuildContext buildContext, String? text) {
    ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
      content: Text(text ?? "Ocorreu uma falha interna!"),
      action: SnackBarAction(
        label: 'Fechar',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }  

  static Future<void> displayTextDialog(BuildContext buildContext, String text) async {
    return showDialog(
        context: buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text(text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: null,
            actions: <Widget>[
              TextButton(
                child: const Text('Fechar',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(buildContext);
                },
              ),
            ],
          );
        });
  }
}
