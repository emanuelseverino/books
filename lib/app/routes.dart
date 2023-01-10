import 'package:books/intro/intro_page.dart';
import 'package:flutter/widgets.dart';

import '../home/home_page.dart';
import 'app_state.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [IntroPage.page()];
  }
}
