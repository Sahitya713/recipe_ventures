import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_ventures/components/ingredient.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  TextEditingController _nameController;
  String _ingredientName;
  DateTime selectedDate;
  String _expiry = '-';
  String _chosenQuantity = '1';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(hours: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _expiry = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  _addIngredient(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Please input ingredient name:",
                        style: Theme.of(context).textTheme.bodyText2),
                    TextField(
                      onChanged: (newName) {
                        // setState(() {
                        //   _ingredientName = newName;
                        // });
                      },
                      controller: _nameController,
                    ),
                    Divider(
                      height: 20,
                    ),
                    Text("Please input expiry date of item:",
                        style: Theme.of(context).textTheme.bodyText2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Expires on $_expiry',
                              style: Theme.of(context).textTheme.caption),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Please input quantity of item:",
                              style: Theme.of(context).textTheme.bodyText2),
                          DropdownButton<String>(
                            value: _chosenQuantity,
                            items: <String>[
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10',
                            ].map<DropdownMenuItem<String>>((String qty) {
                              return DropdownMenuItem<String>(
                                value: qty,
                                child: Text(qty,
                                    style: Theme.of(context).textTheme.caption),
                              );
                            }).toList(),
                            onChanged: (String qty) {
                              setState(() {
                                _chosenQuantity = qty;
                              });
                            },
                          ),
                        ]),
                  ]),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: Text('ok'),
                        onPressed: () {
                          // save ingredient details to db & refresh the store page
                          _nameController.clear();
                          _expiry = '-';
                          _chosenQuantity = '1';
                          Navigator.pop(context);
                        }),
                  ],
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headline6),
      ),
      body: // can use a list view builder to iterate and display
          Column(children: [
        Ingredient(ingredientName: 'egg', chosenQuantity: '10'),
        Ingredient(
          ingredientName: 'chicken',
          chosenQuantity: '2',
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addIngredient(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
