import 'package:flutter/material.dart';

enum TabItem{
  gameHistory(0),
  stats(1),
  profile(2);

  const TabItem(this.tabIndex);
  final int tabIndex;
}