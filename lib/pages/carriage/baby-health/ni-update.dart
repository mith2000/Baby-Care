import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../UI widgets/gradient-bg.dart';

class NIUpdatePage extends StatefulWidget {
  @override
  _NIUpdatePageState createState() => _NIUpdatePageState();
}

class _NIUpdatePageState extends State<NIUpdatePage> {
  final Map<String, dynamic> _formData = {
    'username': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildSliderInput() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate,
          color: Theme.of(context).backgroundColor,
          size: 40.0,
        ),
        SizedBox(width: 10),
        Container(
          width: 220,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 1.0, color: Theme.of(context).backgroundColor),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyWidget() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      SizedBox(height: 15),
      Container(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/image/baby_default.jpg'),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/baby_default.jpg'),
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      'Baby Name',
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Age: ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(0, 0, 0, .5),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: HexColor('#85b4f2'),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '15',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Text(
                          ' month',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(0, 0, 0, .5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(0, 0, 0, .5),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 32,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        child: GlassContainer(
          height: 80,
          width: 350,
          color: Colors.white.withOpacity(0.33),
          blur: 12,
          borderColor: Colors.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(32.0),
          borderWidth: 1.0,
          elevation: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last update ',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'was',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: HexColor('#B4DD7F'),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '5',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              Text(
                'days ago',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),
      Center(
        child: Container(
          height: 575,
          width: 330,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor('#7ed1f2'),
              HexColor('#bd88f2'),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: [
              BoxShadow(
                color: HexColor('#bd88f2').withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 240,
                child: Text(
                  'Remember what your kid ate few days ago',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: 20),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 10),
              _buildSliderInput(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),
      Center(
        child: Container(
          width: 300,
          height: 65,
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            child: Text(
              'NEXT',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              Navigator.pop(context);
            }, //model.authenticate),
          ),
        ),
      )
    ];
    return Form(
      key: _formKey,
      child: Container(
        child: GlassContainer(
          height: deviceHeight,
          width: deviceWidth,
          color: Colors.white.withOpacity(.7),
          blur: 12,
          borderColor: Colors.white,
          borderWidth: 0,
          elevation: 10.0,
          child: SafeArea(
            child: ListView(
              children: _widgets,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            'NI Update',
            style: TextStyle(
              fontFamily: 'Dosis',
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: HexColor('#bd88f2'),
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: HexColor('#bd88f2'),
          size: 40,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );

    return GradientBackground(_buildBodyWidget(), context, _appBar);
  }
}
