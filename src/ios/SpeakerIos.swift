import AVFoundation

@objc(SpeakerIos) class SpeakerIos : CDVPlugin {

    var enabled = true

  dynamic private func audioRouteChangeListener(notification:NSNotification) {

    if (enabled){

        let session:AVAudioSession = AVAudioSession.sharedInstance()

        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt

        switch audioRouteChangeReason {

            case AVAudioSessionRouteChangeReason.categoryChange.rawValue:

               do {
                      try session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                  } catch  {

                  }
               break;
        default:
            break
        }
    }

   }

 @objc(enableSpeaker:)
  func enableSpeaker(command: CDVInvokedUrlCommand){

    NotificationCenter.default.addObserver(
          self,
          selector: #selector(SpeakerIos.audioRouteChangeListener(notification:)),
          name: .AVAudioSessionRouteChange,
          object: nil)

        println("Speaker IOS : Enabling speaker ios..")

    enabled = command.arguments[0] as? Bool ?? true

    if enabled {
           let session:AVAudioSession = AVAudioSession.sharedInstance()

           if session.setCategory(AVAudioSessionCategoryPlayback, withOptions:AVAudioSessionCategoryOptions.MixWithOthers,

            error: &audioSessionError) {
            println("Speaker IOS : Successfully set the audio session")
            } else {
               println("Speaker IOS : Could not set the audio session")
            }
      }


    let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: "done"
          )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )

  }


}
