import 'package:flutter/material.dart';
import 'dart:math' as math;


const mobileBackgroundColor = Color.fromRGBO(245, 244, 244, 1);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(202, 200, 200, 1);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Color.fromARGB(255, 27, 25, 25);
const secondaryColor = Colors.grey;
var appbarcolor = <Color>[
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(math.Random().nextDouble()),
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(math.Random().nextDouble()),
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(math.Random().nextDouble()),
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(math.Random().nextDouble()),
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(math.Random().nextDouble()),
                      ];
