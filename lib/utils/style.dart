import 'package:flutter/material.dart';

BoxDecoration inputDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.grey.shade200,
    width: 1,
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 6.0,
    ),
  ],
  borderRadius: BorderRadius.circular(8),
);

BoxDecoration inputDecorationRed = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.grey.shade200,
    width: 1,
  ),
  boxShadow:  [
    BoxShadow(
      color: Colors.red.shade400,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 6.0,
    ),
  ],
  borderRadius: BorderRadius.circular(8),
);

BoxDecoration inputDecorationBlue = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.grey.shade200,
    width: 1,
  ),
  boxShadow:  [
    BoxShadow(
      color: Colors.blue,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 10.0,
    ),
  ],
  borderRadius: BorderRadius.circular(8),
);

Shadow redShadow=Shadow(
  color: Colors.red.shade400,
  offset: Offset(0.0, 1.0), //(x,y)
  blurRadius: 6.0,
);

TextStyle smallAndGreyText=const TextStyle(
  color: Colors.grey,
  fontFamily: "Schyler",
  fontSize: 14,
);
