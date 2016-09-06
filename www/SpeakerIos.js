var exec = require('cordova/exec');


exports.enableSpeaker = function (enable, success, error) {
    exec(success, error, "SpeakerIos", "enableSpeaker", [enable]);
};

