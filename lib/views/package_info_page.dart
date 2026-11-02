import 'package:flutter/material.dart';

class PackageInfoPage extends StatelessWidget {
  const PackageInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgCanvas = Color(0xFFFBF9F5);
    const Color inkPrimary = Color(0xFF181F1B);
    const Color inkSecondary = Color(0xFF59615B);
    const Color inkMuted = Color(0xFF8C948E);
    const Color accentTerracotta = Color(0xFFDA6848);
    const Color accentTerracottaBg = Color(0xFFFDF0EC);
    const Color borderSubtle = Color(0xFFE8E4DD);

    return Scaffold(
      backgroundColor: bgCanvas,
      appBar: AppBar(
        backgroundColor: bgCanvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: borderSubtle),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back, size: 18, color: inkPrimary),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ),
        title: const Text(
          'Package Info',
          style: TextStyle(
            color: inkPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentTerracottaBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentTerracotta.withValues(alpha: 0.25)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: accentTerracotta,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Lab 8',
                      style: TextStyle(
                        color: accentTerracotta,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // Section Subtitle
              Row(
                children: [
                  const Text(
                    'FLUTTER ARCHITECTURE',
                    style: TextStyle(
                      color: accentTerracotta,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 1,
                    color: accentTerracotta.withValues(alpha: 0.4),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Headline & Description
              const Text(
                'Installed Core Packages',
                style: TextStyle(
                  color: inkPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Essential Flutter packages powering the location intelligence & mapping engine',
                style: TextStyle(
                  color: inkSecondary,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Metric Summary Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      value: '4',
                      label: 'Packages Active',
                      icon: Icons.check_circle_outline,
                      iconColor: const Color(0xFF2E7D32),
                      borderSubtle: borderSubtle,
                      inkPrimary: inkPrimary,
                      inkSecondary: inkSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCard(
                      value: '0',
                      label: 'API Keys Required',
                      icon: Icons.lock_outline,
                      iconColor: accentTerracotta,
                      borderSubtle: borderSubtle,
                      inkPrimary: inkPrimary,
                      inkSecondary: inkSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCard(
                      value: '100%',
                      label: 'Offline OSM Ready',
                      icon: Icons.map_outlined,
                      iconColor: accentTerracotta,
                      borderSubtle: borderSubtle,
                      inkPrimary: inkPrimary,
                      inkSecondary: inkSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 4 Core Package Cards
              _buildPackageCard(
                packageName: 'location',
                version: 'v10.0.2',
                category: 'GPS & PERMISSIONS',
                description:
                    'ตรวจสอบสถานะบริการ Location, ร้องขอ Permission และอ่านพิกัดตำแหน่ง (GPS) ของอุปกรณ์',
                metaInfo: 'iOS • Android • Web',
                metaIcon: Icons.devices_outlined,
                cardIcon: Icons.near_me_outlined,
                borderSubtle: borderSubtle,
                inkPrimary: inkPrimary,
                inkSecondary: inkSecondary,
                inkMuted: inkMuted,
                accentTerracotta: accentTerracotta,
                accentTerracottaBg: accentTerracottaBg,
              ),
              const SizedBox(height: 14),

              _buildPackageCard(
                packageName: 'flutter_map',
                version: 'v8.3.2',
                category: 'MAP RENDERING',
                description:
                    'แสดงผลแผนที่แบบ Interactive ด้วย OpenStreetMap (Tile Layer, Marker Layer) โดยไม่ต้องใช้ API Key',
                metaInfo: 'TileLayer • MarkerLayer',
                metaIcon: Icons.layers_outlined,
                cardIcon: Icons.map_outlined,
                borderSubtle: borderSubtle,
                inkPrimary: inkPrimary,
                inkSecondary: inkSecondary,
                inkMuted: inkMuted,
                accentTerracotta: accentTerracotta,
                accentTerracottaBg: accentTerracottaBg,
              ),
              const SizedBox(height: 14),

              _buildPackageCard(
                packageName: 'latlong2',
                version: 'v0.10.1',
                category: 'GEOSPATIAL MATH',
                description:
                    'จัดการออบเจกต์พิกัดละติจูด (Latitude) และลองจิจูด (Longitude) ในรูปแบบ LatLng รวมถึงคำนวณระยะทาง',
                metaInfo: 'Haversine • Geodesic',
                metaIcon: Icons.straighten_outlined,
                cardIcon: Icons.explore_outlined,
                borderSubtle: borderSubtle,
                inkPrimary: inkPrimary,
                inkSecondary: inkSecondary,
                inkMuted: inkMuted,
                accentTerracotta: accentTerracotta,
                accentTerracottaBg: accentTerracottaBg,
              ),
              const SizedBox(height: 14),

              _buildPackageCard(
                packageName: 'intl',
                version: 'v0.20.3',
                category: 'FORMATTING & I18N',
                description:
                    'จัดรูปแบบวัน-เวลา (DateFormat), ตัวเลข และจัดการข้อความรองรับพหุภาษา (Internationalization)',
                metaInfo: 'DateFormat • NumberFormat',
                metaIcon: Icons.schedule_outlined,
                cardIcon: Icons.translate_outlined,
                borderSubtle: borderSubtle,
                inkPrimary: inkPrimary,
                inkSecondary: inkSecondary,
                inkMuted: inkMuted,
                accentTerracotta: accentTerracotta,
                accentTerracottaBg: accentTerracottaBg,
              ),
              const SizedBox(height: 28),

              // Elegant subtle footer
              Center(
                child: Text(
                  'My Location Explorer • Lab 8',
                  style: TextStyle(
                    color: inkMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

  static Widget _buildMetricCard({
    required String value,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color borderSubtle,
    required Color inkPrimary,
    required Color inkSecondary,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: inkPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              Icon(icon, size: 16, color: iconColor),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: inkSecondary,
              fontSize: 11,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPackageCard({
    required String packageName,
    required String version,
    required String category,
    required String description,
    required String metaInfo,
    required IconData metaIcon,
    required IconData cardIcon,
    required Color borderSubtle,
    required Color inkPrimary,
    required Color inkSecondary,
    required Color inkMuted,
    required Color accentTerracotta,
    required Color accentTerracottaBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderSubtle),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF181F1B).withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Package Name + Version + Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                packageName,
                style: TextStyle(
                  color: inkPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3F0),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: borderSubtle),
                ),
                child: Text(
                  version,
                  style: TextStyle(
                    color: inkSecondary,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: accentTerracottaBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(cardIcon, size: 18, color: accentTerracotta),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Category Tag
          Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: accentTerracotta,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                category,
                style: TextStyle(
                  color: accentTerracotta,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Thai Description
          Text(
            description,
            style: TextStyle(
              color: inkSecondary,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),

          // Divider hairline
          Container(
            height: 1,
            color: borderSubtle.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 10),

          // Meta Footer
          Row(
            children: [
              Icon(metaIcon, size: 14, color: inkMuted),
              const SizedBox(width: 6),
              Text(
                metaInfo,
                style: TextStyle(
                  color: inkMuted,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'pub.dev',
                    style: TextStyle(
                      color: accentTerracotta,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_outward,
                    size: 12,
                    color: accentTerracotta,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

