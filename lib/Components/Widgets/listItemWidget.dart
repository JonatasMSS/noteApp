// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({super.key});

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget>
    with TickerProviderStateMixin {
  late double sizeH;
  late bool isVisible;
  late AnimationController iconAnimation;
  late bool isActive; // Bool for animation

  @override
  initState() {
    super.initState();
    sizeH = 50;
    isVisible = false;
    isActive = false;
    iconAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 150),
    );
  }

  changeSizeAndVisibility() {
    sizeH = sizeH == 50 ? 500 : 50;
    isVisible = isVisible ? false : true;
    isActive = !isActive;
    isActive ? iconAnimation.forward() : iconAnimation.reverse();
  }

  //Variável de tamanho do container
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromARGB(255, 212, 211, 211),
            )
          ]),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(
        minHeight: 100,
        minWidth: double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: sort_child_properties_last
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Titulo Nota",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: AnimatedIcon(
                  progress: iconAnimation,
                  icon: AnimatedIcons.menu_arrow,
                ),
                onPressed: () => setState(() => changeSizeAndVisibility()),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 350),
            constraints: BoxConstraints(
              minHeight: sizeH,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Container"),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Visibility(
            visible: isVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.delete_forever),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
