SuperCollider I
Sitzung 08
// --------------------------------
// Buffer
// --------------------------------

b = Buffer.read(s,/*zieh hier .wav*/)

b.numFrames
b.sampleRate
b.numChannels

b.play

(
a= {
    var sig = PlayBuf.ar(b.numChannels, b, BufRateScale.ir(b), loop: 1);
    Out.ar(0, sig * 0.5);
}.play;
)

p = ProxySpace.push(s.boot);

~a = { PlayBuf.ar(1, b, BufRateScale.ir(b), loop: 1).dup }
~a.play

// 32 Bit = 4 Byte pro Sample
4 * b.numFrames * b.numChannels

// --------------------------------
// Geschwindigkeit (lokal)
// --------------------------------
(
x = {
    var speed = MouseX.kr(0.5, 2); // Geschwindigkeit zwischen 0.5x und 2x
    PlayBuf.ar(1, b, BufRateScale.ir(b) * speed, loop: 1)
}.play;
)

// --------------------------------
// Geschwindigkeit (global)
// --------------------------------
~tempo= { PlayBuf.ar(1, b, BufRateScale.ir(b) * MouseX.kr(-2, 2), loop: 1).dup }
~tempo.play

// --------------------------------
// Array (global)
// --------------------------------
~array = { PlayBuf.ar(1, b, BufRateScale.ir(b) * Array.series(6, 1, 0.001), loop: 1).dup }
~array.play

b = Buffer.read(s,".wav")
c = Buffer.read(s,".wav")
d = Buffer.read(s,".wav")
e = Buffer.read(s,".wav")

p = ProxySpace.push(s.boot)

(
~sound = {
	var dur = BufDur.ir(c);
	var startPos = (LFNoise0.ar(32 / dur).range(0, 64).floor / 64) * BufFrames.ir(b);
	PlayBuf.ar(1, b, 1.0, Impulse.ar(32 / dur), startPos, loop: 1).dup
}
);
~sound.play

// --------------------------------
// Rundungs-Operationen
// --------------------------------
0.5.round;
0.2.floor;
0.00.ceil;

// --------------------------------
// Bitcrusher
// --------------------------------
~bitcrusher = {(PlayBuf.ar(1, b, loop:1).dup * 8).ceil / 8}
~bitcrusher.play

// --------------------------------
// Simpler PlayBuf
// --------------------------------
(
SynthDef(\simpleBuffer, { |out=0, amp=0.2, pan=0, bufnum=0, rate=1|
    var sig = PlayBuf.ar(1, bufnum, rate, doneAction: 2) * amp;
    Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

// 2. Synth play
Synth(\simpleBuffer, [\bufnum, c, \amp, 0.5, \pan, -0.5]); // links
Synth(\simpleBuffer, [\bufnum, c, \amp, 0.5, \pan, 0.5]);  // rechts

(
~playSimple = {
    var rates = [0.5, 1, 1.5]; // 3 geschw.
    rates.do { |r|
        Synth(\simpleBuffer, [\bufnum, c, \amp, 0.4, \rate, r]);
    };
};)
(~playSimple.();
)

// --------------------------------
// Read Buffer mit Grain
// --------------------------------
(
~grainTest = {
    GrainBuf.ar(
        2,                           // channel
        Dust.ar(50),                 // Grain
        MouseX.kr(0.01, 0.2),        // tempo
        f,                           // Buffer
        MouseY.kr(0.5, 1.5),         // länge Grain
        WhiteNoise.ar().range(0, 1)  // pan
    )
};)
~grainTest.play;

// --------------------------------
// Read Buffer mit Saw
// --------------------------------

~bufRead = {
    BufRd.ar(
        1,                                      // mono
        c,                                      // Buffer
        LFSaw.ar(MouseX.kr(0.1, 5)).range(0, BufFrames.ir(c))
    ).dup
};
)
~bufRead.play;

// --------------------------------
// bitcrush
// --------------------------------
~bitcrush = {
    var sig = PlayBuf.ar(1, d, loop:1).dup;
    Latch.ar((sig * 8).ceil / 8, Impulse.ar(100))
};
~bitcrush.play;


// Grainbuf samplet aus dem kontinuierlich aufgenommenen Buffer
~player = {GrainBuf.ar(2, Dust.ar(100), MouseX.kr(0.01, 0.3), f, MouseY.kr(0.5, 2),WhiteNoise.ar().range(0,1))};
~player.play;

~sound = {BufRd.ar(1, c, LFSaw.ar(MouseX.kr(0.001, 10)).range(0, BufFrames.ir(b)).poll).dup};
~sound.play;
