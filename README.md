# My Location Explorer (Lab 8)

A Flutter mobile application that checks device location services, requests permissions, reads real-time GPS coordinates, displays an interactive map using **OpenStreetMap**, and calculates the distance to a reference landmark.

---

## 👤 Student Information
* **Name:** Mr. Sirasit Songpaeng
* **Student ID:** 6630300807
* **University:** Kasetsart University, Sriracha Campus
* **Course:** 03603437 - Mobile Application Development
 (Lab 8: Flutter Packages, Location Services, and OpenStreetMap)

---

## Sequence Diagram
```mermaid
sequenceDiagram
    autonumber
    actor User as ผู้ใช้ (User)
    participant Home as HomePage (UI)
    participant Service as LocationService
    participant OS as OS / GPS Sensor
    participant Map as MapPage (OpenStreetMap)
    participant LatLong as latlong2 (Distance)

    %% 1. เริ่มต้นอ่านตำแหน่ง
    User->>Home: 1. กดปุ่ม "อ่านตำแหน่ง" (หรือ Refresh)
    Home->>Home: 2. เปลี่ยนสถานะเป็น Loading State (แสดง CircularProgressIndicator)
    Home->>Service: 3. เรียก getCurrentLocation()

    %% 2. ตรวจสอบ Location Service & Permission
    Service->>OS: 4. ตรวจสอบ serviceEnabled()
    alt Location Service ปิดอยู่
        Service->>OS: 5. เรียก requestService() เพื่อขอให้เปิด GPS
    end

    Service->>OS: 6. ตรวจสอบ hasPermission()
    alt ยังไม่ได้รับสิทธิ์ (denied)
        Service->>OS: 7. เรียก requestPermission() เพื่อขอสิทธิ์จากผู้ใช้
    end

    %% 3. อ่านพิกัดหรือจัดการ Error
    alt ผู้ใช้ไม่อนุญาต หรือ ปิด GPS
        Service-->>Home: 8. โยน Exception แจ้งเตือนข้อผิดพลาด
        Home->>Home: 9. ดักจับด้วย try-catch แสดง Error State + ปุ่ม "ลองใหม่"
    else ได้รับอนุญาตสำเร็จ
        Service->>OS: 10. อ่านพิกัดผ่าน getLocation()
        OS-->>Service: 11. คืนค่า LocationData (latitude, longitude)
        Service-->>Home: 12. คืนค่าเป็น LocationResult (lat, lng, updatedAt)
        Home->>Home: 13. เช็ค mounted แล้ว setState แสดงผลพิกัด (Success State)
    end

    %% 4. ดูบนแผนที่ (Part 5)
    opt ผู้ใช้กดดูแผนที่
        User->>Home: 14. กดปุ่ม "ดูบนแผนที่"
        Home->>Map: 15. ส่งต่อ LocationResult ผ่าน Navigator.push()
        Map-->>User: 16. แสดง OpenStreetMap พร้อมปัก Marker สีแดงตรงพิกัด
    end

    %% 5. คำนวณระยะทาง (Bonus C)
    opt ผู้ใช้กดคำนวณระยะทาง
        User->>Home: 17. กดปุ่ม "Find Distance"
        Home->>LatLong: 18. คำนวณระยะทางระหว่างพิกัดปัจจุบันกับ KU บางเขน ด้วย Distance().as()
        LatLong-->>Home: 19. คืนค่าระยะทางเป็นเมตร (Meter)
        Home-->>User: 20. แสดง Modal Bottom Sheet แจ้งระยะทาง (เมตร หรือ กิโลเมตร)
    end
```
---

## 🤖 How AI Was Used (Dual-Chat Workflow)

For this project, I used an **AI-Assisted Pair Programming** approach with two separate AI chats to keep the work organized:

```mermaid
flowchart TD
    A["1. Define project requirements and Lab 8 scope"] --> B["2. Design Chat: Draft UI with Google Stitch & Weave System"]
    A --> C["3. Logic Chat: Plan architecture with /plan command"]
    B --> D["4. Combine UI layout with 4 App States (Initial, Loading, Success, Error)"]
    C --> E["5. Build LocationService, handle permissions, and calculate distance"]
    D --> F["6. Test all checkpoints on real device and emulator"]
    E --> F
    F --> G["7. Complete Bonus C: Find Distance to KU Bangkhen"]
```

### 1. Chat 1: Design & UI/UX (Design Chat)
* **UI Prototyping:** Used AI to quickly turn UI ideas from Google Stitch into clean Flutter widgets.
* **Design Consistency:** Applied the **Weave Design System** (warm canvas colors, terracotta accents, and status badges) to create a modern and easy-to-read interface.

### 2. Chat 2: Logic & Architecture (Working Chat)
* **Step-by-Step Planning:** Used the `/plan` command to design the system flow before writing code.
* **Safe Error Handling:** Implemented proper permission checks and wrapped location requests in `try-catch` blocks to prevent app crashes.
* **Feature Development (Bonus C):** Used the `latlong2` package to calculate the real-world distance between the user and Kasetsart University (Bangkhen Campus).

> **Summary:** *I worked as the project lead and reviewer—making decisions, writing core logic, and checking code quality—while AI served as a fast assistant for drafting layouts and boilerplate code.*

---

## 📦 Package Installation

Open your terminal in the project folder and run:

```bash
flutter pub get
```

### Main Packages Used (`pubspec.yaml`):
* `location: ^10.0.2` – Checks location services, requests permissions, and reads GPS coordinates.
* `flutter_map: ^8.3.2` – Displays interactive OpenStreetMap tiles without needing an API key.
* `latlong2: ^0.10.1` – Manages `LatLng` coordinates and calculates distances.
* `intl: ^0.20.3` – Formats dates, times, and numbers.

---

## 🚀 How to Run the App

Make sure your emulator is running or a physical device is connected, then run:

```bash
flutter run
```

---

## 🌟 Key Features
1. **Real-Time GPS Location:** Reads latitude, longitude, and last updated time.
2. **Four UI States:** Clear user feedback for Initial, Loading, Success, and Error states.
3. **OpenStreetMap Integration:** Shows current location with a red marker.
4. **Package Information Page:** Displays all installed packages and their purposes in a clean list.
5. **Bonus C (Find Distance):** Calculates the surface distance to Kasetsart University (Bangkhen Campus) with automatic unit conversion (meters or kilometers).

---

## 📸 Picture
<img width="465" height="892" alt="a_หน้าแรกก่อนอ่านตําแหน่ง" src="https://github.com/user-attachments/assets/0214af87-6e11-4729-af61-c2c2f72a07b0" />
<img width="477" height="892" alt="b_ขณะกําลังอ่านตําแหน่ง" src="https://github.com/user-attachments/assets/e1c4a489-6bbc-42a3-bf90-a084bd43611f" />
<img width="471" height="897" alt="c_หน้าจอที่แสดง Latitude และ Longitude สําเร็จ" src="https://github.com/user-attachments/assets/11904309-88f8-4042-b2ba-65adb2b5bd7d" />
<img width="471" height="900" alt="d_หน้าแผนที่พร้อม Marker" src="https://github.com/user-attachments/assets/24731ca9-8025-419e-b7ab-c84fae1550f1" />
<img width="476" height="902" alt="e_หน้า Package Information" src="https://github.com/user-attachments/assets/bd6bda9d-82ce-4d1e-bfb4-c8bccaff7b98" />
<img width="472" height="896" alt="f_Bonus C แสดงระยะห่างจากจุดอ้างอิง" src="https://github.com/user-attachments/assets/a0a83393-c3fa-497c-9ce8-2548b74eab34" />




