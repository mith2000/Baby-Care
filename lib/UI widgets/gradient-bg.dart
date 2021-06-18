import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final BuildContext _context;
  final Widget _widget;
  final PreferredSize _appBar;
  final Widget _bottomBar;

  GradientBackground(this._widget, this._context,
      [this._appBar = null, this._bottomBar = null]);

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
                Theme.of(_context).backgroundColor,
              ],
              stops: [0.3, 0.8, 1],
            ),
          ),
          child: _widget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar == null ? null : _appBar,
      bottomNavigationBar: _bottomBar == null ? null : _bottomBar,
      body: _buildBackgroundBody(),
      extendBodyBehindAppBar: true,
    );
  }
}
