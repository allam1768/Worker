import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../values/app_color.dart';

class ToolCard extends StatefulWidget {
  final String toolName;
  final String imagePath;
  final String location;
  final String locationDetail;
  final String kondisi;
  final String kode_qr;
  final String pest_type;
  final String alatId;
  final List<Map<String, dynamic>> historyItems;

  const ToolCard({
    super.key,
    required this.toolName,
    required this.imagePath,
    required this.location,
    required this.locationDetail,
    required this.historyItems,
    required this.kondisi,
    required this.kode_qr,
    required this.pest_type,
    required this.alatId,
  });

  @override
  State<ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCard> {
  bool _showImage = false;

  String _getStatusFromCondition(String condition) {
    String normalized = condition.trim().toLowerCase();
    switch (normalized) {
      case 'good':
      case 'baik':
        return 'Aktif';
      case 'broken':
      case 'rusak':
        return 'Tidak Aktif';
      case 'maintenance':
        return 'Maintenance';
      default:
        return 'Tidak Diketahui';
    }
  }

  Color _getStatusColor(String condition) {
    String normalized = condition.trim().toLowerCase();
    switch (normalized) {
      case 'good':
      case 'baik':
        return AppColor.btnijo;
      case 'broken':
      case 'rusak':
        return Colors.red;
      case 'maintenance':
        return AppColor.oren;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String condition) {
    String normalized = condition.trim().toLowerCase();
    switch (normalized) {
      case 'good':
      case 'baik':
        return Icons.check_circle;
      case 'broken':
      case 'rusak':
        return Icons.cancel;
      case 'maintenance':
        return Icons.build_circle;
      default:
        return Icons.help_outline;
    }
  }

  // Method untuk menyimpan alat ID ke shared preferences
  Future<void> _saveAlatIdToPrefs(String alatId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_alat_id', alatId);
  }

  @override
  Widget build(BuildContext context) {
    String displayStatus = _getStatusFromCondition(widget.kondisi);
    Color statusColor = _getStatusColor(widget.kondisi);
    IconData statusIcon = _getStatusIcon(widget.kondisi);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () async {
            // Simpan alat ID ke shared preferences sebelum navigasi
            await _saveAlatIdToPrefs(widget.alatId);

            // Navigasi dengan arguments (tanpa alatId)
            Get.toNamed('/HistoryTool', arguments: {
              'toolName': widget.toolName,
              'location': widget.location,
              'locationDetail': widget.locationDetail,
            });
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar (jika _showImage true)
                if (_showImage)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          widget.imagePath,
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.cover,
                          headers: {
                            'ngrok-skip-browser-warning': '1',
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/broken.png',
                              width: double.infinity,
                              height: 180.h,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            widget.toolName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 12.h),

                // Informasi lokasi dan status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.locationDetail,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: statusColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusIcon,
                                size: 14.sp,
                                color: statusColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                displayStatus,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              // Tombol up/down pindah ke sini
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showImage = !_showImage;
                                  });
                                },
                                icon: Icon(
                                  _showImage
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade700,
                                  size: 18.sp,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: _showImage
                                    ? 'Sembunyikan Gambar'
                                    : 'Tampilkan Gambar',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}