import 'package:flutter/material.dart';

// Function for adaptive height
getHeight(context, percent){
  return MediaQuery.of(context).size.height * (percent / 100);
}

// Function for adaptive width
getWidth(context, percent){
  return MediaQuery.of(context).size.width * (percent / 100);
}

