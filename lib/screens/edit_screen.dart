import 'package:flutter/material.dart';
import 'package:project/constant/kstyle.dart';
import 'package:provider/provider.dart';
import '../provider/itemList_provider.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  static String routeName = 'editscreen';
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var date = null;
  var time = TimeOfDay.now();

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (newTime != null && newTime != TimeOfDay.now()) {
      setState(() {
        time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String?;
    final productFile = Provider.of<Items>(context);
    final product =
        productFile.items.firstWhere((element) => element.id == productId);
    final productDate = DateFormat('EEEE d MMM y').format(product.date!);
    final productTime = time.format(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_outline),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Material(
            elevation: 10,
            child: Container(
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //Todo: Add Bottom Navigation  to change image
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        child: product.img,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          '=',
                          style: whiteColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              // margin: EdgeInsets.all(2),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      pickDate(context);
                      Provider.of<Items>(context, listen: false)
                          .updateDate(productId!, date);
                    },
                    child: CustomIcon(
                        Icons.calendar_month, ' Date ', productDate.toString(),
                        trailIcon: Icons.keyboard_arrow_right),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () async {
                      pickTime(context);
                    },
                    child: CustomIcon(
                        Icons.access_time, 'Time ', productTime.toString(),
                        trailIcon: Icons.keyboard_arrow_right),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomIcon(Icons.edit, ' ', 'Remarks',
                        trailIcon: Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget CustomIcon(IconData icon, String startingText, String title,
    {IconData? trailIcon}) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
      ),
      title: Row(
        children: [
          Text(startingText,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(title)
        ],
      ),
      trailing: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 15,
        child: Icon(
          trailIcon,
          size: 25,
          color: Colors.black,
        ),
      ),
    ),
  );
}
