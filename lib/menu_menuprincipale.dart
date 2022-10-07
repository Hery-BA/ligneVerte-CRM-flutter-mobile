import 'package:flutter/material.dart';
import 'interface/project.dart';
// ignore: must_be_immutable
class Aspect extends StatelessWidget {
  String image;
  String text;
  var tap;
  
  Aspect({Key? key, required this.image,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(159, 42, 42, 44),
                              ),
                              child: Column(
                                children: [
                                Image.asset(image,
                                width: 120,
                                height: 120,),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(text,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                )
                              ],
                              ),
                            );

  }
}