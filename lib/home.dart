import 'package:flutter/material.dart';

import 'orderitem.dart';

var id;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static final List<OrderItem> _items = <OrderItem>[
    OrderItem(1, 'Mixed Grill', 'Platter', 1, 30.0, 'mixedgrill.jpg'),
    OrderItem(2, 'Grilled Chicken', 'Sandwich', 2, 10.0, 'chickensandwich.jpg'),
    OrderItem(3, 'Fresh Orange Juice', 'Drink', 3, 8.0, 'orangejuice.jpg'),
    OrderItem(4, 'Fresh Apple Juice', 'Drink', 1, 8.0, 'applejuice.jpg'),
  ];

  static final TextStyle _boldStyle = TextStyle(fontWeight: FontWeight.bold);
  static final TextStyle _greyStyle = TextStyle(color: Colors.grey);

  final ddlValues = <int>[1, 2, 3, 4];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Order Summary"),
              background:
                  Image.asset("images/restaurant.jpg", fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              sliver: SliverFixedExtentList(
                itemExtent: 172.0,
                delegate: SliverChildBuilderDelegate(
                    (builder, index) => _listItem(_items[index]),
                    childCount: _items.length),
              )),
          SliverToBoxAdapter(
              child: Container(
            alignment: Alignment.center,
            height: 50.0,
            color: const Color(0xffe04d25),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Check out',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Hero(
                      tag: "basket",
                      child: Icon(
                        Icons.shopping_basket,
                        color: Colors.black,
                        size: 24.0,
                      ))
                ],
              ),
              onTap: () {},
            ),
          ))
        ],
      ),
    );

  _listItem(OrderItem itm) => Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: _buildColumn1(itm),
              flex: 1,
            ),
            Flexible(child: _column(itm), flex: 3),
          ],
        ),
      );

  Widget _buildColumn1(OrderItem itm) => Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
          child: InkWell(
            child: Hero(
              child: Image.asset(
                'images/${itm.icon}',
                width: 100.0,
                height: 100.0,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
              tag: itm.id,
            ),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return Material(
                      color: Colors.black38,
                      child: Container(
                        padding: const EdgeInsets.all(30.0),
                        child: InkWell(
                          child: Hero(
                            child: Image.asset(
                              'images/${itm.icon}',
                              width: 300.0,
                              height: 300.0,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                            tag: itm.id,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );

  _column(OrderItem itm) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Text(
              itm.item,
              style: _boldStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(itm.category),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Quantity",
                  style: _greyStyle,
                ),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<int>(
                  items: ddlValues.map((f) {
                    return DropdownMenuItem<int>(
                      value: f,
                      child: Text(f.toString()),
                    );
                  }).toList(),
                  value: itm.qty,
                  onChanged: (int newVal) {
                    itm.qty = newVal;
                    this.setState(() {});
                  },
                )
              ],
            ),
          ),
          _bottomRow(itm.price, itm.qty),
        ],
      );

  _bottomRow(double itemPrice, int qty) => Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              "Item Price",
              style: _greyStyle,
            ),
          ),
          //  SizedBox(width: 5.0,),
          Flexible(
              flex: 1,
              child: Text(
                itemPrice.toStringAsPrecision(2),
                style: _boldStyle,
              )),
          // SizedBox(width: 10.0,),
          Flexible(
            flex: 1,
            child: Text(
              "Total",
              style: _greyStyle,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Flexible(
            flex: 1,
            child: Text(
              (qty * itemPrice).toString(),
              style: _boldStyle,
            ),
          )
        ],
      ),
    );
}
