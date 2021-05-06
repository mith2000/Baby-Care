import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

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
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        'Hope your angels are well',
                        style: Theme.of(context).textTheme.button,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(),
                        GestureDetector(
                          child: Container(
                            width: 351,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#7ed1f2'),
                                    HexColor('#bd88f2'),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#bd88f2').withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: Offset(-4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8, top: 5),
                                      child: Text(
                                        'Baby Health',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    Container(
                                      width: 124,
                                      child: Text(
                                        'Checking the health stutus of your baby',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                  ),
                                ),
                                SizedBox(width: 26),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('tapped');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 351,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#7ed1f2'),
                                    HexColor('#bd88f2'),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#bd88f2').withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: Offset(-4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8, top: 5),
                                      child: Text(
                                        'Baby Health',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    Container(
                                      width: 124,
                                      child: Text(
                                        'Checking the health stutus of your baby',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                  ),
                                ),
                                SizedBox(width: 26),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('tapped');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 351,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#7ed1f2'),
                                    HexColor('#bd88f2'),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#bd88f2').withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: Offset(-4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8, top: 5),
                                      child: Text(
                                        'Baby Health',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    Container(
                                      width: 124,
                                      child: Text(
                                        'Checking the health stutus of your baby',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                  ),
                                ),
                                SizedBox(width: 26),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('tapped');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 351,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#7ed1f2'),
                                    HexColor('#bd88f2'),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#bd88f2').withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: Offset(-4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8, top: 5),
                                      child: Text(
                                        'Baby Health',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    Container(
                                      width: 124,
                                      child: Text(
                                        'Checking the health stutus of your baby',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                  ),
                                ),
                                SizedBox(width: 26),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('tapped');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 351,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#7ed1f2'),
                                    HexColor('#bd88f2'),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#bd88f2').withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: Offset(-4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8, top: 5),
                                      child: Text(
                                        'Baby Health',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    Container(
                                      width: 124,
                                      child: Text(
                                        'Checking the health stutus of your baby',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/baby_default.jpg'),
                                  ),
                                ),
                                SizedBox(width: 26),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('tapped');
                          },
                        ),
                      ],
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
