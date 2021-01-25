import 'package:flutter/material.dart';
import 'package:food_app_demo/Providers/my_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    MyProvider provider=Provider.of<MyProvider>(context);
   int total= provider.totalPrice();


    Widget calrList({String image,String name,String price ,int quantity,Function ontap})
    {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 160,
                  width: 160,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 200,
                      width: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Pizza bhout acha hain',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed:  ontap,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff3a3e3e),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ $total",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'Check out',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (context,index){

          provider.getDeleteIndex(index);
          return calrList(
            ontap: (){
              provider.delete();
            },
            image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            quantity: provider.cartList[index].quantiry,
          );
        },

      ),
    );
  }
}
