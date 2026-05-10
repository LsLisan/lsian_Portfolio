import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class NavItem {
  final IconData icon;
  final String label;
  const NavItem({required this.icon, required this.label});
}