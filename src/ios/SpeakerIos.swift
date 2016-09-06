import AVFoundation

@objc(SpeakerIos) class SpeakerIos : CDVPlugin {

    var enabled = true

  dynamic private func audioRouteChangeListener(notification:NSNotification) {

    if (enabled){
     let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey]

        let xx = audioRouteChangeReason!.intValue

        let session:AVAudioSession = AVAudioSession.sharedInstance()

        switch xx {

        //Case 3 is category change
        case 3:
               do {
                      try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
                  } catch _ {

                  }
        default:
            break
        }
    }

   }

  func enableSpeaker(command: CDVInvokedUrlCommand){

    NSNotificationCenter.defaultCenter().addObserver(
          self,
          selector: "audioRouteChangeListener:",
          name: AVAudioSessionRouteChangeNotification,
          object: nil)

    enabled = command.arguments[0] as? Bool ?? true

    let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAsString: "done"
          )

    self.commandDelegate!.sendPluginResult(
      pluginResult,
      callbackId: command.callbackId
    )

  }


}