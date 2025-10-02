import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Retorna todas as informações do app + device em JSON
  static Future<Map<String, dynamic>> collectAsJson() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceData = await _getDeviceData();

    final result = {
      "app": {
        "appName": packageInfo.appName,
        "packageName": packageInfo.packageName,
        "version": packageInfo.version,
        "buildNumber": packageInfo.buildNumber,
        "buildSignature": packageInfo.buildSignature,
      },
      "device": deviceData,
    };

    return result;
  }

  /// Retorna um Map de informações do dispositivo dependendo da plataforma
  static Future<Map<String, dynamic>> _getDeviceData() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return {
          "platform": "android",
          "brand": info.brand,
          "model": info.model,
          "device": info.device,
          "hardware": info.hardware,
          "isPhysicalDevice": info.isPhysicalDevice,
          "version": {
            "sdkInt": info.version.sdkInt,
            "release": info.version.release,
            "codename": info.version.codename,
          },
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return {
          "platform": "ios",
          "name": info.name,
          "systemName": info.systemName,
          "systemVersion": info.systemVersion,
          "model": info.model,
          "localizedModel": info.localizedModel,
          "identifierForVendor": info.identifierForVendor,
          "isPhysicalDevice": info.isPhysicalDevice,
        };
      } else if (Platform.isLinux) {
        final info = await _deviceInfo.linuxInfo;
        return {
          "platform": "linux",
          "name": info.name,
          "version": info.version,
          "id": info.id,
          "prettyName": info.prettyName,
          "variant": info.variant,
          "variantId": info.variantId,
          "machineId": info.machineId,
        };
      } else if (Platform.isMacOS) {
        final info = await _deviceInfo.macOsInfo;
        return {
          "platform": "macos",
          "computerName": info.computerName,
          "hostName": info.hostName,
          "arch": info.arch,
          "model": info.model,
          "kernelVersion": info.kernelVersion,
          "osRelease": info.osRelease,
          "majorVersion": info.majorVersion,
          "minorVersion": info.minorVersion,
          "patchVersion": info.patchVersion,
        };
      } else if (Platform.isWindows) {
        final info = await _deviceInfo.windowsInfo;
        return {
          "platform": "windows",
          "computerName": info.computerName,
          "numberOfCores": info.numberOfCores,
          "systemMemoryInMegabytes": info.systemMemoryInMegabytes,
          "userName": info.userName,
          "majorVersion": info.majorVersion,
          "minorVersion": info.minorVersion,
          "buildNumber": info.buildNumber,
          "productName": info.productName,
          "releaseId": info.releaseId,
        };
      } else {
        return {"platform": "unknown"};
      }
    } catch (e) {
      return {"platform": "error", "error": e.toString()};
    }
  }
}
