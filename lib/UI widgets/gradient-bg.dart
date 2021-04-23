import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final BuildContext _context;
  final List<Widget> _widgets;
  final PreferredSize _appBar;

  GradientBackground(this._formKey, this._widgets, this._context,
      [this._appBar = null]);

  Widget _buildBackgroundBody() {
    return Center(
      child: GestureDetector(
        onTap: () {
          //tap out of container will close the keyboard
          FocusScope.of(_context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(_context).cardColor,
                Theme.of(_context).backgroundColor,
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(57, 0, 57, 0),
              child: ListView(
                children: _widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _appBar == null
        ? Scaffold(
            body: _buildBackgroundBody(),
          )
        : Scaffold(
            appBar: _appBar,
            body: _buildBackgroundBody(),
            extendBodyBehindAppBar: true,
          );
  }
}
