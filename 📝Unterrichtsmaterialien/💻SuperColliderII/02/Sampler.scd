(
s.waitForBoot({

    //Buffer & Sample
    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Mura Masa - Miss You.wav");

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
    ~w = Window("DoraBrilliant", Rect(100, 100, 460, 600))
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























(
s.waitForBoot({

    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Mura Masa - Miss You.wav");

    SynthDef(\Sample, {
        |out=0, gain=1.0, pitch=1.0, width=0.5, reverbMix=0, delayTime=0, delayMix=0|
        var sig, reverbed, delayed, widened, amp;

        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2);

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Apply gain
        widened = widened * gain;

        // VU Meter
        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    // Initial Synth with 0 Reverb/Delay
    ~synth = Synth(\Sample, [
        \gain, 1.0,
        \width, 0.5,
        \pitch, 1.0,
        \reverbMix, 0,
        \delayTime, 0,
        \delayMix, 0
    ]);

    //  GUI
    ~w = Window("DoraBrilliant", Rect(100, 100, 460, 600))
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

    // VU Meter
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

    // Play / Stop / Record Buttons
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

   ~recordButton = Button(~w, Rect(160, 400, 120, 35))
    .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
    .font_(Font("Helvetica", 14))
    .action_({ |btn|
        if(btn.value == 0, {
            // Сначала начинаем запись
            s.record(path: Platform.userHomeDir ++ "/Desktop/sample.wav");
            "🎙 Recording started...".postln;

            // Потом создаём и запускаем Synth
            ~synth.notNil.if({ ~synth.free });
            ~synth = Synth(\Sample,
                ~sliders.collect { |s, key| [key, s.value] }.flat
            );
        }, {
            // Останавливаем Synth и запись
            ~synth.notNil.if({ ~synth.free });
            s.stopRecording;
            "💾 Recording saved on Desktop.".postln;
        });
    });

    // Space key global
    Routine({
        inf.do {
            if(KeyState.space, {
                ~playButton.value = 1 - ~playButton.value;
                ~playButton.action.value(~playButton);
                0.3.wait; // debounce
            });
            0.05.wait;
        }
    }).play(AppClock);

});
)































(
s.waitForBoot({

    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Mura Masa - Miss You.wav");

    SynthDef(\Sample, {
        |out=0, gain=1.0, pitch=1.0, width=0.5, reverbMix=0, delayTime=0, delayMix=0 |
        var sig, reverbed, delayed, widened, amp;

        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2);

        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        widened = widened * gain;

        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    //  Synth with 0 Reverb/Delay
    ~synth = Synth(\Sample, [
		\gain, 1.0,
		\width, 0.5,
        \pitch, 1.0,
        \reverbMix, 0,
        \delayTime, 0,
        \delayMix, 0

    ]);

	//  GUI
    ~w = Window("DoraBrilliant", Rect(100, 100, 460, 600))
        .background_(Color.gray(0.1))
        .front;

    ~makeSlider = { |label, y, default, key|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(Color.red.blend(Color.black, 0.7))
            .action_({ |s| ~synth.set(key, s.value) });
    };

    ~sliders = (
		gain: ~makeSlider.("Gain", 220, 1.0, \gain),
		 width: ~makeSlider.("Pan", 170, 0.5, \width),
		pitch: ~makeSlider.("Pitch", 270, 1.0, \pitch,
        reverb: ~makeSlider.("Reverb", 20, 0, \reverbMix),
        delayTime: ~makeSlider.("Delay Time", 70, 0, \delayTime),
        delayMix: ~makeSlider.("Delay Mix", 120, 0, \delayMix)
        )
    );

    // VU Meter
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

    // Play / Stop / Record Buttons
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

    ~recordButton = Button(~w, Rect(160, 400, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/sample.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

   //Routine
    Routine({
        inf.do {
            if(KeyState.space, {
                ~playButton.value = 1 - ~playButton.value;
                ~playButton.action.value(~playButton);
                0.3.wait; // debounce
            });
            0.05.wait;
        }
    }).play(AppClock);

});
)


































(
s.waitForBoot({

    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Mura Masa - Miss You.wav");

    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=0.5, gain=1.0, pitch=1.0|
        var sig, reverbed, delayed, widened, amp;

        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2);

        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        widened = widened * gain;

        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    ~synth = Synth(\guitarSamplePlugin, [
        \reverbMix, 0.5,
        \delayTime, 0.3,
        \delayMix, 0.3,
        \width, 0.5,
        \gain, 1.0,
        \pitch, 1.0
    ]);

    // --- GUI ---
    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 600))
        .background_(Color.gray(0.1))
        .front;

    ~makeSlider = { |label, y, default, key|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(Color.red.blend(Color.black, 0.7))
            .action_({ |s| ~synth.set(key, s.value) });
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5, \reverbMix),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3, \delayTime),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3, \delayMix),
        width: ~makeSlider.("Stereo Width", 170, 0.5, \width),
        gain: ~makeSlider.("Gain", 220, 1.0, \gain),
        pitch: ~makeSlider.("Pitch/Speed", 270, 1.0, \pitch)
    );

    // --- VU Meter ---
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

    // --- Play / Stop / Record Buttons ---
    ~playButton = Button(~w, Rect(20, 400, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin,
                    ~sliders.collect { |s, key| [key, s.value] }.flat
                );
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    ~recordButton = Button(~w, Rect(160, 400, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- Space key глобально ---
    Routine({
        inf.do {
            if(KeyState.space, {
                ~playButton.value = 1 - ~playButton.value;
                ~playButton.action.value(~playButton);
                0.3.wait; // debounce, чтобы не срабатывало несколько раз подряд
            });
            0.05.wait;
        }
    }).play(AppClock);

});
)































(
// 🎸 Guitar Sample Player PRO — real-time Pitch, Gain, Stereo

s.waitForBoot({

 ~buf = Buffer.read(s,"/Users/mila/Supercollider/Sample/Miss You.wav" ); // поменяй путь на свой WAV

    // --- SynthDef с семплом, гейном, Pitch/Speed и stereo ---
    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=0.5, gain=1.0, pitch=1.0|
        var sig, reverbed, delayed, widened, amp;

        // PlayBuf с контролируемым pitch
        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2); // моно

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delayю
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width, центр = 0
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Apply gain
        widened = widened * gain;

        // VU Meter
        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    // --- Создаем Synth заранее ---
    ~synth = Synth(\guitarSamplePlugin, [
        \reverbMix, 0.5,
        \delayTime, 0.3,
        \delayMix, 0.3,
        \width, 0.5,  // центр стерео
        \gain, 1.0,
        \pitch, 1.0
    ]);

    // --- GUI ---
    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 600))
        .background_(Color.gray(0.1))
        .front;

    ~makeSlider = { |label, y, default, key|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(Color.red.blend(Color.black, 0.7))
            .action_({ |s| ~synth.set(key, s.value) });
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5, \reverbMix),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3, \delayTime),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3, \delayMix),
        width: ~makeSlider.("Stereo Width", 170, 0.5, \width), // старт в центре
        gain: ~makeSlider.("Gain", 220, 1.0, \gain),
        pitch: ~makeSlider.("Pitch/Speed", 270, 1.0, \pitch)
    );

    // --- VU Meter ---
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

    // --- Play / Stop / Record Buttons ---
    ~playButton = Button(~w, Rect(20, 400, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin,
                    ~sliders.collect { |s, key| [key, s.value] }.flat
                );
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    ~recordButton = Button(~w, Rect(160, 400, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- Привязка play/stop к пробелу ---
    ~keyFunc = {
        arg key;
        if(key == 32, {  // код пробела
            ~playButton.value = 1 - ~playButton.value; // переключаем состояние кнопки
            ~playButton.action.value(~playButton);       // вызываем action
        });
    };

    thisProcess.keyDownAction = ~keyFunc;
});
)
















(
(
// 🎸 Guitar Sample Player PRO — real-time Pitch, Gain, Stereo

s.waitForBoot({

   ~buf = Buffer.read(s,"/Users/mila/Supercollider/Sample/Miss You.wav" ); // поменяй путь на свой WAV

    // --- SynthDef с семплом, гейном, Pitch/Speed и stereo ---
    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=1.0, gain=1.0, pitch=1.0|
        var sig, reverbed, delayed, widened, amp;

        // PlayBuf с контролируемым pitch
        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2); // моно

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Apply gain
        widened = widened * gain;

        // VU Meter
        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;

    // --- Создаем Synth заранее ---
    ~synth = Synth(\guitarSamplePlugin, [
        \reverbMix, 0.5,
        \delayTime, 0.3,
        \delayMix, 0.3,
        \width, 1.0,
        \gain, 1.0,
        \pitch, 1.0
    ]);

    // --- GUI ---
    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 600))
        .background_(Color.gray(0.1))
        .front;

    ~makeSlider = { |label, y, default, key|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(Color.red.blend(Color.black, 0.7))
            .action_({ |s| ~synth.set(key, s.value) });
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5, \reverbMix),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3, \delayTime),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3, \delayMix),
        width: ~makeSlider.("Stereo Width", 170, 1.0, \width),
        gain: ~makeSlider.("Gain", 220, 1.0, \gain),
        pitch: ~makeSlider.("Pitch/Speed", 270, 1.0, \pitch)
    );

    // --- VU Meter ---
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

    // --- Play / Stop / Record Buttons ---
    ~playButton = Button(~w, Rect(20, 400, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin,
                    ~sliders.collect { |s, key| [key, s.value] }.flat
                );
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    ~recordButton = Button(~w, Rect(160, 400, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

});
)
)















// 🎸 Guitar Sample Player PRO — с активными слайдерами и Pitch/Speed

(s.waitForBoot({

    // --- Загружаем семпл ---
   ~buf = Buffer.read(s, "/Users/mila/Desctop/mono.wav"); // поменяй путь на свой WAV

    // --- SynthDef с семплом, гейном и Pitch/Speed ---
    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=1.0, gain=1.0, pitch=1.0|
        var sig, reverbed, delayed, widened, amp;

        // Источник — WAV семпл с pitch/скоростью
        sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2); // моно

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Apply gain
        widened = widened * gain;

        // Амплитуда для VU
        amp = Amplitude.kr(widened).clip(0,1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- GUI ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 620))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3),
        width: ~makeSlider.("Stereo Width", 170, 1.0),
        gain: ~makeSlider.("Gain", 220, 1.0),
        pitch: ~makeSlider.("Pitch/Speed", 270, 1.0) // 1.0 = нормальная скорость
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 320, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~w, Rect(20, 345, 420, 25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25)).background_(Color.green);

    // --- Создаем Synth заранее ---
    ~synth = Synth(\guitarSamplePlugin, [
        \reverbMix, ~sliders[\reverb].value,
        \delayTime, ~sliders[\delayTime].value,
        \delayMix, ~sliders[\delayMix].value,
        \width, ~sliders[\width].value,
        \gain, ~sliders[\gain].value,
        \pitch, ~sliders[\pitch].value
    ]);

    // --- Слайдеры в реальном времени ---
    ~sliders.do({ |slider, key|
        slider.action_({ |s|
            ~synth.notNil.if({ ~synth.set(key, s.value) });
        });
    });

    // --- Play/Stop Button ---
    ~playButton = Button(~w, Rect(20, 400, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin, [
                    \reverbMix, ~sliders[\reverb].value,
                    \delayTime, ~sliders[\delayTime].value,
                    \delayMix, ~sliders[\delayMix].value,
                    \width, ~sliders[\width].value,
                    \gain, ~sliders[\gain].value,
                    \pitch, ~sliders[\pitch].value
                ]);
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 400, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');

});)

















(
// 🎸 Guitar Sample Player PRO — безопасная версия

s.waitForBoot({

    // --- Загружаем семпл ---
     ~buf = Buffer.read(s, "/Users/mila/Desctop/mono.wav"); // поменяй путь на свой WAV
    // --- SynthDef с семплом и гейном ---
    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=1.0, gain=1.0|
        var sig, reverbed, delayed, widened, amp;

        // Источник — WAV семпл
        sig = PlayBuf.ar(1, ~buf, doneAction:2); // моно

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Apply gain
        widened = widened * gain;

        // Амплитуда для VU
        amp = Amplitude.kr(widened).clip(0, 1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- GUI ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 580))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3),
        width: ~makeSlider.("Stereo Width", 170, 1.0),
        gain: ~makeSlider.("Gain", 220, 1.0)
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 270, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~w, Rect(20, 295, 420, 25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25)).background_(Color.green);

    // --- Play/Stop Button ---
    ~playButton = Button(~w, Rect(20, 340, 120, 35))
        .states_([
            ["▶ Play", Color.green, Color.black],
            ["■ Stop", Color.red, Color.black]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin, [
                    \reverbMix, ~sliders[\reverb].value,
                    \delayTime, ~sliders[\delayTime].value,
                    \delayMix, ~sliders[\delayMix].value,
                    \width, ~sliders[\width].value,
                    \gain, ~sliders[\gain].value
                ]);
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 340, 120, 35))
        .states_([
            ["● Record", Color.red, Color.black],
            ["■ Stop Rec", Color.gray(0.4), Color.white]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');
});
)













(
// 🎸 Guitar Sample Player PRO — безопасная версия

s.waitForBoot({

    // --- Загружаем семпл ---
    ~buf = Buffer.read(s, "/Users/mila/Desctop/mono.wav"); // поменяй путь на свой WAV

    // --- SynthDef с семплом ---
    SynthDef(\guitarSamplePlugin, {
        |out=0, reverbMix=0.5, delayTime=0.3, delayMix=0.3, width=1.0|
        var sig, reverbed, delayed, widened, amp;

        // Источник — WAV семпл
        sig = PlayBuf.ar(1, ~buf, doneAction:2); // моно

        // Reverb
        reverbed = FreeVerb.ar(sig, mix: reverbMix, room:0.8, damp:0.3);

        // Delay
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Амплитуда для VU
        amp = Amplitude.kr(widened).clip(0, 1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- GUI ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Sample Player PRO", Rect(100, 100, 460, 540))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        reverb: ~makeSlider.("Reverb", 20, 0.5),
        delayTime: ~makeSlider.("Delay Time", 70, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 120, 0.3),
        width: ~makeSlider.("Stereo Width", 170, 1.0)
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 220, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~w, Rect(20, 245, 420, 25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25)).background_(Color.green);

    // --- Play/Stop Button ---
    ~playButton = Button(~w, Rect(20, 280, 120, 35))
        .states_([
            ["▶ Play", Color.green, Color.black],
            ["■ Stop", Color.red, Color.black]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~synth.notNil.if({ ~synth.free });
                ~synth = Synth(\guitarSamplePlugin, [
                    \reverbMix, ~sliders[\reverb].value,
                    \delayTime, ~sliders[\delayTime].value,
                    \delayMix, ~sliders[\delayMix].value,
                    \width, ~sliders[\width].value
                ]);
            }, {
                ~synth.notNil.if({ ~synth.free });
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 280, 120, 35))
        .states_([
            ["● Record", Color.red, Color.black],
            ["■ Stop Rec", Color.gray(0.4), Color.white]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');
});
)

































(
SynthDef(\violinSafe, {
    |out=0, freq=440, amp=0.1, dur=1.0|
    var env, noise, tone, sig;

    // Огибающая
    env = EnvGen.kr(Env.perc(0.01, dur, 1), doneAction:2);

    // Смягчённый шум атаки (смычок)
    noise = PinkNoise.ar(0.05) * env;

    // Основной тон (одна гармоника через фильтр)
    tone = Saw.ar(freq) * env;

    // Фильтр резонатора
    tone = BPF.ar(tone, freq*1.0, 1.0); // freq*1.0 — это частота фильтра

    // Объединяем шум и тон
    sig = tone + noise;

    // Мягкий выход
    sig = sig * amp;

    Out.ar(out, sig!2); // стерео
}).add;
)



~violin.free;
~banjo = Synth(\violinSafe);




(
// 🎸 Guitar Plugin PRO Deluxe — безопасная версия

// Настройки памяти
//s.quit;
s.options.memSize = 128*1024*1024; // 128 MB
s.options.maxNodes = 1024;

s.waitForBoot({

    // --- SynthDef ---
    SynthDef(\guitarPluginProSafe, {
        |out=0, drive=1.0, reverbMix=0.5, pitch=1.0, delayTime=0.3, delayMix=0.3, tone=0.5, width=1.0, dur=2.0|
        var sig, env, driven, toned, reverbed, delayed, stereo, widened, amp;

        // Источник
        sig = Saw.ar(440);

        // Pitch
        sig = PitchShift.ar(sig, pitchRatio: pitch, windowSize: 0.1, pitchDispersion: 0.0);

        // Огибающая
        env = EnvGen.kr(Env.perc(0.01, dur, 1.0), doneAction:2);
        sig = sig * env;

        // Drive
        driven = tanh(sig * (drive * 3));

        // Tone
        toned = LPF.ar(driven, tone.linexp(0,1,400,12000));

        // Reverb — безопасный FreeVerb
        reverbed = FreeVerb.ar(toned, mix: reverbMix, room: 0.9, damp: 0.3);

        // Delay — используем безопасный DelayC
        delayed = DelayC.ar(reverbed, 1.0, delayTime);
        sig = XFade2.ar(reverbed!2, delayed!2, (delayMix*2-1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Амплитуда для VU
        amp = Amplitude.kr(widened).clip(0, 1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- GUI ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Plugin PRO Safe", Rect(100, 100, 460, 540))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 150, 20)).string_(label).stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20)).value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        drive: ~makeSlider.("Drive", 20, 1.0),
        reverb: ~makeSlider.("Reverb", 70, 0.5),
        pitch: ~makeSlider.("Pitch", 120, 1.0),
        delayTime: ~makeSlider.("Delay Time", 170, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 220, 0.3),
        tone: ~makeSlider.("Tone", 270, 0.5),
        width: ~makeSlider.("Stereo Width", 320, 1.0)
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 370, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~w, Rect(20, 395, 420, 25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25)).background_(Color.green);

    // --- Play/Stop Button ---
    ~playButton = Button(~w, Rect(20, 430, 120, 35))
        .states_([
            ["▶ Play", Color.green, Color.black],
            ["■ Stop", Color.red, Color.black]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                // Удаляем старый синт
                ~synth.notNil.if({ ~synth.free });
                ~routine = Routine({
                    loop {
                        ~synth = Synth(\guitarPluginProSafe, [
                            \drive, ~sliders[\drive].value,
                            \reverbMix, ~sliders[\reverb].value,
                            \pitch, ~sliders[\pitch].value,
                            \delayTime, ~sliders[\delayTime].value,
                            \delayMix, ~sliders[\delayMix].value,
                            \tone, ~sliders[\tone].value,
                            \width, ~sliders[\width].value,
                            \dur, 2.0
                        ]);
                        2.0.wait;
                    }
                }).play(AppClock);
            }, {
                ~routine.stop;
                ~synth.notNil.if({ ~synth.free });
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 430, 120, 35))
        .states_([
            ["● Record", Color.red, Color.black],
            ["■ Stop Rec", Color.gray(0.4), Color.white]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');
});
)





























(
// 🎸 Guitar Plugin PRO Deluxe с улучшенным ревербом

s.reboot;
s.waitForBoot({

    // --- SynthDef ---
    SynthDef(\guitarPluginPro, {
        |out=0, drive=1.0, reverbMix=0.5, pitch=1.0, delayTime=0.3, delayMix=0.3, tone=0.5, width=1.0, dur=1.0|
        var sig, env, driven, reverbed, delayedL, delayedR, stereoDelay, pitched, toned, widened, amp;

        sig = Saw.ar(440);
        pitched = PitchShift.ar(sig, pitchRatio: pitch, windowSize: 0.1, pitchDispersion: 0.0);
        env = EnvGen.kr(Env.perc(0.01, dur, 1.0), doneAction:2);
        sig = pitched * env;

        // Drive
        driven = tanh(sig * (drive * 3));

        // Tone
        toned = LPF.ar(driven, tone.linexp(0,1,400,12000));

        // --- Улучшенный Reverb ---
        reverbed = FreeVerb.ar(
            toned,
            mix: reverbMix,
            room: 0.95,   // большая комната для объёма
            damp: 0.2     // меньше поглощения высоких частот → яркий
        );

        // Delay
        delayedL = CombC.ar(reverbed, 2.0, delayTime, 3);
        delayedR = CombC.ar(reverbed, 2.0, delayTime * 1.2, 3);
        stereoDelay = [delayedL, delayedR];
        sig = XFade2.ar(reverbed!2, stereoDelay, (delayMix * 2 - 1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Amp meter
        amp = Amplitude.kr(widened).clip(0, 1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- Цвета и интерфейс ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Plugin PRO Deluxe", Rect(100, 100, 460, 540))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 150, 20))
            .string_(label)
            .stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20))
            .value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        drive: ~makeSlider.("Drive", 20, 1.0),
        reverb: ~makeSlider.("Reverb", 70, 0.5),       // изначально сильнее
        pitch: ~makeSlider.("Pitch", 120, 1.0),
        delayTime: ~makeSlider.("Delay Time", 170, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 220, 0.3),
        tone: ~makeSlider.("Tone", 270, 0.5),
        width: ~makeSlider.("Stereo Width", 320, 1.0)
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 370, 200, 20))
        .string_("Output Level")
        .stringColor_(Color.white);

    ~vuBG = CompositeView(~w, Rect(20, 395, 420, 25))
        .background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25))
        .background_(Color.green);

    // --- Play Button ---
    ~playButton = Button(~w, Rect(20, 430, 120, 35))
        .states_([
            ["▶ Play", Color.green, Color.black],
            ["■ Stop", Color.red, Color.black]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~routine = Routine({
                    loop {
                        ~synth = Synth(\guitarPluginPro, [
                            \drive, ~sliders[\drive].value,
                            \reverbMix, ~sliders[\reverb].value,
                            \pitch, ~sliders[\pitch].value,
                            \delayTime, ~sliders[\delayTime].value,
                            \delayMix, ~sliders[\delayMix].value,
                            \tone, ~sliders[\tone].value,
                            \width, ~sliders[\width].value,
                            \dur, 1.0
                        ]);
                        5.0.wait;
                    }
                }).play(AppClock);
            }, {
                ~routine.stop;
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 430, 120, 35))
        .states_([
            ["● Record", Color.red, Color.black],
            ["■ Stop Rec", Color.gray(0.4), Color.white]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');
});
)





































(
s.quit;
s.waitForBoot({

    // --- SynthDef Deluxe ---
    SynthDef(\guitarPluginDeluxe, {
        |out=0, drive=1.0, reverbMix=0.3, pitch=1.0, delayTime=0.3, delayMix=0.3, dur=1.0|
        var sig, env, driven, reverbed, delayedL, delayedR, stereoDelay, pitched, finalSig, amp;

        sig = Saw.ar(440);
        pitched = PitchShift.ar(sig, pitchRatio: pitch, windowSize: 0.1, pitchDispersion: 0.0);
        env = EnvGen.kr(Env.perc(0.01, dur, 1.0), doneAction:2);
        sig = pitched * env;

        driven = tanh(sig * (drive*3));
        reverbed = FreeVerb.ar(driven, mix: reverbMix, room:0.9, damp:0.5);

        delayedL = CombC.ar(reverbed, 2.0, delayTime, 3);
        delayedR = CombC.ar(reverbed, 2.0, delayTime*1.2, 3);
        stereoDelay = [delayedL, delayedR];

        finalSig = XFade2.ar(reverbed!2, stereoDelay, (delayMix*2-1));

        amp = Amplitude.kr(finalSig).clip(0,1);
        SendReply.kr(Impulse.kr(20), '/amp', amp);

        Out.ar(out, finalSig);
    }).add;

    s.sync;

    // --- GUI ---
    ~accent = Color.red;
    ~bg = Color.gray(0.12);
    ~window = Window("🎸 Guitar Plugin Deluxe", Rect(100,100,460,460)).background_(~bg).front;

    // Sliders
    ~makeSlider = { |label, y, default|
        StaticText(~window, Rect(20, y, 100, 20)).string_(label).stringColor_(Color.white);
        Slider(~window, Rect(20, y+20, 420, 20)).value_(default).background_(~accent);
    };

    ~sliders = (
        drive: ~makeSlider.("Drive", 20, 1.0),
        reverb: ~makeSlider.("Reverb", 70, 0.3),
        pitch: ~makeSlider.("Pitch", 120, 1.0),
        delayTime: ~makeSlider.("Delay Time", 170, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 220, 0.3)
    );

    // VU Meter
    StaticText(~window, Rect(20, 270, 200, 20)).string_("Output Level").stringColor_(Color.white);
    ~vuBG = CompositeView(~window, Rect(20,295,420,25)).background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0,0,0,25)).background_(Color.green);

    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0,0,width,25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');

    // Play Button
    ~playButton = Button(~window, Rect(20, 340, 120, 35))
        .states_([["▶ Play", Color.green, Color.black], ["■ Stop", Color.red, Color.black]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~routine = Routine({
                    loop {
                        Synth(\guitarPluginDeluxe, [
                            \drive, ~sliders[\drive].value,
                            \reverbMix, ~sliders[\reverb].value,
                            \pitch, ~sliders[\pitch].value,
                            \delayTime, ~sliders[\delayTime].value,
                            \delayMix, ~sliders[\delayMix].value,
                            \dur, 1.0
                        ]);
                        1.0.wait;
                    }
                }).play(AppClock);
            }, {
                ~routine.stop;
            });
        });

    // Record Button
    ~recordButton = Button(~window, Rect(160, 340, 120, 35))
        .states_([["● Record", Color.red, Color.black], ["■ Stop Rec", Color.gray(0.4), Color.white]])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

});
)


(
// 🎸 Guitar Plugin PRO (fixed vars)

s.reboot;
s.waitForBoot({

    // --- SynthDef ---
    SynthDef(\guitarPluginPro, {
        |out=0, drive=1.0, reverbMix=0.3, pitch=1.0, delayTime=0.3, delayMix=0.3, tone=0.5, width=1.0, dur=1.0|
        var sig, env, driven, reverbed, delayedL, delayedR, stereoDelay, pitched, toned, widened, amp;

        sig = Saw.ar(440);
        pitched = PitchShift.ar(sig, pitchRatio: pitch, windowSize: 0.1, pitchDispersion: 0.0);
        env = EnvGen.kr(Env.perc(0.01, dur, 1.0), doneAction:2);
        sig = pitched * env;

        // Drive
        driven = tanh(sig * (drive * 3));

        // Tone (теплый–яркий)
        toned = LPF.ar(driven, tone.linexp(0,1,400,12000));

        // Reverb
        reverbed = FreeVerb.ar(toned, mix: reverbMix, room: 0.9, damp: 0.5);

        // Delay
        delayedL = CombC.ar(reverbed, 2.0, delayTime, 3);
        delayedR = CombC.ar(reverbed, 2.0, delayTime * 1.2, 3);
        stereoDelay = [delayedL, delayedR];
        sig = XFade2.ar(reverbed!2, stereoDelay, (delayMix * 2 - 1));

        // Stereo width
        widened = Balance2.ar(sig[0], sig[1], width.linlin(0,1,-1,1));

        // Amp meter
        amp = Amplitude.kr(widened).clip(0, 1);
        SendReply.kr(Impulse.kr(30), '/amp', amp);

        Out.ar(out, widened);
    }).add;

    s.sync;
    OSCdef.freeAll;

    // --- Цвета и интерфейс ---
    ~accent = Color.red;
    ~bg = Color.gray(0.1);

    ~w = Window("🎸 Guitar Plugin PRO", Rect(100, 100, 460, 540))
        .background_(~bg)
        .front;

    // --- Функция создания слайдеров ---
    ~makeSlider = { |label, y, default|
        StaticText(~w, Rect(20, y, 100, 20))
            .string_(label)
            .stringColor_(Color.white);
        Slider(~w, Rect(20, y+20, 420, 20))
            .value_(default)
            .background_(~accent.blend(Color.black, 0.7));
    };

    ~sliders = (
        drive: ~makeSlider.("Drive", 20, 1.0),
        reverb: ~makeSlider.("Reverb", 70, 0.3),
        pitch: ~makeSlider.("Pitch", 120, 1.0),
        delayTime: ~makeSlider.("Delay Time", 170, 0.3),
        delayMix: ~makeSlider.("Delay Mix", 220, 0.3),
        tone: ~makeSlider.("Tone", 270, 0.5),
        width: ~makeSlider.("Stereo Width", 320, 1.0)
    );

    // --- VU Meter ---
    StaticText(~w, Rect(20, 370, 200, 20))
        .string_("Output Level")
        .stringColor_(Color.white);

    ~vuBG = CompositeView(~w, Rect(20, 395, 420, 25))
        .background_(Color.black);
    ~vuBar = UserView(~vuBG, Rect(0, 0, 0, 25))
        .background_(Color.green);

    // --- Play Button ---
    ~playButton = Button(~w, Rect(20, 430, 120, 35))
        .states_([
            ["▶ Play", Color.green, Color.black],
            ["■ Stop", Color.red, Color.black]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                ~routine = Routine({
                    loop {
                        ~synth = Synth(\guitarPluginPro, [
                            \drive, ~sliders[\drive].value,
                            \reverbMix, ~sliders[\reverb].value,
                            \pitch, ~sliders[\pitch].value,
                            \delayTime, ~sliders[\delayTime].value,
                            \delayMix, ~sliders[\delayMix].value,
                            \tone, ~sliders[\tone].value,
                            \width, ~sliders[\width].value,
                            \dur, 1.0
                        ]);
                        1.0.wait;
                    }
                }).play(AppClock);
            }, {
                ~routine.stop;
            });
        });

    // --- Record Button ---
    ~recordButton = Button(~w, Rect(160, 430, 120, 35))
        .states_([
            ["● Record", Color.red, Color.black],
            ["■ Stop Rec", Color.gray(0.4), Color.white]
        ])
        .font_(Font("Helvetica", 14))
        .action_({ |btn|
            if(btn.value == 0, {
                s.record(path: Platform.userHomeDir ++ "/Desktop/guitar_output.wav");
                "🎙 Recording started...".postln;
            }, {
                s.stopRecording;
                "💾 Recording saved on Desktop.".postln;
            });
        });

    // --- VU Meter обновление ---
    OSCdef(\ampMeter, { |msg|
        var amp = msg[3].clip(0,1);
        {
            var width = amp.linlin(0,1,0,420);
            var color = Color.green.blend(Color.red, amp.pow(1.3));
            ~vuBar.bounds = Rect(0, 0, width, 25);
            ~vuBar.background = color;
        }.defer;
    }, '/amp');
});
)
