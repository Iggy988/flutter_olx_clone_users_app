import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/models/sellers.dart';
import 'package:users_app/widgets/text_delegate_header_widget.dart';

import '../global/global.dart';
import '../models/brands.dart';
import '../widgets/my_drawer.dart';
import 'brands_ui_design_widget.dart';

class BrandsScreen extends StatefulWidget {
  Sellers? model;
  BrandsScreen({this.model});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.purpleAccent,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: const Text(
          // widget.model!.name.toString()
          'iShop',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        //back button
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TextDelegateHeaderWidget(
              title: widget.model!.name.toString() + ' - Brands',
            ),
          ),

          //1. write query
          // 2. model class
          // 3. ui design widget

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(widget.model!.uid.toString())
                  .collection('brands')
                  .orderBy('publishDate', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot dataSnapshot) {
                if (dataSnapshot.hasData) {
                  // display brands if brand exists
                  return SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Brands brandsModel = Brands.fromJson(
                            dataSnapshot.data.docs[index].data()
                                as Map<String, dynamic>);
                        return BrandsUiDesignWidget(
                          model: brandsModel,
                        );
                      },
                      itemCount: dataSnapshot.data.docs.length);
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No brands exists"),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
