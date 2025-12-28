s.record;
(s.scope.(~startRandomLetters);
s.meter;)
~startRandomLetters.();
(s.options.numOutputBusChannels = 16;
s.options.numWireBufs = 2048;
s.reboot;
s.waitForBoot({

    // Load buffer
    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Miss You.wav", channels:[0]);
    // HOA Encoder / Decoder
    ~enc = HoaMatrixEncoder.newDirection(0, 0, \basic, 3);
    ~dec = HoaMatrixDecoder.newModeMatch(
        directions: [
            [36, 54], [108, 54], [180, 54], [-108, 54],
            [-36, 54], [36, 18], [108, 18], [180, 18],
            [-108, 18], [-36, 18], [0, -18], [72, -18],
            [144, -18], [-144, -18], [-72, -18], [0, -54]
        ].degrad,
        beamShape: \energy,
        match: \rms
    );

    // HOA movement function
    ~hoaMove = { |sig|
        sig = HoaEncodeMatrix.ar(sig, ~enc);
        sig = HoaRTT.ar(sig,
            rotate: SinOsc.kr(0.05, 0).range(-pi, pi),
            tilt: SinOsc.kr(0.03, 0).range(-pi/4, pi/4),
            tumble: SinOsc.kr(0.02, 0).range(-pi/6, pi/6)
        );
	HoaDecodeMatrix.ar(sig, ~dec)
    };

    // HOA SynthDef with random start position
    SynthDef(\SampleHOA, { |out=0, bufnum, pitch=1, dur=1|
        var sig, env, numFrames, sr, startPos;
        numFrames = BufFrames.kr(bufnum);
        sr = BufSampleRate.kr(bufnum);

        // Random start position for short snippet
        startPos = rrand(0, (numFrames - (dur * sr)).max(0));

        env = EnvGen.kr(Env.perc(0.01, dur, 1, -4), doneAction:2);

       sig = PlayBuf.ar(
			numChannels: 2,
			bufnum: bufnum,
			rate: pitch * BufRateScale.kr(bufnum),
			startPos: startPos,
			doneAction:2).sum * 0.5 * env; // sum stereo -> mono
        sig = ~hoaMove.(sig);
        Out.ar(out, sig);
    }).add;
    s.sync;
// SynthDef for "love" that plays full buffer without fading
SynthDef(\LoveHOA, { |out=0, bufnum, pitch=1|
    var sig;
    // Play full buffer with pitch scaling and HOA processing
    sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: bufnum,
        rate: pitch * BufRateScale.kr(bufnum),
        loop: 0,          // play once
        doneAction: 2
    ).sum * 0.5;          // sum stereo to mono for HOA
    sig = ~hoaMove.(sig);
    Out.ar(out, sig);
}).add;
s.sync;
});
)

(
~alphabet = ["l","o","v","e"];
~randLetter = { ~alphabet.choose };
~running = false;

~startRandomLetters = {
    if(~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 1.5; // 40 BPM
        var word;

        while({ ~running }) {
            word = Array.fill(4, { ~randLetter.value }).join;

            if(word == "love") {
                ("💖 Could this finally be love?: %".format(word)).postln;
                "--> YES!!!".postln;
                ~running = false;
                Synth(\LoveHOA, [\bufnum, ~buf.bufnum, \pitch, 1]);
            } {
                ("Could this finally be love?: % (No)".format(word)).postln;
                word.do { |l|
                    Synth(\SampleHOA, [
                        \bufnum, ~buf.bufnum,
                        \pitch, rrand(0.9, 1.1),
                        \dur, 1
                    ]);
                };
            };
            interval.wait;
        };
    });
	("🎲 What is the probability?").postln;
};

~stopRandomLetters = {
    ~running = false;
    if(~task.notNil) { ~task.stop; ~task = nil };
   "🛑 Stopped.".postln;
};
)
