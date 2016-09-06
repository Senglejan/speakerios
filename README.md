# speakerios
A Cordova plugin which enables WebRTC audio from loud speaker in IOS


**Note:** The plugin is written in swift, if this is the only swift plugin your application is using, before installing this plugin install [https://github.com/akofman/cordova-plugin-add-swift-support.git] first to enable Swift support and managing bridging header automatically.


```
speakerIos.enableSpeaker(true, function () {
    console.log('Done');
}, function () {
    console.log('Err');
});

```



