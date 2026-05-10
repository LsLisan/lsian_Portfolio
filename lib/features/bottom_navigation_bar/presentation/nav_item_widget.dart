import 'package:flutter/material.dart';
import 'nav_provider.dart';

class NavItemWidget extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    if (widget.isSelected) _controller.forward();
  }

  @override
  void didUpdateWidget(NavItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.isSelected ? _controller.forward() : _controller.reverse();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.item.icon,
                color: widget.isSelected ? Colors.white : Colors.white54,
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.item.label,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.white54,
                fontSize: 10,
                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}