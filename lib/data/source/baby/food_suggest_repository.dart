import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/app_constants.dart';
import '../model/food_suggest_model.dart';
import '../model/ni_model.dart';
import 'package:uuid/uuid.dart';

import 'ni_repository.dart';

class FoodSuggestRepository {
  final FirebaseFirestore firebaseFirestore;
  final NIRepository niRepository;

  FoodSuggestRepository(
      {FirebaseFirestore firebaseFirestore, NIRepository niRepository})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance,
        this.niRepository = niRepository ?? new NIRepository();

  Future<List<FoodSuggestModel>> listTotalMealSuggestForWeek(
      String idBaby) async {
    List<FoodSuggestModel> listMealSuggest = [
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Milk,
          value: 2000,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Meat,
          value: 200,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Porridge,
          value: 500,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Fish,
          value: 800,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Egg,
          value: 5,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Green_Vegets,
          value: 400,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Red_Vegets,
          value: 200,
          date: DateTime.now()),
      FoodSuggestModel(
          id: Uuid().v4(),
          idBaby: idBaby,
          type: FoodType.Citrus_Fruit,
          value: 300,
          date: DateTime.now()),
    ];
    List<NIModel> listNI = [];
    List<NIType> listTypeNI = [];
    listNI = await NIRepository.fetchNi(idBaby);

    listNI.forEach((element) {
      switch (element.type) {
        case NIType.Calcium:
          if (element.value < 2 * 28) {
            listTypeNI.add(NIType.Calcium);
          }
          break;
        case NIType.Carbohydrate:
          if (element.value < 10 * 28) {
            listTypeNI.add(NIType.Carbohydrate);
          }
          break;
        case NIType.Fat:
          if (element.value < 30 * 28) {
            listTypeNI.add(NIType.Fat);
          }
          break;
        case NIType.Protein:
          if (element.value < 41 * 28) {
            listTypeNI.add(NIType.Protein);
          }
          break;
        case NIType.Vitamin_A:
          if (element.value < 1 * 28) {
            listTypeNI.add(NIType.Vitamin_A);
          }
          break;
        case NIType.Vitamin_B:
          if (element.value < 1 * 28) {
            listTypeNI.add(NIType.Vitamin_B);
          }
          break;
        case NIType.Vitamin_C:
          if (element.value < 1 * 28) {
            listTypeNI.add(NIType.Vitamin_C);
          }
          break;
        case NIType.Vitamin_D:
          if (element.value < 1 * 28) {
            listTypeNI.add(NIType.Vitamin_D);
          }
          break;
        case NIType.Iron:
          if (element.value < 3 * 28) {
            listTypeNI.add(NIType.Iron);
          }
          break;
        default:
          if (element.value < 1 * 28) {
            listTypeNI.add(NIType.Iodine);
          }
          break;
      }
    });

    listTypeNI.forEach((element) {
      switch (element) {
        case NIType.Calcium:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Milk) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Carbohydrate:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Milk) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Fat:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Porridge) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Protein:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Milk) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Vitamin_A:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Citrus_Fruit) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Vitamin_B:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Milk) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Vitamin_C:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Green_Vegets) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Vitamin_D:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Citrus_Fruit) {
              element.value += element.value * 1.25;
            }
          });
          break;
        case NIType.Iron:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Meat) {
              element.value += element.value * 1.25;
            }
          });
          break;
        default:
          listMealSuggest.forEach((element) {
            if (element.type == FoodType.Milk) {
              element.value += element.value * 1.25;
            }
          });
          break;
      }
    });

    return listMealSuggest;
  }
}
