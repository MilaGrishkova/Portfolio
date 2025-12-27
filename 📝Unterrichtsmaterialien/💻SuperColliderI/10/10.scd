SuperCollider I
Sitzung 09
// --------------------------------
// Zufall in sclang
// --------------------------------

10.rand;          // integers 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 (n.rand = int (von 0 bis n-1))
10.0.rand;        // floats von 0.0 bis < 10.0
10.0.rrand(0);    // rrand(min, max) 0.0 ≤ x ≤ 10.0
rrand(5.0, 10.0); // rrand(5.0, 10.0);
// --------------------------------

(
Task({
    5.do {
        Synth(\default, [
            \freq, rrand(200, 800),
            \amp, 0.1
        ]);
        0.3.wait;
    };
}).play;
)
// --------------------------------

(
Task({
    10.rand.do {                      // rand .do
        var freq;
        freq = 800.rand + 200;        // rand freaq
        freq.postln;                  // freaq post
        Synth(\default, [
            \freq, freq,
            \amp, 0.1
        ]);
        0.2.wait;
    };
}).play;
)
// --------------------------------

(
Task({
    10.do {
        var freq = exprand(300, 1200);
        ("Playing freq: " ++ freq).postln;
        Synth(\default, [\freq, freq, \amp, 0.15]);
        0.3.wait;
    };
}).play;
)
// --------------------------------

(
Task({
    12.do {
        var freq = [261.63, 329.63, 392.00].choose;
        freq.postln;

        Synth(\default, [\freq, freq, \amp, 0.2]);
        0.4.wait;
    };
}).play;
)
// --------------------------------

[1, 2, 3].choose
// --------------------------------

// scramble durchmischt Listen/Arrays
[1, 2, 3, 4, 5, 6].scramble
// --------------------------------

// Lottozahlen: 6 aus 49
(1..49).scramble[0..5]
// --------------------------------

10.linrand
1.0.linrand
// --------------------------------

(
20000.collect({ 100.rand }).histo.plot;
20000.collect({ 100.linrand }).histo.plot;
)
// --------------------------------

(
Task({
    30.do {
        Synth(\default, [
            \freq, 300 + 800.linrand,
            \amp, 0.05 + 0.15.linrand
        ]);
        0.15.wait;
    }
}).play;
)
// --------------------------------

// rand  alle Werte sind gleich wahrscheinlich
// linrand  kleine Werte treten häufiger auf
// exprand exponentielle Verteilung (exponentielle Verschiebung)
// rand2  Werte in beide Richtungen um 0 herum

// Unterschied ist in der Menge besser zu sehen.
20000.collect({100.0.rand}).plot
20000.collect({100.0.linrand}).plot

// Noch besser zu sehen mit Histogrammen!
200000.collect({100.0.rand}).histo.plot
200000.collect({100.0.linrand}).histo.plot

// bipolare Zufallswerte
10.0.rand2;
10.0.bilinrand;
700.collect({100.0.bilinrand}).histo.plot

700.collect({100.0.sum3rand}).histo.plot
700.collect({100.0.gauss(20)}).histo.plot

// Random Walk Beispiel
(
var x = 0;
r = { x = x + 0.05.rand2; x };
1000.collect(r).plot;
)

// ----------------------------
sThread = thisThread;
sThread.randSeed = 1234;

("Gleichmäßige Zufallszahlen: " ++ 6.rand).postln;
("Gleichmäßige Zufallszahlen Float: " ++ 6.0.rand).postln;

// ----------------------------
// SynthDef mit exprand
// ----------------------------
(
SynthDef(\randSound, {
    var sig;
    sig = SinOsc.ar(ExpRand(110, 440));
    sig = sig * EnvGen.ar(Env.perc(0.001, 1), doneAction:2);
    Out.ar(0, sig.dup * 0.1);
}).add;
)

Synth(\randSound);
// ----------------------------
(
var notes = [60, 62, 64, 65, 67, 69, 71]; // C D E F G A B
var melody = notes.scramble;
"Pseudorandom melody: ".post; melody.postln;
)
// ----------------------------

(
(1.0.rand > 0.5).if({
    Synth(\default, [\freq, 220, \amp, 0.2]);
}, {
    Synth(\default, [\freq, 880, \amp, 0.2]);
});
)
чв

(
var zufall = 1.0.rand;
zufall.postln;

if(zufall < 0.3, {
    "Kick".postln;
}, {
    if(zufall < 0.7, {
        "Snare".postln;
    }, {
        "HiHat".postln;
    });
});
)
// ----------------------------

(
0.5.coin.if({
    Synth(\default, [\freq, 220, \amp, 0.2]);
}, {
    Synth(\default, [\freq, 880, \amp, 0.15]);
});
)

// Zufall kann auch in bedingten Schleifen angewandt werden
(
SynthDef(\randomTone, {|freq=440, amp=0.2, dur=0.2|
    var env = EnvGen.kr(Env.perc(0.01, dur), doneAction:2);
    var sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig.dup);
}).add;
)

(
fork {
    { 1.0.rand > 0.05 }.while({
        Synth(\randomTone, [\freq, 220 + 660.rand, \amp, 0.15 + 0.1.rand]);
        0.2.wait;
    });
}
)
// ----------------------------

// Random Walks
(
var x = 1.0;
r = {
	x = x + 0.05.rand2;
	x;
}
)
// ----------------------------

(
SynthDef(\melodyTone, {|freq=440, amp=0.2, dur=0.25|
    var env = EnvGen.kr(Env.perc(0.01, dur), doneAction:2);
    var sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig.dup);
}).add;
)

(
var notes = [261.63, 293.66, 329.63, 349.23, 392.00]; // C D E F G
Pbind(
    \instrument, \melodyTone,
    \freq, Pseq(Array.fill(16, { notes.choose }), 1),
    \dur, 0.25,
    \amp, 0.2
).play;
)

// ----------------------------
(
SynthDef(\walkTone, {|freq=440, amp=0.15, dur=0.2|
    var env = EnvGen.kr(Env.perc(0.01, dur), doneAction:2);
    var sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig.dup);
}).add;
)

(
var x = 440;  
fork {
    50.do {
        x = x + (20.rand2);  
        Synth(\walkTone, [\freq, x, \amp, 0.15]);
        0.2.wait;
    };
}
)

