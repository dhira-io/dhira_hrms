import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ShowAlertdialogue(context, contentmsg) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('HRMS',
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
          ),
          content: Text(
            contentmsg!,
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff18bbee)),
              ),
            )
          ],
        );
      });
}
