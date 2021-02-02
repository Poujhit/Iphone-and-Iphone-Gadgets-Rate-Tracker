import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart' show VxToast;
import 'package:google_fonts/google_fonts.dart';

class EachGridTile extends StatefulWidget {
  final Map<String, dynamic> eachIphoneDetails;
  EachGridTile({this.eachIphoneDetails});

  @override
  _EachGridTileState createState() => _EachGridTileState();
}

class _EachGridTileState extends State<EachGridTile> {
  double elevation = 10;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final stopLoading = VxToast.showLoading(context, msg: 'Opening Flipkart App/Webiste...');
        final url = 'https://${widget.eachIphoneDetails['product-link']}';
        if (await canLaunch(url)) {
          await launch(url);
          stopLoading();
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  widget.eachIphoneDetails['name'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  'Price: ${widget.eachIphoneDetails['price']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  'Discount: ${widget.eachIphoneDetails['discount']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
