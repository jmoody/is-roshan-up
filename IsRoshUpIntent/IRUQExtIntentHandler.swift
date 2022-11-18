import Intents

class IRUQExtIntentHandler: INExtension {

  override func handler(for intent: INIntent) -> Any? {
    if intent is INStartWorkoutIntent {
      return IRUQExtStartWorkoutIntentHandler()
    }
    return nil
  }
}
