import Foundation
import Intents

class IRUQExtStartWorkoutIntentHandler: NSObject, INStartWorkoutIntentHandling {

  func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
    let response: INStartWorkoutIntentResponse
    let activityType = "com.isroshup.isroshupintent"
    let activity = NSUserActivity(activityType: activityType)
    activity.userInfo = [
      "seconds" : intent.goalValue!,
    ] as [String : Any]
    response = INStartWorkoutIntentResponse(code: .continueInApp, userActivity: activity)
    print("seconds: \(intent.goalValue!)")
    completion(response)
  }
}
