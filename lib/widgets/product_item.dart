import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../provider/item_list.dart';

class ProductItem extends StatelessWidget {
  final Image img;
  final String id;
  final String title;
  final double price;
  final String date;
  final String remark;

  const ProductItem({
    Key? key,
    required this.remark,
    required this.id,
    required this.date,
    required this.img,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                    productId: id,
                    date: date,
                    img: img,
                    title: title,
                    remark: remark,
                    price: price,
                  )));
        },
        child: Card(
          margin: const EdgeInsets.all(0.2),
          child: ListTile(
            leading: CircleAvatar(
              child: img,
            ),
            title: Text(title),
            trailing: Text(price.toString()),
          ),
        ),
      ),
    );
  }
}
