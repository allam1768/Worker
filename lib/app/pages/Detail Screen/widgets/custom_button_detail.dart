import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(fontSize: 18.sp, color: Colors.white)),
      ),
    );
  }
}
