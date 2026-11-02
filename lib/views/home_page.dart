import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/location_result.dart';
import '../services/location_service.dart';
import 'package:my_location_explorer/views/package_info_page.dart';
import 'package:my_location_explorer/views/map_page.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  LocationResult? _locationResult;
  bool _isLoading = false;
  String? _errorMessage;

  // Weave Design System Colors
  static const Color _surface = Color(0xFFFBF9F5);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _dark = Color(0xFF181F1B);
  static const Color _muted = Color(0xFF6C7570);
  static const Color _border = Color(0xFFE8E4DD);
  static const Color _terracotta = Color(0xFFDA6848);
  static const Color _terracottaSoft = Color(0xFFFDF0EC);
  static const Color _success = Color(0xFF10B981);
  static const Color _successSoft = Color(0xFFECFDF5);
  static const Color _graychip = Color(0xFFF4F2EC);

  // Bonus C: Reference Point (KU Bangkhen)
  static const LatLng _kuBangkhenPosition = LatLng(13.847639, 100.569603);
  static const String _referenceName = 'ม.เกษตรศาสตร์ (บางเขน)';

  Future<void> _loadLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _locationService.getCurrentLocation();
      if (!mounted) return;
      setState(() {
        _locationResult = result;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      appBar: AppBar(
        backgroundColor: _surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: _border.withOpacity(0.6), height: 1.0),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _terracotta.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.near_me, color: _terracotta, size: 19),
            ),
            const SizedBox(width: 10),
            const Text(
              'My Location Explorer',
              style: TextStyle(
                color: _dark,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: _terracottaSoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _terracotta.withOpacity(0.2)),
            ),
            child: const Text(
              '• Lab 8',
              style: TextStyle(
                color: _terracotta,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _isLoading ? null : _loadLocation,
            icon: const Icon(Icons.refresh, size: 20),
            color: _muted,
            splashRadius: 20,
            tooltip: 'รีเฟรชตำแหน่ง',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PackageInfoPage()),
              );
            },
            icon: const Icon(Icons.info_outline, size: 20),
            color: _muted,
            splashRadius: 20,
            tooltip: 'ข้อมูล Package',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 28,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Tag & Title Intro
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _graychip,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _border.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.satellite_alt,
                            size: 13,
                            color: _terracotta,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'GEOLOCATOR',
                            style: TextStyle(
                              color: _muted,
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Device Location',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _dark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'ตรวจจับและอ่านค่าพิกัดภูมิศาสตร์ผ่าน Location Sensor แบบ Real-time',
                      style: TextStyle(
                        fontSize: 12,
                        color: _muted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // State Card
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildStateContent(),
                    ),
                  ],
                ),
              ),
            ),

            // FAB
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _loadLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _terracotta,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: _terracotta.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: _terracotta.withOpacity(0.45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.my_location, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'อ่านตำแหน่ง',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateContent() {
    if (_isLoading) {
      return _buildCardWrapper(
        key: const ValueKey('loading'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_terracotta),
              ),
            ),
            Text(
              'กำลังค้นหาตำแหน่ง...',
              style: TextStyle(color: _dark, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildCardWrapper(
        key: const ValueKey('error'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.error_outline, size: 48, color: Colors.red),
            ),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadLocation,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('ลองใหม่'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                foregroundColor: Colors.red,
                elevation: 0,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    if (_locationResult != null) {
      final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
      return _buildCardWrapper(
        key: const ValueKey('success'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _success.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: _success,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'พิกัดตำแหน่งปัจจุบัน',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _successSoft,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: const Text(
                    'GPS Lock',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: _border),
            ),
            // Coordinates Display Boxes
            Row(
              children: [
                Expanded(
                  child: _buildCoordinateBox(
                    label: 'Latitude',
                    icon: Icons.explore,
                    value: _locationResult!.latitude.toStringAsFixed(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCoordinateBox(
                    label: 'Longitude',
                    icon: Icons.pin_drop,
                    value: _locationResult!.longitude.toStringAsFixed(6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Timestamp
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _border.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, size: 15, color: _muted),
                  const SizedBox(width: 6),
                  Text(
                    'อัปเดตล่าสุด: ${dateFormat.format(_locationResult!.updatedAt)}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Action Buttons: ดูบนแผนที่ & Find Distance
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapPage(
                            locationResult: _locationResult!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _terracotta,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.map, size: 18),
                    label: const Text(
                      'ดูบนแผนที่',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showDistanceBottomSheet,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _terracotta,
                      side: const BorderSide(color: _terracotta, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.straighten, size: 18),
                    label: const Text(
                      'Find Distance',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Initial State
    return _buildCardWrapper(
      key: const ValueKey('initial'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Icon(Icons.location_searching, size: 48, color: _muted),
          ),
          Text(
            'กดปุ่ม "อ่านตำแหน่ง" ด้านล่าง\nเพื่อดึงพิกัดปัจจุบันของคุณ',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 14),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCardWrapper({required Key key, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF181F1B).withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCoordinateBox({
    required String label,
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border.withOpacity(0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _muted,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(icon, size: 14, color: _muted.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: _dark,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  void _showDistanceBottomSheet() {
    if (_locationResult == null) return;

    final currentPosition = LatLng(
      _locationResult!.latitude,
      _locationResult!.longitude,
    );

    // Bonus C: คำนวณระยะห่างด้วย Distance() จาก latlong2
    final distanceInMeters = const Distance().as(
      LengthUnit.Meter,
      currentPosition,
      _kuBangkhenPosition,
    );

    final numberFormat = NumberFormat('#,##0.00');
    final String distanceText;
    final String unitText;

    if (distanceInMeters >= 1000) {
      final distanceInKm = distanceInMeters / 1000.0;
      distanceText = numberFormat.format(distanceInKm);
      unitText = 'กิโลเมตร (km)';
    } else {
      distanceText = NumberFormat('#,##0').format(distanceInMeters);
      unitText = 'เมตร (m)';
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _terracottaSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.straighten,
                      color: _terracotta,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'ระยะห่างจากจุดอ้างอิง',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _border),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF181F1B).withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'จุดอ้างอิงเป้าหมาย:',
                      style: TextStyle(fontSize: 12, color: _muted),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      _referenceName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'พิกัด: ${_kuBangkhenPosition.latitude.toStringAsFixed(6)}, ${_kuBangkhenPosition.longitude.toStringAsFixed(6)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: _muted,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: _border),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ระยะทาง:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _dark,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              distanceText,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _terracotta,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              unitText,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1, color: _border),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.info_outline, size: 13, color: _muted),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'หมายเหตุ: คำนวณระยะกระจัดตามผิวโลกด้วย Distance() จาก latlong2',
                            style: TextStyle(
                              fontSize: 11,
                              color: _muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _terracotta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('ปิด'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
