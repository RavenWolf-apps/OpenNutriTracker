import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Required by flutter_local_notifications so foreground notifications are
    // displayed instead of being silently dropped (#312). The conformance is
    // declared explicitly below so this assignment is a compile error if a
    // future Flutter / plugin reorganisation drops it, instead of the previous
    // `as?` cast which silently resolved to nil.
    UNUserNotificationCenter.current().delegate = self
    // Exclude the documents folder from iCloud backup.
    try! setExcludeFromiCloudBackup(isExcluded: true)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {}

private func setExcludeFromiCloudBackup(isExcluded: Bool) throws {
    var fileOrDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    var values = URLResourceValues()
    values.isExcludedFromBackup = isExcluded
    try fileOrDirectoryURL.setResourceValues(values)
}
