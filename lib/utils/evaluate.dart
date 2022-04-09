import '../constants/app_constants.dart';

class Evaluate {
  static BabyStatus AverageEvaluate(List<BabyStatus> sources) {
    double point = 0;
    for (var source in sources) {
      switch (source) {
        case BabyStatus.Love:
          point += 100;
          break;
        case BabyStatus.Happy:
          point += 80;
          break;
        case BabyStatus.Smile:
          point += 60;
          break;
        case BabyStatus.Sad:
          point += 40;
          break;
        case BabyStatus.Cry:
          point += 20;
          break;
        default:
          break;
      }
    }
    point = point / sources.length;
    if (100 <= point)
      return BabyStatus.Love;
    else if (80 <= point)
      return BabyStatus.Happy;
    else if (60 <= point)
      return BabyStatus.Smile;
    else if (40 <= point)
      return BabyStatus.Sad;
    else
      return BabyStatus.Cry;
  }

  static BabyStatus NIEvaluate(double value) {
    if (85 < value && value < 115)
      return BabyStatus.Love;
    else if (70 < value && value < 130)
      return BabyStatus.Happy;
    else if (55 < value && value < 145)
      return BabyStatus.Smile;
    else if (40 < value && value < 160)
      return BabyStatus.Sad;
    else
      return BabyStatus.Cry;
  }

  static BabyStatus weightEvaluate(double value, int month, String gender) {
    double min, normal, max;
    if (gender == 'boy') {
      if (month == 0) {
        min = 2.5;
        normal = 3.3;
        max = 4.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 1) {
        min = 3.4;
        normal = 4.5;
        max = 5.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 2) {
        min = 4.3;
        normal = 5.6;
        max = 7.1;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 3) {
        min = 5;
        normal = 6.4;
        max = 8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 4) {
        min = 5.6;
        normal = 7;
        max = 8.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 5) {
        min = 6;
        normal = 7.5;
        max = 9.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 6) {
        min = 6.4;
        normal = 7.9;
        max = 9.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 7) {
        min = 6.7;
        normal = 8.3;
        max = 10.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 8) {
        min = 6.9;
        normal = 8.6;
        max = 10.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 9) {
        min = 7.1;
        normal = 8.9;
        max = 11;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 10) {
        min = 7.4;
        normal = 9.2;
        max = 11.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 11) {
        min = 7.6;
        normal = 9.4;
        max = 11.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 12) {
        min = 7.7;
        normal = 9.6;
        max = 12;
        return calculateBMIRange(value, normal, min, max);
      } else if (12 < month && month <= 15) {
        min = 8.3;
        normal = 10.3;
        max = 12.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (15 < month && month <= 18) {
        min = 8.8;
        normal = 10.9;
        max = 13.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (18 < month && month <= 21) {
        min = 9.2;
        normal = 11.5;
        max = 14.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (21 < month && month <= 24) {
        min = 9.7;
        normal = 12.2;
        max = 15.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (24 < month && month <= 30) {
        min = 10.5;
        normal = 13.3;
        max = 16.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (30 < month && month <= 36) {
        min = 11.3;
        normal = 14.3;
        max = 18.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (36 < month && month <= 42) {
        min = 12;
        normal = 15.3;
        max = 19.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (42 < month && month <= 48) {
        min = 12.7;
        normal = 16.3;
        max = 21.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (48 < month && month <= 54) {
        min = 13.4;
        normal = 17.3;
        max = 22.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (54 < month && month <= 60) {
        min = 14.1;
        normal = 18.3;
        max = 24.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (60 < month && month <= 66) {
        min = 15;
        normal = 19.4;
        max = 25.5;
        return calculateBMIRange(value, normal, min, max);
      } else {
        min = 15.9;
        normal = 20.5;
        max = 27.1;
        return calculateBMIRange(value, normal, min, max);
      }
    } else {
      if (month == 0) {
        min = 2.4;
        normal = 3.2;
        max = 4.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 1) {
        min = 3.2;
        normal = 4.2;
        max = 5.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 2) {
        min = 3.9;
        normal = 5.1;
        max = 6.6;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 3) {
        min = 4.5;
        normal = 5.8;
        max = 7.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 4) {
        min = 5;
        normal = 6.4;
        max = 8.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 5) {
        min = 5.4;
        normal = 6.9;
        max = 8.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 6) {
        min = 5.7;
        normal = 7.3;
        max = 9.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 7) {
        min = 6;
        normal = 7.6;
        max = 9.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 8) {
        min = 6.3;
        normal = 7.9;
        max = 10.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 9) {
        min = 6.5;
        normal = 8.2;
        max = 10.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 10) {
        min = 6.7;
        normal = 8.5;
        max = 10.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 11) {
        min = 6.9;
        normal = 8.7;
        max = 11.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 12) {
        min = 7;
        normal = 8.9;
        max = 11.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (12 < month && month <= 15) {
        min = 7.6;
        normal = 9.6;
        max = 12.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (15 < month && month <= 18) {
        min = 8.1;
        normal = 10.2;
        max = 13.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (18 < month && month <= 21) {
        min = 8.6;
        normal = 10.9;
        max = 14;
        return calculateBMIRange(value, normal, min, max);
      } else if (21 < month && month <= 24) {
        min = 9;
        normal = 11.5;
        max = 14.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (24 < month && month <= 30) {
        min = 10;
        normal = 12.7;
        max = 16.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (30 < month && month <= 36) {
        min = 10.8;
        normal = 13.9;
        max = 18.1;
        return calculateBMIRange(value, normal, min, max);
      } else if (36 < month && month <= 42) {
        min = 11.6;
        normal = 15;
        max = 19.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (42 < month && month <= 48) {
        min = 12.3;
        normal = 16.1;
        max = 21.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (48 < month && month <= 54) {
        min = 13;
        normal = 17.2;
        max = 23.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (54 < month && month <= 60) {
        min = 13.7;
        normal = 18.2;
        max = 24.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (60 < month && month <= 66) {
        min = 14.6;
        normal = 19.1;
        max = 26.2;
        return calculateBMIRange(value, normal, min, max);
      } else {
        min = 15.3;
        normal = 20.2;
        max = 27.8;
        return calculateBMIRange(value, normal, min, max);
      }
    }
  }

  static BabyStatus heightEvaluate(double value, int month, String gender) {
    double min, normal, max;
    if (gender == 'boy') {
      if (month == 0) {
        min = 46.1;
        normal = 49.9;
        max = 53.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 1) {
        min = 50.8;
        normal = 54.7;
        max = 58.6;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 2) {
        min = 54.4;
        normal = 58.4;
        max = 62.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 3) {
        min = 57.3;
        normal = 61.4;
        max = 65.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 4) {
        min = 59.7;
        normal = 63.9;
        max = 68;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 5) {
        min = 61.7;
        normal = 65.9;
        max = 70.1;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 6) {
        min = 63.3;
        normal = 67.6;
        max = 71.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 7) {
        min = 64.8;
        normal = 69.2;
        max = 73.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 8) {
        min = 66.2;
        normal = 70.6;
        max = 75;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 9) {
        min = 67.5;
        normal = 72;
        max = 76.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 10) {
        min = 68.7;
        normal = 73.3;
        max = 77.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 11) {
        min = 69.9;
        normal = 74.5;
        max = 79.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 12) {
        min = 71;
        normal = 75.7;
        max = 80.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (12 < month && month <= 15) {
        min = 74.1;
        normal = 79.1;
        max = 84.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (15 < month && month <= 18) {
        min = 76.9;
        normal = 82.3;
        max = 87.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (18 < month && month <= 21) {
        min = 79.4;
        normal = 85.1;
        max = 90.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (21 < month && month <= 24) {
        min = 81;
        normal = 87.1;
        max = 93.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (24 < month && month <= 30) {
        min = 85.1;
        normal = 91.9;
        max = 98.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (30 < month && month <= 36) {
        min = 88.7;
        normal = 96.1;
        max = 103.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (36 < month && month <= 42) {
        min = 91.9;
        normal = 99.9;
        max = 107.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (42 < month && month <= 48) {
        min = 94.9;
        normal = 103.3;
        max = 111.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (48 < month && month <= 54) {
        min = 97.8;
        normal = 106.7;
        max = 115.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (54 < month && month <= 60) {
        min = 100.7;
        normal = 110;
        max = 119.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (60 < month && month <= 66) {
        min = 103.4;
        normal = 112.9;
        max = 122.4;
        return calculateBMIRange(value, normal, min, max);
      } else {
        min = 106.1;
        normal = 116;
        max = 125.8;
        return calculateBMIRange(value, normal, min, max);
      }
    } else {
      if (month == 0) {
        min = 45.4;
        normal = 49.1;
        max = 52.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 1) {
        min = 49.8;
        normal = 53.7;
        max = 57.6;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 2) {
        min = 53;
        normal = 57.1;
        max = 61.1;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 3) {
        min = 55.6;
        normal = 59.8;
        max = 64;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 4) {
        min = 57.8;
        normal = 62.1;
        max = 66.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 5) {
        min = 59.6;
        normal = 64;
        max = 68.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 6) {
        min = 61.2;
        normal = 65.7;
        max = 70.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 7) {
        min = 62.7;
        normal = 67.3;
        max = 71.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 8) {
        min = 64;
        normal = 68.7;
        max = 73.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 9) {
        min = 65.3;
        normal = 70.1;
        max = 75;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 10) {
        min = 66.5;
        normal = 71.5;
        max = 76.4;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 11) {
        min = 67.7;
        normal = 72.8;
        max = 77.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (month == 12) {
        min = 68.9;
        normal = 74;
        max = 79.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (12 < month && month <= 15) {
        min = 72;
        normal = 77.5;
        max = 83;
        return calculateBMIRange(value, normal, min, max);
      } else if (15 < month && month <= 18) {
        min = 74.9;
        normal = 80.7;
        max = 86.5;
        return calculateBMIRange(value, normal, min, max);
      } else if (18 < month && month <= 21) {
        min = 77.5;
        normal = 83.7;
        max = 89.8;
        return calculateBMIRange(value, normal, min, max);
      } else if (21 < month && month <= 24) {
        min = 80;
        normal = 86.4;
        max = 92.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (24 < month && month <= 30) {
        min = 83.6;
        normal = 90.7;
        max = 97.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (30 < month && month <= 36) {
        min = 87.4;
        normal = 95.1;
        max = 102.7;
        return calculateBMIRange(value, normal, min, max);
      } else if (36 < month && month <= 42) {
        min = 90.9;
        normal = 99;
        max = 107.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (42 < month && month <= 48) {
        min = 94.1;
        normal = 102.7;
        max = 111.3;
        return calculateBMIRange(value, normal, min, max);
      } else if (48 < month && month <= 54) {
        min = 97.1;
        normal = 106.2;
        max = 115.2;
        return calculateBMIRange(value, normal, min, max);
      } else if (54 < month && month <= 60) {
        min = 99.9;
        normal = 109.4;
        max = 118.9;
        return calculateBMIRange(value, normal, min, max);
      } else if (60 < month && month <= 66) {
        min = 102.3;
        normal = 112.2;
        max = 122;
        return calculateBMIRange(value, normal, min, max);
      } else {
        min = 104.9;
        normal = 115.1;
        max = 125.4;
        return calculateBMIRange(value, normal, min, max);
      }
    }
  }

  static BabyStatus calculateBMIRange(
    double value,
    double normal,
    double min,
    double max,
  ) {
    double pieceMinToNormal, pieceNormalToMax;
    pieceMinToNormal = (normal - min) / 4;
    pieceNormalToMax = (max - normal) / 4;
    if (normal - pieceMinToNormal < value && value < normal + pieceNormalToMax)
      return BabyStatus.Love;
    else if (normal - 2 * pieceMinToNormal < value &&
        value < normal + 2 * pieceNormalToMax)
      return BabyStatus.Happy;
    else if (normal - 3 * pieceMinToNormal < value &&
        value < normal + 3 * pieceNormalToMax)
      return BabyStatus.Smile;
    else if (normal - 4 * pieceMinToNormal < value &&
        value < normal + 4 * pieceNormalToMax)
      return BabyStatus.Sad;
    else
      return BabyStatus.Cry;
  }
}
