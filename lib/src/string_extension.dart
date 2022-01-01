import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/app_constants.dart';
import 'constants/input_formatter_constants.dart';
import 'constants/regex_constants.dart';
import 'exception/package_info_exception.dart';
import 'utility/device_utility.dart';
import 'package:diacritic/diacritic.dart';

extension StringColorExtension on String {
  Color get color => Color(int.parse('0xff$this'));
}

extension StringValidatorExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? false;
  bool get isNotNullOrNoEmpty => this?.isNotEmpty ?? false;

  bool get isValidEmail => this != null ? RegExp(RegexConstans.instance.emailRegex).hasMatch(this!) : false;
  bool get isValidPassword => this != null ? RegExp(RegexConstans.instance.passwordRegex).hasMatch(this!) : false;

  String? get withotSpecialCharacters {
    return isNullOrEmpty ? this : removeDiacritics(this!);
  }
}

extension AuthorizationExtension on String {
  Map<String, dynamic> get beraer => {'Authorization': 'Bearer ${this}'};
}

extension LaunchExtension on String {
  Future<bool> get launchEmail => launch('mailto:$this');
  Future<bool> get launchPhone => launch('tel:$this');
  Future<bool> get launchWebsite => launch(this);

  Future<bool> launchWebsiteCustom({
    bool? forceSafariVC,
    bool forceWebView = false,
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    bool universalLinksOnly = false,
    Map<String, String> headers = const <String, String>{},
    Brightness? statusBarBrightness,
    String? webOnlyWindowName,
  }) =>
      launch(this,
          forceSafariVC: forceSafariVC,
          forceWebView: forceWebView,
          enableDomStorage: enableDomStorage,
          enableJavaScript: enableJavaScript,
          universalLinksOnly: universalLinksOnly,
          headers: headers,
          statusBarBrightness: statusBarBrightness,
          webOnlyWindowName: webOnlyWindowName);
}

extension ShareText on String {
  Future<void> shareWhatsApp() async {
    try {
      final isLaunch = await launch('${KartalAppConstants.WHATS_APP_PREFIX}$this');
      if (!isLaunch) await share();
    } catch (e) {
      await share();
    }
  }

  Future<void> shareMail(String title) async {
    final value = DeviceUtility.instance.shareMailText(title, this);
    final isLaunch = await launch(Uri.encodeFull(value));
    if (!isLaunch) await value.share();
  }

  Future<void> share() async {
    if (Platform.isIOS) {
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) {
        await Share.share(this, sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom);
      }
    }

    await Share.share(this);
  }
}

extension FormatterExtension on String {
  String get phoneFormatValue => InputFormatter.instance.phoneFormatter.unmaskText(this);
  String get timeFormatValue => InputFormatter.instance.timeFormatter.unmaskText(this);
  String get timeOverlineFormatValue => InputFormatter.instance.timeFormatterOverLine.unmaskText(this);
}

extension PackageInfoExtension on String {
  String get appName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.appName;
    }
  }

  String get packageName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.packageName;
    }
  }

  String get version {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.version;
    }
  }

  String get buildNumber {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.buildNumber;
    }
  }
}

extension NetworkImageExtension on String {
  String get randomImage => 'https://picsum.photos/200/300';
  String get randomSquareImage => 'https://picsum.photos/200';

  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';
  String get customHighProfileImage => 'https://www.gravatar.com/avatar/?d=mp&s=200';
}
