<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![pub package](https://img.shields.io/pub/v/night_reader?color=green&include_prereleases&style=plastic)](https://pub.dev/packages/night_reader)

Package that implement the Night Light/ Night Reader effect in Flutter. Suitable for apps that need
this feature. ex: book apps, blog apps, ...

Do note that this package has nothing (yet) to do with the OS/native's nightlight. It's simply make
it's subtree under the effect of night reader.

## Features

* Apply controllable night reader effect on this widget subtree.
* There can be many instance of this widget in the tree, each with their own night reader effect
  color, animation, parameters,...

## Getting started

- First import it:

```dart
import 'package:night_reader/night_reader.dart';
```

## Usage

<img src="https://github.com/SilentCatD/night_reader/blob/main/assets/night_light_app.gif?raw=true" width="200px">

To make the whole app under the effect, one can simply wrap this widget around `MaterialApp` and
control the `value` parameter and the whole apps will be affected.

```dart
@override
Widget build(BuildContext context) {
  return AnimatedNightReader(
    value: 1,
    duration: const Duration(seconds: 2),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
  );
}
```

<img src="https://github.com/SilentCatD/night_reader/blob/main/assets/night_light_subtree.gif?raw=true" width="200px">

To only apply the effect to a particular subtree, one can wrap this widget where needed.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedNightReader(
            tint: Colors.blue,
            value: value1,
            duration: const Duration(seconds: 2),
            child: Container(
              height: 300,
              width: 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text("Sub tree 1"),
            ),
          ),
          AnimatedNightReader(
            value: value2,
            tint: Colors.red,
            duration: const Duration(seconds: 2),
            child: Container(
              height: 300,
              width: 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text("Sub tree 2"),
            ),
          ),
        ],
      ),
    ),
  );
}
```

This package come with `AnimatedNightReader`, which will automatically animate between value `[0-1]`
when changing the properties, other property animation is also supported.

But if one's need arise. They can control the not-animated version of this widget: `NightReader`,
through any method that trigger a `setState`.

For more information on each property, please do see the document. 