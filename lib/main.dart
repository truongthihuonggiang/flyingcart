import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//firstly, create project
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //we add a number of product
  ////now we add flying cart widget
  int num = 0;
  Widget flyingcart = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Demo of flying cart'),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.shopping_bag),
                      onPressed: () {
                        //demo here
                        //when this button is pressed, a flying cart display
                        setState(() {
                          flyingcart = Flyingcart();
                          //wait 2 second
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            flyingcart = null;
                            //hide flycart and add number
                            num++;
                          });
                        });
                      })
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: flyingcart == null ? Container() : flyingcart,
            )
          ],
        ));
  }

//now we setup flying cart when press on the button
  AppBar buildAppBar() {
    return AppBar(
      leading: Icon(Icons.home),
      actions: [
        //add number of products in shopping cart
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag),
                onPressed: () {},
              ),
              Container(
                child: Center(
                    child:
                        Text(num.toString(), style: TextStyle(fontSize: 10))),
                width: 15,
                height: 15,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Flyingcart extends StatefulWidget {
  @override
  _FlyingcartState createState() => _FlyingcartState();
}

class _FlyingcartState extends State<Flyingcart> with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      //code here
      final Size biggest = constraints.biggest;
      return Stack(
        children: [
          PositionedTransition(
              rect: RelativeRectTween(
                begin:
                    //flying cart fly from bottom to top
                    RelativeRect.fromSize(
                        Rect.fromLTRB(
                            biggest.width / 2 - 20,
                            biggest.height - 20,
                            biggest.width / 2,
                            biggest.height),
                        biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTRB(biggest.width - 20, -20, biggest.width, 0),
                    biggest),
              ).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.ease)),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.shopping_bag, color: Colors.green),
              ))
        ],
      );
    });
  }
}
