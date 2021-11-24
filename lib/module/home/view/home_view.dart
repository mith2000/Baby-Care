import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/module/sample/view/sample_view.dart';
import 'package:flutter_babycare/utils/UI_components/loading_widget.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  final User _user;
  int selectedIndex = 0;

  HomeView(User user, {Key key, this.selectedIndex = 0})
      : _user = user,
        super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _bottomNavigationKey = GlobalKey();
  List<Widget> screens;
  var _icons = {
    'home': 'assets/icon/home.svg',
    'notify': 'assets/icon/notify.svg',
    'chat': 'assets/icon/chat.svg',
    'user': 'assets/icon/user.svg',
  };

  @override
  void initState() {
    super.initState();
    screens = [
      HomeBodyView(widget._user),
      SampleView(),
      SampleView(),
      SampleView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            AppConstants.paddingAppH + AppConstants.paddingSuperLargeH),
        child: AppBar(
          title: Container(
            height: 32.h,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: AppConstants.paddingAppW),
            child: Text(
              'Baby Care',
              style: GoogleFonts.dosis(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
            )
          ],
        ),
      ),
      body: screens[widget.selectedIndex],
      bottomNavigationBar: _buildBottomTabBar(),
    );
  }

  Widget _buildBottomTabBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: AppColors.background,
      items: [
        Tab(
          icon: SvgPicture.asset(
            _icons['home'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['notify'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['chat'],
            color: AppColors.text,
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['user'],
            color: AppColors.text,
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },
    );
  }
}

class HomeBodyView extends StatefulWidget {
  final User _user;

  HomeBodyView(User user, {Key key})
      : _user = user,
        super(key: key);

  @override
  _HomeBodyViewState createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
    babyBloc.add(LoadBaby());
  }

  @override
  void dispose() {
    babyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      color: AppColors.background,
      child: ListView(
        children: [
          _buildTipView(),
          SizedBox(height: AppConstants.paddingLargeH),
          _buildWelcomeUser(widget._user.displayName),
          SizedBox(height: AppConstants.paddingNormalH),
          BlocBuilder<BabyBloc, BabyState>(
            bloc: babyBloc,
            builder: (context, state) {
              if (state is BabyLoading) {
                return CustomLoadingWidget();
              }
              if (state is BabyLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: state.listBaby.length,
                  itemBuilder: (context, index) {
                    return _buildBabyInterfaceButton(
                      babyName: state.listBaby[index].name,
                      babyYearOld: state.listBaby[index].birth,
                      imageUrl: state.listBaby[index].image,
                      status: 'Love_1',
                      action: () {
                        print('Baby Health');
                      },
                    );
                  },
                );
              } else {
                return Text('Error');
              }
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
        ],
      ),
    );
  }

  Widget _buildTipView() {
    return Container(
      height: 80.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
        vertical: AppConstants.paddingNormalH,
      ),
      child: Text(
        'Tips: Coming soon...',
        style: Theme.of(context).textTheme.headline1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeUser(String username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: new TextSpan(
            style: Theme.of(context).textTheme.headline2,
            children: <TextSpan>[
              new TextSpan(text: 'Hi '),
              new TextSpan(
                text: username,
                style: new TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.primary,
                ),
              ),
              new TextSpan(text: '!'),
            ],
          ),
        ),
        Text(
          'Hope your angels are well',
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }

  Widget _buildBabyInterfaceButton(
      {String babyName,
      double babyYearOld,
      Function action,
      String imageUrl,
      String status}) {
    return Container(
      height: 168.h,
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingNormalH),
      child: ElevatedButton(
        onPressed: action,
        child: Container(
          child: Row(
            children: [
              SizedBox(width: 4.w),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.cornerRadiusFrame),
                  bottomLeft: Radius.circular(AppConstants.cornerRadiusFrame),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/image/default_baby.png',
                  height: 160.h,
                  width: 160.w,
                  fit: BoxFit.cover,
                  image: imageUrl,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: AppConstants.paddingLargeH),
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 75.w,
                            child: SingleChildScrollView(
                              child: Text(
                                babyName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                  color: AppColors.whiteBackground,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 20.w,
                            thickness: 1.w,
                            color: AppColors.whiteBackground,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.danger,
                              borderRadius: BorderRadius.circular(
                                  AppConstants.cornerRadiusHighlightBox),
                            ),
                            child: Text(
                              babyYearOld.toInt().toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24.sp,
                                color: AppColors.whiteBackground,
                              ),
                            ),
                          ),
                          Text(
                            ' month',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              color: AppColors.whiteBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInImage(
                      placeholder: AssetImage('assets/image/EmojiLove_1.png'),
                      height: 80.h,
                      width: 80.w,
                      image: AssetImage('assets/image/Emoji$status.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.primary,
          onPrimary: AppColors.solidButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
          ),
        ),
      ),
    );
  }
}
