import 'package:equatable/equatable.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:meta/meta.dart';

@immutable
class HomeState extends Equatable {
    final int selectedIndex;
  final String selectedTitle;

  HomeState({
    @required this.selectedIndex,
    @required this.selectedTitle,
  });

  factory HomeState.initial() {
    return HomeState(
        selectedIndex: 0, selectedTitle: Env.value.appName,);
  }

  HomeState copyWith({int index, String title}) {
    return HomeState(
        selectedIndex: index ?? this.selectedIndex,
        selectedTitle: title ?? this.selectedTitle,);
  }

  @override
  String toString() =>
      'HomeState { selectedIndex: $selectedIndex }, selectedTitle: $selectedTitle';
}




/*

  factory HomeState.initial() {
    return HomeState(
        selectedIndex: 0, selectedTitle: app_name, cartInstance: Cart());
  }

  HomeState copyWith({int index, String title, Cart cart}) {
    return HomeState(
        selectedIndex: index ?? this.selectedIndex,
        selectedTitle: title ?? this.selectedTitle,
        cartInstance: cart ?? this.cartInstance);
  }

  @override
  String toString() =>
      'HomeState { selectedIndex: $selectedIndex }, selectedTitle: $selectedTitle, cartInstance: $cartInstance';
}
*/