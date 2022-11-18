import SwiftUI
import Intents

@main
struct isroshupApp: App {

  @Environment(\.scenePhase) private var scenePhase

  var intentHandler: IRUQIntentHandler = IRUQIntentHandler(userActivity: NSUserActivity(activityType: "Placeholder"))

  var body: some Scene {
    WindowGroup {
      ContentView(intentHandler: intentHandler)
        .onContinueUserActivity("com.isroshup.isroshupintent",
                                perform: { userActivity in
          intentHandler.userActivity = userActivity
          intentHandler.handleActivity()
        })
    }.onChange(of: scenePhase) { phase in
      INPreferences.requestSiriAuthorization { (status) in
        // handle errors
      }
    }
  }
}
