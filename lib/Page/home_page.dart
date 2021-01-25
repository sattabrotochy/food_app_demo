import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/Models/categories_model.dart';
import 'package:food_app_demo/Models/foodModel.dart';
import 'package:food_app_demo/Page/detail_page.dart';
import 'package:food_app_demo/Providers/my_provider.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Widget allDataList({@required String image, @required String item_name}) {
    return InkWell(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            item_name,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget FoodListShow({
    @required String image,
    @required String name,
    @required String price,
    @required String description,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailPage(
                  image: image,
                  item_name: name,
                  price: price,
                  description: description,
                )));
      },
      child: Container(
        height: 390,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff3a3e3e),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: 60,
            //   backgroundImage: NetworkImage(image),
            // ),

            Container(
              child: Image.network(image,
              fit: BoxFit.cover,
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  " $price",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<CategoriesModel> burgurList = [];

  // List<UserData> userList=[];
  List<FoodModel> foodList = [];

  Widget burgur() {
    return Row(
      children: burgurList
          .map(
            (e) => allDataList(
              image: e.cat_image,
              item_name: e.cat_name,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getCategories();
    burgurList = provider.throwList;

    provider.getFood();
    foodList = provider.throwFoodList;

    // provider.getUser();
    // userList=provider.throwUserLIst;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://i.pinimg.com/originals/24/5f/66/245f66799f890c8307568a4565f97b81.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                  accountName: Text('user name'),
                  accountEmail: Text('user email'),
                  currentAccountPicture: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My orders',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  onTap: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartPage()));
                  },
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Cart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  height: 1.5,
                  color: Colors.white,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'logOut',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onLongPress: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'HomePage',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Food Search",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    burgur(),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
              ),
              Container(
                margin: EdgeInsets.only(left: 25, top: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'BurGur',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                  child: foodList != null
                      ? GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 20,
                          children: foodList
                              .map((e) => FoodListShow(
                                  image: e.image,
                                  name: e.item_name,
                                  price: e.price))
                              .toList(),
                        )
                      : Center(
                          child: Text(
                            'loding.............',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
