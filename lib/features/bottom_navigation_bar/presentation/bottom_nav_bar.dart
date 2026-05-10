import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.work_rounded, label: 'Work'),
    _NavItem(icon: Icons.person_rounded, label: 'About'),
    _NavItem(icon: Icons.mail_rounded, label: 'Contact'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Your page content goes here
          _PageContent(selectedIndex: selectedIndex),

          // Liquid Glass Navbar
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: _LiquidGlassNavBar(
              items: _navItems,
              selectedIndex: selectedIndex,
              onTap: (index) =>
              ref.read(selectedIndexProvider.notifier).state = index,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Liquid Glass NavBar ──────────────────────────────────────────────────────

class _LiquidGlassNavBar extends StatefulWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _LiquidGlassNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<_LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<_LiquidGlassNavBar>
    with TickerProviderStateMixin {
  late AnimationController _pillController;
  late AnimationController _bounceController;
  late Animation<double> _pillAnimation;
  late Animation<double> _bounceAnimation;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();

    _pillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _pillAnimation = CurvedAnimation(
      parent: _pillController,
      curve: Curves.easeInOutCubicEmphasized,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(_LiquidGlassNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousIndex = oldWidget.selectedIndex;
      _pillController.forward(from: 0);

      _bounceAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
      );
      _bounceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pillController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length;

    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            // Liquid glass layered effect
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.18),
                Colors.white.withValues(alpha: 0.06),
                Colors.white.withValues(alpha: 0.12),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 40,
                spreadRadius: -8,
                offset: const Offset(0, 16),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.05),
                blurRadius: 1,
                spreadRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / itemCount;

              return Stack(
                children: [
                  // Sliding pill indicator
                  AnimatedBuilder(
                    animation: _pillAnimation,
                    builder: (context, child) {
                      final from = _previousIndex * itemWidth;
                      final to = widget.selectedIndex * itemWidth;
                      final current =
                          from + (to - from) * _pillAnimation.value;

                      return Positioned(
                        left: current + 10,
                        top: 10,
                        width: itemWidth - 20,
                        height: 52,
                        child: child!,
                      );
                    },
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _bounceAnimation.value,
                        child: child,
                      ),
                      child: _GlassPill(),
                    ),
                  ),

                  // Nav items
                  Row(
                    children: List.generate(itemCount, (index) {
                      final isSelected = index == widget.selectedIndex;
                      return _NavItemWidget(
                        item: widget.items[index],
                        isSelected: isSelected,
                        width: itemWidth,
                        onTap: () => widget.onTap(index),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Glass Pill ───────────────────────────────────────────────────────────────

class _GlassPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.30),
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.20),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.40),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: const Color(0xFF6EAAFF).withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: -2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Nav Item Widget ──────────────────────────────────────────────────────────

class _NavItemWidget extends StatefulWidget {
  final _NavItem item;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;

  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  @override
  State<_NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<_NavItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;
  late Animation<double> _labelOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.isSelected ? 1.0 : 0.0,
    );
    _iconScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _labelOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_NavItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: widget.width,
        height: 72,
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: _iconScale.value,
                    child: Icon(
                      widget.item.icon,
                      size: 24,
                      color: widget.isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.45),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Opacity(
                    opacity: _labelOpacity.value,
                    child: Text(
                      widget.item.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}

// ─── Demo Page Content (replace with your Router/IndexedStack) ────────────────

class _PageContent extends StatelessWidget {
  final int selectedIndex;

  const _PageContent({required this.selectedIndex});

  static const _pages = ['Home', 'Work', 'About', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _pages[selectedIndex],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w300,
          letterSpacing: 4,
        ),
      ),
    );
  }
}