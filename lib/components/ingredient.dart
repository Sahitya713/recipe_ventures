import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ingredient extends StatefulWidget{
  String ingredientName;
  String chosenQuantity;

  Ingredient({@required this.ingredientName, @required this.chosenQuantity});

  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  TextEditingController _nameController;
  bool _visibilityTag = true;
  DateTime selectedDate = DateTime.now();
  String _expiry = '-';

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

  _deleteConfirmation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete this ingredient?",
                style: Theme.of(context).textTheme.bodyText2),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      child: Text('cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MaterialButton(
                      child: Text('ok'),
                      onPressed: () {
                        // delete ingredient from db
                        setState(() {
                          _visibilityTag = false;
                        });
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          );
        });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _expiry = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  _editNameAndExpiry(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context){
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
                        setState(() {
                          widget.ingredientName = newName;
                        });
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
                  ]
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: Text('ok'),
                        onPressed: () {
                          // save new ingredient name & expiry date to db
                          _nameController.clear();
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
    return Visibility(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.ingredientName, style: Theme.of(context).textTheme.bodyText1),
            Text('Expires on $_expiry', style: Theme.of(context).textTheme.caption),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                _editNameAndExpiry(context);
              },
            ),
            DropdownButton<String>(
              value: widget.chosenQuantity,
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
                  child: Text(qty, style: Theme.of(context).textTheme.caption),
                );
              }).toList(),
              onChanged: (String qty) {
                setState(() {
                  widget.chosenQuantity = qty;
                  // save to db
                });
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  _deleteConfirmation(context);
                }
            ),
          ]
      ),
    visible: _visibilityTag
    );}
}
