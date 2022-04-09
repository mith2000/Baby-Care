import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BabyStatusIcon extends StatelessWidget {
  final BabyStatus status;
  final double size;
  const BabyStatusIcon({
    Key key,
    @required BabyStatus status,
    double size = 32,
  })  : this.status = status,
        this.size = size,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String _status;
    switch (status) {
      case BabyStatus.Love:
        _status = 'Love_1';
        break;
      case BabyStatus.Happy:
        _status = 'Happy_2';
        break;
      case BabyStatus.Smile:
        _status = 'Smile_3';
        break;
      case BabyStatus.Sad:
        _status = 'Sad_4';
        break;
      case BabyStatus.Cry:
        _status = 'Cry_5';
        break;
      default:
        _status = 'Love_1';
        break;
    }
    return FadeInImage(
      placeholder: AssetImage('assets/image/EmojiLove_1.png'),
      height: size.h,
      width: size.w,
      image: AssetImage('assets/image/Emoji$_status.png'),
    );
  }
}
