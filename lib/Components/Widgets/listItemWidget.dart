// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({super.key});

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
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
      constraints: const BoxConstraints(
        minHeight: 100,
        minWidth: double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                icon: Icon(Icons.arrow_drop_down_circle),
                onPressed: () => {},
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 50,
            child: Text("Container"),
          ),
          Row(
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
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
