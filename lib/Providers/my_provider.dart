

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/Models/cart_model.dart';
import 'package:food_app_demo/Models/categories_model.dart';
import 'package:food_app_demo/Models/foodModel.dart';

class MyProvider extends ChangeNotifier {
  UserCredential userCredential;

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<CategoriesModel> _categorieslist = [];
  CategoriesModel categoriesModel;

  Future<void> getCategories() async {
    List<CategoriesModel> newCategoriesList = [];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("AllItem").get();
    querySnapshot.docs.forEach((element) {
      categoriesModel = CategoriesModel(
          cat_name: element.data()['cat_name'],
          cat_image: element.data()['cat_image']);
    //  print(categoriesModel.cat_name);
      newCategoriesList.add(categoriesModel);
      _categorieslist = newCategoriesList;
      notifyListeners();
    });
  }

  get throwList {
    return _categorieslist;
  }

  List<FoodModel> foodList = [];
  FoodModel _foodModel;

  Future<void> getFood() async {
    List<FoodModel> newFoodList = [];

    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Burger').get();

    querySnapshot.docs.forEach((element) {
      _foodModel = FoodModel(
        image: element.data()['image'],
        item_name: element.data()['item_name'],
        price: element.data()['price'],
        description: element.data()['description'],
      );

     // print(_foodModel.description);
      newFoodList.add(_foodModel);
      foodList = newFoodList;
      notifyListeners();
    });
  }

  get throwFoodList {
    return foodList;
  }

  //////////////add to cart//////////////////////////

  List<CartModel> cartList = [];
  List<CartModel> newCartList = [];
  CartModel cartModel;

  void addtoCart({ @required String image,
  @required String name,
  @required String price,
  @required int quantiry,
  }) {


    cartModel=CartModel(image: image, name: name, price: price, quantiry: quantiry);
    newCartList.add(cartModel);
    cartList=newCartList;
  }

  get throwCartList{
    return cartList;
  }


int totalPrice()
{
    int total =0;


    cartList.forEach((element) {
      var p=int.parse(element.price);
     total += p*element.quantiry;
    });

    return total;
}


int deleteIndex;
  void getDeleteIndex(int index)
  {
    deleteIndex=index;
  }



  void delete()
  {
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}
