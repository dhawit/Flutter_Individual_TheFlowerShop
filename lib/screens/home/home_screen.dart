import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stylish/constants.dart';
import '../../search_results_page.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'package:stylish/screens/profile/login_screen.dart';
import 'package:stylish/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/icons/menu.svg"),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/Location.svg"),
            const SizedBox(width: defaultPadding / 2),
            Text(
              "Manhattan",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/profile.svg"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      // bottomNavigationBar: GNav(gap: 8, tabs: [
      //   GButton(icon: Icons.home, text: ' Home'),

      //   GButton(icon: Icons.favorite, text: 'Favorites'),
      //   GButton(
      //     icon: Icons.shopping_cart,
      //     text: 'Cart',
      //   ),
      //   GButton(icon: Icons.logout, text: 'Logout'),
      // ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/menu.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Color.fromRGBO(241, 163, 128, 1.0),
                    fontSize: 14,
                    height: 14,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border_outlined),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.logout, color: Color.fromRGBO(248, 12, 12, 1.0)),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () async {
                bool confirmLogout = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  ),
                );

                if (confirmLogout == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const Text(
              "Flowers Supremacy",
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: SearchForm(onSubmitted: (query) {
                setState(() {
                  _searchQuery = query;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(
                      searchQuery: _searchQuery,
                    ),
                  ),
                );
              }),
            ),
            const NewArrivalProducts(),
            const PopularProducts(),
          ],
        ),
      ),
    );
  }
}
