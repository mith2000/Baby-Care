import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 825,
              child: GlassContainer(
                height: 825,
                width: deviceWidth,
                gradient: new RadialGradient(
                  colors: [
                    Colors.white.withOpacity(.42),
                    Colors.white.withOpacity(.06),
                  ],
                  radius: 1,
                  center: Alignment(-0.66, -0.66),
                ),
                blur: 12,
                borderColor: Colors.white.withOpacity(.3),
                borderRadius: BorderRadius.circular(32.0),
                borderWidth: 1.0,
                elevation: 10.0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Hi Username!',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Hope your angels are well',
                        style: Theme.of(context).textTheme.button,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
