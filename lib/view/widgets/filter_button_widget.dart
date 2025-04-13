import 'package:flutter/material.dart';
class FilterButton extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final bool isSelected;
  final String image;
  final VoidCallback onTap;

  const FilterButton({
    required this.label,
    this.backgroundColor,
    this.isSelected = false,
    required this.image,
    super.key,
    required this.onTap,
  });

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  void _animate() {
    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dartRedColor = Color.fromRGBO(149, 0, 0, 1.0);
    return GestureDetector(
      onTap: () {
        _animate();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected ? dartRedColor : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                width: 14,
                widget.image,
                color: widget.isSelected ? dartRedColor : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
