import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_ventures/components/ingredient.dart';
import 'package:recipe_ventures/pages/recipeslist.dart';

import '../main.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  TextEditingController _nameController;
  TextEditingController _quantityController;
  DateTime selectedDate;
  String _expiry = '-';
  String _chosenUnit = 'units';
  bool _checkboxVisible = false;
  String recipeGetter = 'Generate Recipes';
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _expiry = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  _addIngredient(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
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
                            Text('Expires on $_expiry', style: Theme.of(context).textTheme.caption),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: () => _selectDate(context),
                            ),
                          ]
                      ),
                      Text("Please input quantity of ingredient:",
                          style: Theme.of(context).textTheme.bodyText2),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (newName) {
                          // setState(() {
                          //   _ingredientName = newName;
                          // });
                        },
                        controller: _quantityController,
                      ),
                      Divider(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Please input unit of item:",
                                style: Theme.of(context).textTheme.bodyText2),
                            DropdownButton<String>(
                              value: _chosenUnit,
                              items: <String>[
                                'g',
                                'kg',
                                'ml',
                                'l',
                                'units',
                              ].map<DropdownMenuItem<String>>((String qty) {
                                return DropdownMenuItem<String>(
                                  value: qty,
                                  child: Text(qty, style: Theme.of(context).textTheme.caption),
                                );
                              }).toList(),
                              onChanged: (String unit) {
                                setState(() {
                                  _chosenUnit = unit;
                                });
                              },
                            ),
                          ]
                      ),
                    ]
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: Text('ok'),
                        onPressed: () {
                          // save ingredient details to db & refresh the store page
                          _nameController.clear();
                          _quantityController.clear();
                          _expiry = '-';
                          _chosenUnit = 'units';
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
        leading: Visibility(
          child: IconButton(
            icon: Icon(
              Icons.select_all,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              setState(() {
                _selectAll = !_selectAll;
              });
            },
          ),
          visible: _checkboxVisible,
        ),
        centerTitle: true,
        title: Text('Store', style: Theme.of(context).textTheme.headline6),
        actions: [
          Visibility(
              child: MaterialButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _checkboxVisible = false;
                    recipeGetter = 'Generate Recipes';
                  });
                },
              ),
            visible: _checkboxVisible,
          ),
        ]
      ),
      body: // can use a list view builder to iterate and display
      Column(
        children: [
          Ingredient(
            ingredientName: 'egg',
            chosenQuantity: '2',
            chosenUnit: 'units',
            expiryDate: DateTime(2021, 9, 22),
            checkboxVisibility: _checkboxVisible,
            selectAll: _selectAll,
          ),
          Ingredient(
            ingredientName: 'chicken',
            chosenQuantity: '2',
            chosenUnit: 'units',
            expiryDate: DateTime(2021, 9, 28),
            checkboxVisibility: _checkboxVisible,
            selectAll: _selectAll,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (recipeGetter != 'Generate Recipes') {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeList()));
                    }
                    _checkboxVisible = true;
                    recipeGetter = 'Get Recipes';
                  });
                },
                child: Text(recipeGetter,
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFEA54B))),
              ),
            ),
          ),
        ],
      ),
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
