import 'package:flutter/material.dart';

import '../styles/colors.dart';


 class DropDownList extends StatelessWidget {
  // const DropDownList({Key? key}) : super(key: key);
  Map ItemMap ;
  String val ;
 Function onChang ;
  DropDownList({ required this.ItemMap,required this.val,required this.onChang});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal:20,vertical: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Primarycolor, width:3),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            underline: SizedBox(),
            isExpanded: true,
            iconEnabledColor: Primarycolor,
            items: ItemMap.keys.toList().map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: ItemMap[value],
                child: Text(ItemMap[value]!),
              );
            }).toList(),
            onChanged: (value) {
              onChang(ItemMap, value.toString());
            },
            value:val,
          ),
        ),
      ),
    );
  }

}
