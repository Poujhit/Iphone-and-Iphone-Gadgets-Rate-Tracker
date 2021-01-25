import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart' show VxToast;

import 'package:iphone_rates_tracker/providers/data_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.2,
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Iphones Rate Tracker',
          style: GoogleFonts.ubuntu(fontSize: 30),
        ),
      ),
      // body: ElevatedButton(
      //     onPressed: () async {
      //       final stopLoading = VxToast.showLoading(context, msg: 'Loading Data');
      //       // final data = await DataProvider.getDataFromApi();
      //       stopLoading();
      //       // print(data.length);
      //     },
      //     child: Text('dhs')),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          FutureBuilder(
              future: Provider.of<DataProvider>(context).getDataFromApi(),
              builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
                final stopLoading = VxToast.showLoading(context, msg: 'Loading Data');
                if (snapshot.data.isNotEmpty && snapshot.connectionState != ConnectionState.waiting) {
                  stopLoading();
                  return Text('');
                } else {
                  return Text('');
                }
              }),
        ],
      ),
    );
  }
}
