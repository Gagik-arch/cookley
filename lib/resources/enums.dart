import 'dart:ui';

enum MealEnum { dinner, lunch, breakfast }

extension MealExtension on MealEnum {
  Color get color {
    switch (this) {
      case MealEnum.breakfast:
        return const Color.fromRGBO(234, 167, 15, 1);

      case MealEnum.lunch:
        return const Color.fromRGBO(161, 202, 40, 1);

      case MealEnum.dinner:
        return const Color.fromRGBO(218, 38, 2, 1);
    }
  }
}
