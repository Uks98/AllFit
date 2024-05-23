import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';
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
              child: VxBox(child: Center(child: widget.list[index].text.make(),)
              ).width(80).color(widget.selectIndex == index ? Colors.amber : Colors.grey,).withRounded(value: 15).make(),
            );
          }, separatorBuilder: (context,index){
        return WidthBox(smallWidth);
      }, itemCount: widget.list.length),
    );
  }
}
