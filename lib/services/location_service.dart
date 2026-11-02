import 'package:location/location.dart';
import '../models/location_result.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationResult> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // TODO 1: ตรวจสอบว่า Location Service เปิดอยู่หรือไม่
    // หากปิดอยู่ ให้ขอเปิดด้วย requestService()
    // หากผู้ใช้ไม่เปิด ให้ throw Exception
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception(
          'บริการระบุตำแหน่ง (Location Service) ปิดอยู่ กรุณาเปิดใช้งาน',
        );
      }
    }

    // TODO 2: ตรวจสอบ Permission ด้วย hasPermission()
    // หากยังไม่ได้รับอนุญาต ให้เรียก requestPermission()
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
    }

    // TODO 3: หาก Permission ถูกปฏิเสธ ให้ throw Exception
    if (permissionGranted == PermissionStatus.deniedForever) {
      throw Exception(
        'สิทธิ์การเข้าถึงตำแหน่งถูกปฏิเสธถาวร กรุณาเปิดอนุญาตในการตั้งค่าของอุปกรณ์',
      );
    }
    if (permissionGranted == PermissionStatus.denied) {
      throw Exception(
        'สิทธิ์การเข้าถึงตำแหน่งถูกปฏิเสธ กรุณากดยินยอมเพื่อให้แอปแสดงตำแหน่งของคุณ',
      );
    }

    // TODO 4: เรียก getLocation() เพื่ออ่านข้อมูลตำแหน่ง
    LocationData locationData;
    try {
      locationData = await _location.getLocation();
    } catch (e) {
      throw Exception('ไม่สามารถอ่านพิกัดจากเซนเซอร์ได้: $e');
    }

    // TODO 5: ตรวจสอบ latitude และ longitude ว่าไม่เป็น null
    if (locationData.latitude == null || locationData.longitude == null) {
      throw Exception(
        'ไม่สามารถระบุพิกัด Latitude หรือ Longitude จากอุปกรณ์ได้',
      );
    }

    // TODO 6: คืนค่า LocationResult
    return LocationResult(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      updatedAt: DateTime.now(),
    );
  }
}
