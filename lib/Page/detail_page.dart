import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/Providers/my_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String item_name;
  final String price;
  final String description;

  DetailPage({
    @required this.image,
    @required this.item_name,
    @required this.price,
    @required this.description,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity=1;


  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.item_name),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff3a3e3e),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item_name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Any Text.......',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity--;
                                  print(quantity);
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child:Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              quantity.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: ()
                              {
                                setState(() {
                                  quantity++;
                                  print(quantity);
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(Icons.add),
                                ),
                            ),
                          ],
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      ],
                    ),
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      "The patties are simply seasoned with garlic powder, kosher salt and pepper. But because they're thinner, the seasonings are more pronounced because there isn't as much area or meatiness to infuse the flavor. Now, I said they're simply seasoned, but that does not mean SKIMPILY seasoned. This is a garlic burger.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          provider.addtoCart(
                              image: widget.image,
                              name: widget.item_name,
                              price: widget.price,
                              quantiry: quantity);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
