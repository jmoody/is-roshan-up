import SwiftUI

struct ContentView: View {

  @StateObject var roshTimer: IRUQRoshTimer = IRUQRoshTimer()

  @StateObject var intentHandler: IRUQIntentHandler

  var body: some View {
    VStack {
      Text("Is Roshan Up?")
        .font(.largeTitle)
        .fontWeight(.bold)

      Spacer()

      VStack(alignment: .center) {
        Text(roshTimer.stringForRoshState())
          .font(.largeTitle)
      }

      Spacer()

      // times
      VStack(alignment: .trailing) {
        // expires
        HStack {
          Text("Aegis Expires: ")
            .font(.largeTitle)
          Text(stringForAegisExpires(startTime: intentHandler.startTimeSeconds,
                                     timer: roshTimer))
          .font(.largeTitle)
        }
        // could be up
        HStack {
          Text("Could be up: ")
            .font(.largeTitle)
          Text(stringForRoshCouldBeUp(startTime: intentHandler.startTimeSeconds,
                                      timer: roshTimer))
          .font(.largeTitle)
        }
        // is up
        HStack {
          Text("Is up: ")
            .font(.largeTitle)
          Text(stringForRoshIsUp(startTime: intentHandler.startTimeSeconds,
                                 timer: roshTimer))
            .font(.largeTitle)
        }
      }

      Spacer()

      // timers
      VStack(alignment: .trailing) {
        // expires
        HStack {
          Text("Aegis Expires: ")
            .font(.custom("Courier", fixedSize: 24))
          Text(stringTimeUntilAegisExpires(timer: roshTimer))
            .font(.custom("Courier", fixedSize: 34))
        }
        // could be up
        HStack {
          Text("Could be up: ")
            .font(.custom("Courier", fixedSize: 24))
          Text(stringTimeUntilPossibleRespawn(timer:roshTimer))
            .font(.custom("Courier", fixedSize: 34))
        }
        // is up
        HStack {
          Text("Is up: ")
            .font(.custom("Courier", fixedSize: 24))
          Text(stringTimeUntilHasRespawned(timer:roshTimer))
            .font(.custom("Courier", fixedSize: 34))
        }
      }

      Spacer()

      // buttons
      VStack {
        Button(action: {
          roshTimer.startTimer()
          print("timer started")
        }, label: {
          Text("Start Timer")
            .font(.largeTitle)
            .foregroundColor(.orange)
            .frame(width:204, height:64)
            .background(.gray)
            .padding()
        })
        Button(action: {
          resetApp(timer: roshTimer, intentHandler: intentHandler)
        }, label: {
          Text("Reset")
            .font(.largeTitle)
            .foregroundColor(.orange)
            .frame(width:204, height:64)
            .background(.gray)
            .padding()
        })
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(intentHandler: IRUQIntentHandler(userActivity: NSUserActivity(activityType: "Preview")))
      .previewDevice("iPhone 14")
      .previewDisplayName("iPhone 14")
  }
}

func stringByAddingMinutes(startTime: Int, offset: Int, timer: IRUQRoshTimer) -> String {
  if startTime == 0 {
    return "--:--"
  }

  if !timer.isRunning {
    timer.startTimer()
  }

  let minutes = startTime / 60
  let seconds = startTime % 60
  return "\(minutes + offset):\(seconds)"
}

func stringForAegisExpires(startTime: Int, timer: IRUQRoshTimer) -> String {
  return stringByAddingMinutes(startTime: startTime, offset: 5, timer: timer)
}

func stringForRoshCouldBeUp(startTime: Int, timer: IRUQRoshTimer) -> String {
  return stringByAddingMinutes(startTime: startTime, offset: 8, timer: timer)
}

func stringForRoshIsUp(startTime: Int, timer: IRUQRoshTimer) -> String {
  return stringByAddingMinutes(startTime: startTime, offset: 11, timer: timer)
}

func stringTimeUntilAegisExpires(timer: IRUQRoshTimer) -> String {
  let secondsRemaining = (5 * 60) - timer.elapsedSeconds
  if secondsRemaining <= 0 || !timer.isRunning {
    return "--:--"
  } else {
    let minutes = secondsRemaining/60
    let seconds = secondsRemaining%60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}

func stringTimeUntilPossibleRespawn(timer: IRUQRoshTimer) -> String {
  let secondsRemaining = (8 * 60) - timer.elapsedSeconds
  if secondsRemaining <= 0 || !timer.isRunning {
    return "--:--"
  } else {
    let minutes = secondsRemaining/60
    let seconds = secondsRemaining%60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}

func stringTimeUntilHasRespawned(timer: IRUQRoshTimer) -> String {
  let secondsRemaining = (11 * 60) - timer.elapsedSeconds
  if secondsRemaining <= 0 || !timer.isRunning {
    return "--:--"
  } else {
    let minutes = secondsRemaining/60
    let seconds = secondsRemaining%60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}

func resetApp(timer: IRUQRoshTimer, intentHandler: IRUQIntentHandler) {
  intentHandler.startTimeSeconds = 0
  timer.resetCount()
}
