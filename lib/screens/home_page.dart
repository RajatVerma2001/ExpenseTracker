import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project/provider/itemList_provider.dart';
import 'package:project/provider/item_list.dart';
import 'package:project/screens/addItem.dart';
import 'package:project/screens/product_detail_screen.dart';
import 'package:project/services/router.dart';
import 'package:project/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../constant/kstyle.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

bool isAdd = false;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listData = Provider.of<Items>(context);
    final listItems = listData.items;
    DateTime date = DateTime.now();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addItemID);
          isAdd = true;
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white70),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${date.year}-${date.month.toString().padLeft(2, '0')} Balance',
                          style: kstyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      ' - ${listData.totalExpances.toString()}',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Expences: -${listData.totalExpances.toString()}',
                      style: kstyle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'income 0',
                      style: kstyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Budget Setting',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //Todo:progess bar indicator
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.lightBlue.shade100,
                                        Colors.lightGreen.shade100
                                      ]),
                                ),
                                child: StepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: 50,
                                  size: 10,
                                  padding: 0,
                                  unselectedColor: Colors.blue.shade100,
                                  roundedEdges: const Radius.circular(10),
                                  selectedGradientColor: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromRGBO(238, 238, 238, 1.0),
                                      Color.fromRGBO(96, 9, 100, 1)
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0 && listItems.isNotEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 219, 224, 224),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat.yMMMd().format(date)),
                                Text(
                                    'Total Expances - ${listData.totalExpances}')
                              ],
                            ),
                          );
                        }

                        index -= 1;
                        if (index == -1) return Container();

                        return Dismissible(
                          key: ValueKey(listItems[index].id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 28,
                            ),
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                          ),
                          onDismissed: (direction) {
                            listData.deleteProduct(listItems[index].id!);
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
                          child: ProductItem(
                            date: DateFormat.yMMMd().format(date),
                            remark: listItems[index].remark!,
                            id: listItems[index].id!,
                            img: listItems[index].img!,
                            title: listItems[index].title!,
                            price: listItems[index].price!,
                          ),
                        );
                      },
                      itemCount: listItems == null ? 1 : listItems.length + 1,
                    ),
                  ),
                  // Image.asset("food.png")
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
          activeColor: Colors.deepPurple,
          tabBackgroundColor: const Color.fromARGB(255, 202, 222, 220),
          gap: 8,
          padding: const EdgeInsets.all(16),
          onTabChange: (index) {
            print(index);
          },
          backgroundColor: Colors.white,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'home',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'likes',
            ),
            GButton(
              icon: Icons.search,
              text: 'search',
            ),
            GButton(
              icon: Icons.settings,
              text: 'settting',
            )
          ]),
    );
  }
}

/* 
 LinearPercentIndicator(
                                padding: const EdgeInsets.all(0),
                                animation: true,
                                barRadius: Radius.circular(5),
                                lineHeight: 15,
                                animationDuration: 1000,
                                percent: 0.8,
                                progressColor: Colors.lightBlue
                                 ),
*/