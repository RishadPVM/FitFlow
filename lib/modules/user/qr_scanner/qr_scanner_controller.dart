import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrScannerController extends GetxController {
  MobileScannerController? scannerController;

  var isTorchOn = false.obs;
  var isScanning = true.obs;
  var hasPermission = false.obs;

  @override
  void onInit() {
    super.onInit();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      hasPermission.value = true;
      scannerController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: false,
      );
      update(); // trigger UI rebuild
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // send user to settings
    } else {
      Get.snackbar('Permission Denied', 'Camera access is required to scan QR codes');
    }
  }

  void toggleTorch() {
    scannerController?.toggleTorch();
    isTorchOn.value = !isTorchOn.value;
  }

  void onDetect(BarcodeCapture capture) {
    if (!isScanning.value) return;
    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      if (barcode.rawValue != null) {
        isScanning.value = false;
        Get.back(result: barcode.rawValue);
      }
    }
  }

  @override
  void onClose() {
    scannerController?.dispose();
    super.onClose();
  }
}