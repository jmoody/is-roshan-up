import SwiftUI
import Combine
import Intents
import Photos

class IRUQIntentHandler: ObservableObject {

  @Published var startTimeSeconds: Int
  var userActivity: NSUserActivity

  init (userActivity: NSUserActivity) {
    self.userActivity = userActivity
    if userActivity.activityType == "Preview" {
      self.startTimeSeconds = 1289
    } else if userActivity.activityType == "Placeholder" {
      self.startTimeSeconds = 0
    } else {
      let userInfo = userActivity.userInfo
      let seconds = userInfo!["seconds", default: 1289]
      self.startTimeSeconds = seconds as! Int
    }
    print("activity type: \(userActivity.activityType)")
    print("start time: \(self.startTimeSeconds)")
  }

  func handleActivity() {
    if userActivity.activityType == "Preview" {
      self.startTimeSeconds = 1289
    } else if userActivity.activityType == "Placeholder" {
      self.startTimeSeconds = 0
    } else {
      let userInfo = userActivity.userInfo
      let seconds = userInfo!["seconds"]
      self.startTimeSeconds = seconds as! Int
    }
    print("activity type: \(userActivity.activityType)")
    print("start time: \(self.startTimeSeconds)")
  }
}
