import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:iphone_rates_tracker/providers/data_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      //       final data = await DataProvider.getDataFromApi();
      //       stopLoading();
      //       print(data.length);
      //     },
      //     child: Text('dhs')),
      body: FutureBuilder(
        future: DataProvider.getDataFromApi(),
        builder: (ctx, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.data != null && snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.data.statusCode == 200) {
              final jsondata = convert.jsonDecode(snapshot.data.body);
              final allIphoneDetails = jsondata['alldata'] as List;
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: allIphoneDetails.map((eachIphoneDetails) {
                  return Card(
                    child: Column(
                      children: [
                        Text(
                          eachIphoneDetails['name'],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Container(
                  height: height * 0.12,
                  width: width * 0.5,
                  child: Card(
                    elevation: 10,
                    color: Colors.black87,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Some Error has occurred- maybe server is down or request timeout.',
                            style: GoogleFonts.ubuntu(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.replay_outlined),
                          label: Text(
                            'Try Again',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Container(
                height: height * 0.12,
                width: width * 0.5,
                child: Card(
                  elevation: 10,
                  color: Colors.black87,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 10),
                      CircularProgressIndicator(
                        strokeWidth: 3.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Loading ...',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
