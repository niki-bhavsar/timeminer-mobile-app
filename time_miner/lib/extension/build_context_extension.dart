import 'package:flutter/material.dart';
import 'package:time_miner/l10n/app_localizations.dart';

extension BuidcontextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Future navigate(Widget route) async {
    return Navigator.of(this).push(MaterialPageRoute(builder: (context) => route));
  }

  Future navigateAndReplace(Widget route) async {
    return Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  void showSnackBar(String message, BuildContext context,{Duration? duration} ) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
      behavior: SnackBarBehavior.fixed,
      duration: duration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void hideKeyboard() {
    var scopeNode = FocusScope.of(this);
    if (scopeNode.isFirstFocus) {
      scopeNode.requestFocus(FocusNode());
    }
  }
}
