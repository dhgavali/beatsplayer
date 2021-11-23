import 'package:flutter/material.dart';

class Loadings {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key,
      {String msg = "Searching Music.."}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.white,
            children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(
                    color: Colors.blueGrey.shade400,
                    // backgroundColor: Colors.blueGrey.shade400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
              )
            ],
          ),
        );
      },
    );
  }
}

//How To show loading
//1. declare the key 
//key to define
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();

//2.  call the function to show loading
//  Loadings.showLoadingDialog(context, _keyLoader);
//3. to close the loading
// Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();




//to close the delete screen 
//  Navigator.of(_deleteWindow.currentContext,rootNavigator: true).pop();
