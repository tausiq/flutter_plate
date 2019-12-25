# Flutter Plate - A Starter Kit for Flutter

A starter kit for beginner learns with Bloc pattern, RxDart, sqflite, Fluro and Dio to architect a flutter project. This starter kit builds an App Store, Counter page, Timer page, Firebase Todo, Infinite list and many more as example

![App Store Flutter Demo](https://i.ibb.co/FsyWhpY/ezgif-3-5dbb34baf658.gif)

## Feature
- Bloc Pattern
- Navigate pages by [Fluro](https://github.com/theyakka/fluro)
- Local cache by using [sqflite](https://github.com/tekartik/sqflite)
- Restful api call by using [Dio](https://github.com/flutterchina/dio)
- Database debugging (Android Only) by using [flutter_stetho](https://github.com/brianegan/flutter_stetho)
- Loading Network Image
- Localization by using [Easy Localization](https://pub.dev/packages/easy_localization)
- Environment Variable & Project Config (Like App Name, Bundle Id) based on different project flavour (Development, Early, Staging & Production)
- Build pojo by using json_serializable
- Update each list item instead of re-rendering whole list view when data set has changed on a list item
- Hero animation
- Show empty View when the list view is empty

## Install

1. Follow flutter [official setup guide](https://flutter.io/docs/get-started/install) to set up flutter environment

## Run Config
1. Click 'Edit Configuration'
2. Create different run configs for flavours

![Edit Config](https://i.ibb.co/sbkgnmN/Screen-Shot-2019-01-13-at-7-28-44-PM.png)

![Config](https://i.ibb.co/tqPgMVz/Screen-Shot-2019-01-13-at-7-52-38-PM.png)

![Flavour](https://i.ibb.co/hCP2QJ1/Screen-Shot-2019-01-13-at-7-40-16-PM.png)


## Useful Command
### Generate json serialize and deserialize functions

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Known Issues
- [Unable to launch app on ios simulator with different flavours](https://github.com/flutter/flutter/issues/21335)

## Migration Guide
- If you wanna to use this project as your project's base, please read
  [migration guide](https://github.com/KingWu/flutter_starter_kit/wiki/Migration-Guide)


## Reference

#### From other platform?
- [Flutter for Android developers](https://flutter.io/docs/get-started/flutter-for/android-devs)
- [Flutter for iOS developers](https://flutter.io/docs/get-started/flutter-for/ios-devs)
- [Flutter for React Native developers](https://flutter.io/docs/get-started/flutter-for/react-native-devs)
- [Flutter for web developers](https://flutter.io/docs/get-started/flutter-for/web-devs)
- [Flutter for Xamarin.Forms developers](https://flutter.io/docs/get-started/flutter-for/xamarin-forms-devs)

#### Learn Widget & Layout
- [Building Layouts](https://flutter.io/docs/development/ui/layout)
- [Widget catalog](https://flutter.io/docs/development/ui/widgets)
- [Series of flutter widget of the week](https://www.youtube.com/playlist?list=PLOU2XLYxmsIL0pH0zWe_ZOHgGhZ7UasUE)
- [Series of Flutter Widgets 101](https://www.youtube.com/playlist?list=PLOU2XLYxmsIJyiwUPCou_OVTpRIn_8UMd)


#### Bloc Pattern
- [Architect your Flutter project using BLOC pattern](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1)
- [Bloc](https://felangel.github.io/bloc/#/)

#### Json Serialization
- [JSON and serialization](https://flutter.io/docs/development/data-and-backend/json)

#### Localization
- [Easy Localization](https://pub.dev/packages/easy_localization)

#### Flavouring
- [Flavoring Flutter](https://medium.com/@salvatoregiordanoo/flavoring-flutter-392aaa875f36)
- [Creating flavors of a Flutter app (Flutter & Android setup)](http://cogitas.net/creating-flavors-of-a-flutter-app/)

Influenced by: https://github.com/KingWu/flutter_starter_kit

#### Commands
Android release:
`flutter build apk -t lib/config/main_production.dart --target-platform android-arm,android-arm64,android-x64 --split-per-abi --flavor production --release`
iOS release: 
`flutter build ios -t lib/config/main_production.dart`