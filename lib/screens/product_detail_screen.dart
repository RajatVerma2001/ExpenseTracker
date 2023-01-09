import 'package:flutter/material.dart';
import 'package:project/provider/item_list.dart';
import 'package:project/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import '../provider/itemList_provider.dart';
import 'home_page.dart';
import 'package:project/widgets/product_item.dart';

class ProductDetailScreen extends StatelessWidget {
  final String date;
  final String productId;
  final Image img;
  final String title;
  final double price;
  final String remark;
  const ProductDetailScreen({
    Key? key,
    required this.productId,
    required this.remark,
    required this.date,
    required this.img,
    required this.price,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: isAdd ? Text('Add') : Text('Detail'),
          actions: [
            if (isAdd)
              Dismissible(
                key: ValueKey(productId),
                direction: DismissDirection.down,
                onDismissed: (directon) {
                  Provider.of<Items>(context, listen: false)
                      .deleteProduct(productId);
                  Navigator.of(context).pop();
                },
                confirmDismiss: (direction) {
                  return showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Are you Sure? '),
                            content: const Text(
                                'Do you want to delete this product'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('yes')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('No')),
                            ],
                          ));
                },
                child: IconButton(
                    onPressed: () {
                      Provider.of<Items>(context, listen: false)
                          .deleteProduct(productId);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.delete)),
              )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: SizedBox(
                  height: 330,
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomListTile(img, title, price.toString()),
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        CustomIcon(Icons.category, 'Category', 'Expances'),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        CustomIcon(
                            Icons.calendar_month, 'Date', date.toString()),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        CustomIcon(Icons.edit_note_sharp, 'Remark', remark),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(EditScreen.routeName, arguments: productId);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                ),
              )
            ],
          ),
        ));
  }

  Padding CustomIcon(IconData icon, String title, String trailingText) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            size: 40,
            color: Colors.black,
          ),
        ),
        title: Text(title),
        trailing: Text(trailingText),
      ),
    );
  }
}

Widget CustomListTile(Image img, String title, String trailing) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.white,
      child: img,
      radius: 25,
    ),
    title: Text(title),
    trailing: Text(
      trailing,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}
