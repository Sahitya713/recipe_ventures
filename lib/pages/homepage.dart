import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:recipe_ventures/controllers/recipeController.dart';
import 'package:recipe_ventures/controllers/test.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File image;

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome', style: Theme.of(context).textTheme.headline6),
      ),
      body: Column(
        children: [
          // Container to tap for taking picture
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: FocusedMenuHolder(
              menuOffset: 10,
              onPressed: () {},
              menuItems: [
                FocusedMenuItem(
                  title: Text('Take a picture'),
                  onPressed: () => pickImageCamera(),
                ),
                FocusedMenuItem(
                  title: Text('Upload from gallery'),
                  onPressed: () => pickImageGallery(),
                ),
              ],
              menuWidth: MediaQuery.of(context).size.width - 50,
              openWithTap: true,
              blurBackgroundColor: Theme.of(context).backgroundColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 1 / 1.15,
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(
                            image,
                            width: 100,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://solidstarts.com/wp-content/uploads/when-can-babies-eat-eggs.jpg'),
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.camera_alt_rounded,
                                  size: 100, color: Colors.black),
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Container(
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
          image!=null?Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('add to store');
                  },
                  child: Text('Add to store'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(170, 36),
                      primary: Theme.of(context).primaryColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('retake image');
                  },
                  child: Text('Retake Image'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(170, 36),
                      primary: Theme.of(context).primaryColor),
                )
              ],
            ),
          )
          : Container()
          // Center(
          //   // child: Text('upload Image')
          //   child: GestureDetector(
          //       onTap: () {
          //         TestManager().getTest();
          //       },
          //       child: Text('upload Image',
          //           style: Theme.of(context).textTheme.bodyText2)),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     // RecipeManager().generateRecipes(["cheddar", "onion"]);
          //     RecipeManager().getRecipe("1416203");
          //   },
          //   child: Text('Generate recipes'),
          // )
        ],
      ),
    );
  }
}
