(
s.waitForBoot({

    //Buffer & Sample
    ~buf = Buffer.read(s, ".wav");

	// SynthDef
    SynthDef(\Sample, {
        |out=0, gain=1.0, pitch=1.0, width=0.5, reverbMix=0, delayTime=0, delayMix=0|
        var sig, reverbed, delayed, widened, amp;

        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2);

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo pan
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Gain
        widened = widened * gain;

        // VU Meter
        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    // Synth with 0
    ~synth = Synth(\Sample, [
        \gain, 1.0,
        \width, 0.5,
        \pitch, 1.0,
        \reverbMix, 0,
        \delayTime, 0,
        \delayMix, 0
    ]);

    // GUI
    ~w = Window("PLUGIN", Rect(100, 100, 460, 600))
        .background_(Color.gray(0.1))
        .front;

    ~makeSlider = { |label, y, default, key|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(Color.red.blend(Color.black, 0.7))
            .action_({ |s| ~synth.set(key, s.value) });
    };

    ~sliders = (
        gain: ~makeSlider.("Gain", 20, 1.0, \gain),
        width: ~makeSlider.("Pan", 70, 0.5, \width),
        pitch: ~makeSlider.("Pitch", 120, 1.0, \pitch),
        reverb: ~makeSlider.("Reverb", 170, 0, \reverbMix),
        delayTime: ~makeSlider.("Delay Time", 220, 0, \delayTime),
        delayMix: ~makeSlider.("Delay Mix", 270, 0, \delayMix)
    );

    // Output Level
    StaticText(~w, Rect(20, 320, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~w, Rect(20, 345, 420, 25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25)).background_(Color.green);

    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');

    // Play / Stop Buttons
    ~playButton = Button(~w, Rect(20, 400, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\Sample,
                    ~sliders.collect { |s, key| [key, s.value] }.flat
                );
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    // Record
   ~playButton.action = { |btn|
    if(btn.value == 0, {
        // start recording
        s.record(path: Platform.userHomeDir ++ "/Desktop/sample.wav");

        // stop old synth
        ~synth.notNil.if({ ~synth.free });

        // start synth
        ~synth = Synth(\Sample,
            ~sliders.collect { |s, key| [key, s.value] }.flat
        );
    }, {
        ~synth.notNil.if({ ~synth.free });
        // stop recording
        s.stopRecording;
    });
};

    // Space key to Play
   Routine({
    inf.do {
        if(KeyState.kr(\space), {
            ~playButton.value = 1 - ~playButton.value;
            ~playButton.action.value(~playButton);
            0.3.wait; // debounce
        });
        0.05.wait;
    }
}).play(AppClock);
});
)
