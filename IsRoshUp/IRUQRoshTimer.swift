import Foundation
import Combine

class IRUQRoshTimer : ObservableObject {

  @Published var elapsedSeconds = 0
  @Published var isRunning = false

  enum RoshanUp {
    case unknown
    case down
    case maybe
    case respawned
  }

  @Published var roshState: RoshanUp = .unknown

  var timer : Timer?

  func startTimer() {
    if isRunning {
      print("timer is already running; nothing to do")
      return
    }

    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(timerDidFire),
                                 userInfo: nil,
                                 repeats: true)
    isRunning = true
  }

  @objc func timerDidFire() {
    elapsedSeconds = elapsedSeconds + 1
    if elapsedSeconds < 8 * 60 {
      roshState = .down
    } else if elapsedSeconds <= 8 * 60 {
      roshState = .maybe
    } else if elapsedSeconds < 11 * 60 {
      roshState = .respawned
    }
  }

  func resetCount() {
    elapsedSeconds = 0
    timer?.invalidate()
    isRunning = false
    roshState = .unknown
  }

  func stringForRoshState() -> String {
    switch self.roshState {
    case .down:
      return "Roshan is down."
    case .maybe:
      return "Roshan could be up."
    case .respawned:
      return "Roshan is up."
    default:
      return "Unknown"
    }
  }
}
