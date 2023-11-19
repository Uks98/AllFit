import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/sport_text_control_contoller.dart';

class SelectedList extends StatefulWidget {
  int selectIndex;
  String selectedText;
  List<String> list;
   SelectedList({super.key,required this.selectIndex,required this.selectedText,required this.list});

  @override
  State<SelectedList> createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList> {
  final _textController = Get.put(SportControlListController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx,index){
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectIndex = index;
                  _textController.selectedText.value = widget.list[index];
                });
              },
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                  color: widget.selectIndex == index ? Colors.amber : Colors.grey[300],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: widget.list[index].text.make()),
              ),
            );

          }, separatorBuilder: (context,index){
        return SizedBox(width: 5,);
      }, itemCount: widget.list.length),
    );
  }
}
