import 'package:flutter/material.dart';

class CustomDialogExample extends StatelessWidget {
  final List info;
  const CustomDialogExample({super.key,required this.info});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color:  Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close, color: Color(0xFF212121))),
            ),
             Text(info[0],
                style: const TextStyle(color: Color(0xFF212121), fontSize: 24)),
             Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                  info[1],
                  style: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
