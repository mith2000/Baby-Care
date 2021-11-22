import 'package:flutter/material.dart';
import 'package:flutter_babycare/module/baby/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/baby/bloc/baby_event.dart';
import 'package:flutter_babycare/module/baby/bloc/baby_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BabyView extends StatefulWidget {
  final String uId;

  const BabyView(String uId, {Key key})
      : this.uId = uId,
        super(key: key);

  @override
  _BabyViewState createState() => _BabyViewState();
}

class _BabyViewState extends State<BabyView> {
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
    babyBloc.add(LoadBaby());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is BabyLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BabyLoaded) {
            print("zzzzzzz");
            print(state.listBaby);
            print("yyyyyyy");
            print(widget.uId);
            return Scaffold(
              body: Container(),
            );
          } else {
            return Text('Error');
          }
        });
  }
}
