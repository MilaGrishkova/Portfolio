SuperCollider I
Sitzung 01

// --------------------------------
// Server booten
// --------------------------------
s.boot
// Cmd + B / Strg + B oder

// --------------------------------

//  SinOsc
(
{
    SinOsc.ar(440, 0, 0.2)
}.play;
)

// --------------------------------
// Envelope
(
{
    var env = EnvGen.kr(
        Env.perc(0.01, 1),
        doneAction: 2
    );
    SinOsc.ar(440) * env * 0.3
}.play;
)

// --------------------------------
// Filter, Low-pass filter
(
{
    var sig = Saw.ar(100, 0.3);
    RLPF.ar(sig, 800, 0.2)
}.play;
)

// --------------------------------
// FM-синтез
(
{
    var mod = SinOsc.ar(200, 0, 300);
    SinOsc.ar(440 + mod) * 0.2
}.play;
)

// --------------------------------
// MouseX, MouseY
(
{
    var freq = MouseX.kr(200, 1000, 1);
    var amp  = MouseY.kr(0.01, 0.3);
    SinOsc.ar(freq) * amp
}.play;
)

// --------------------------------
// Noise
(
{
    var noise = PinkNoise.ar(0.3);
    BPF.ar(noise, 1000, 0.3)
}.play;
)

// --------------------------------
// Delay, Reverb
(
{
    var sig = Pulse.ar(150, 0.4, 0.2);
    sig = CombN.ar(sig, 0.5, 0.3, 4);
    FreeVerb.ar(sig, 0.4, 0.7, 0.5)
}.play;
)

// --------------------------------
// SynthDef
(
SynthDef(\simpleSynth, {
    |freq = 440, amp = 0.2|
    var env = EnvGen.kr(Env.perc(0.01, 0.5), doneAction: 2);
    var sig = Saw.ar(freq) * env * amp;
    Out.ar(0, sig ! 2);
}).add;
)

Synth(\simpleSynth, [\freq, 660]);

// --------------------------------
// Pattern
(
Pbind(
    \instrument, \simpleSynth,
    \degree, Pseq([0, 2, 4, 7, 9], inf),
    \scale, Scale.minor,
    \dur, 0.25,
    \amp, 0.2
).play;
)

// --------------------------------
// Zufall
(
{
    var freq = LFNoise1.kr(2).exprange(200, 2000);
    SinOsc.ar(freq) * 0.15
}.play;
)
