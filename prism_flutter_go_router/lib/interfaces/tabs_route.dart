import 'package:flutter/cupertino.dart';

abstract class TabsRoute {
  bool isTabLocation(String path);

  void goToTab(BuildContext context);
}
