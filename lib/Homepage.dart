import 'package:flutter/material.dart';

import 'Addproduct.dart';
import 'SplashCreen.dart';
import 'View_product.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> list = [View_product(), Addproduct()];
  int cnt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String name = SplashCreen.prefrs!.getString("NAME") ?? "";

    print("===$name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[cnt],
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                otherAccountsPictures: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))
                ],
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pragneshzone.000webhostapp.com/Ecommer/${SplashCreen.prefrs!.getString("Image") ?? ""}")),
                accountName:
                    Text("${SplashCreen.prefrs!.getString("NAME") ?? ""}"),
                accountEmail:
                    Text("${SplashCreen.prefrs!.getString("Email") ?? ""}")),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 0;
                });
              },
              title: Text(
                "View PRoduct",
              ),
              leading: Icon(Icons.shopping_cart),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 1;
                });
              },
              title: Text(
                "Add PRoduct",
              ),
              leading: Icon(Icons.shopping_cart),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Log Out",
              ),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
