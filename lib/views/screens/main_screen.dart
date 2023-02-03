import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/products_screen.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/withdrawl_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


Widget _selectedItem = DashboardScreen();




screenSelector(item){
  switch(item.route){
    case DashboardScreen.routeName:
      setState(() {
        _selectedItem = DashboardScreen();
      });
      break;

    case VendorsScreen.routeName:
      setState(() {
        _selectedItem = VendorsScreen();
      });
      break;


    case WithDrawlScreen.routeName:
      setState(() {
        _selectedItem = WithDrawlScreen();
      });
      break;


    case CategoriesScreen.routeName:
      setState(() {
        _selectedItem = CategoriesScreen();
      });
      break;


    case ProductScreen.routeName:
      setState(() {
        _selectedItem = ProductScreen();
      });
      break;


    case UploadBannerScreen.routeName:
      setState(() {
        _selectedItem = UploadBannerScreen();
      });
      break;
  }
}




  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
backgroundColor: Colors.white,
      appBar: AppBar(title: Text("MANAGEMENT"),
      backgroundColor: Colors.yellow.shade900,),

      sideBar:  SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName
          ),
          AdminMenuItem(
              title: 'Vendors',
              icon: CupertinoIcons.person_3,
            route: VendorsScreen.routeName,
          ),
          AdminMenuItem(
              title: 'Withdrawl',
              icon: CupertinoIcons.money_dollar,
            route: WithDrawlScreen.routeName
          ),
          AdminMenuItem(
              title: 'Categories',
              icon: Icons.category,
            route: CategoriesScreen.routeName
          ),
          AdminMenuItem(
              title: 'Products',
              icon: Icons.shop,
            route: ProductScreen.routeName
          ),
          AdminMenuItem(
              title: 'Upload Banners',
              icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName
          ),
        ],
        selectedRoute: DashboardScreen.routeName,
        onSelected: (item){
          screenSelector(item);
        },

        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Multi Vendor Store Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Muk Enterprises',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),



      body: _selectedItem

    );
  }
}
