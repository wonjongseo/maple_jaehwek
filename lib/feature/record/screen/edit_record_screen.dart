import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:every_maple/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ItemCategory {
  crystalJam('젬 스톤', 'crystalJam.png'),
  solErdaFragment('솔 에르다 조각', 'SolErdaFragment.png'),
  meso('메소', 'meso.png');

  final String label;
  final String imgName;

  const ItemCategory(this.label, this.imgName);
}

class EditRecordController extends GetxController {}

class EditRecordScreen extends StatelessWidget {
  const EditRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text('일자'),
                trailing: CustomTextFormField(
                  height: 40,
                  width: size.width * .4,
                  widget: IconButton(
                      onPressed: () {}, icon: Icon(Icons.calendar_month)),
                ),
              ),

              // DropdownButton2(
              //     onChanged: (v) {},
              //     items: ItemCategory.values
              //         .map((item) => DropdownMenuItem(
              //             value: item,
              //             child: Row(
              //               children: [
              //                 Image.asset(
              //                   'assets/images/${item.imgName}',
              //                   width: 40,
              //                 ),
              //                 SizedBox(width: 20),
              //                 Text(item.label)
              //               ],
              //             )))
              //         .toList()),
              ...List.generate(ItemCategory.values.length, (index) {
                ItemCategory item = ItemCategory.values[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/images/${item.imgName}',
                    width: 40,
                  ),
                  title: Text(item.label),
                  trailing: SizedBox(
                    width: size.width * .4,
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextFormField(
                          height: 40,
                        ))
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
