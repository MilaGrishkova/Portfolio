SuperCollider I
Sitzung 07
// --------------------------------
// SuperCollider – Einführung in SynthDef
// --------------------------------

// Symbol
\sine
'sine'

// ---------------------------
// 1. Struktur eines SynthDef
// ---------------------------
// SynthDef ist eine Vorlage für einen Synthesizer.
// Allgemeiner Aufbau:
//
 SynthDef(\NameDesSynths, {|arg1=Default, arg2=Default, ...|
           var sig, env;                          // Lokale Variablen
           env = EnvGen.ar(...);                  // Hüllkurve erzeugen
           sig = SinOsc.ar(freq) * env;           // Oszillator + Hüllkurve
           Out.ar(out, Pan2.ar(sig, pan) * amp);  // Ausgabe (Stereo)
 }).add;

//
// Argumente können beim Start geändert werden:
// freq = Frequenz des Oszillators
// amp = Lautstärke
// attackTime, releaseTime = Hüllkurvenparameter
// pan = Stereo-Panorama (-1=links, 1=rechts)

// ---------------------------
// Beispiel 1
// ---------------------------

(
SynthDef(\sinus, {|out=0, freq=240, attackTime=0.001, releaseTime=1, amp=0.1, pan=0|
	var env = EnvGen.ar(Env.perc(attackTime, releaseTime), doneAction:2);
	var sig = SinOsc.ar(freq) * env;
	Out.ar(out, Pan2.ar(sig, pan) * amp);
}).add;
)

// Synth
Synth(\sinus, [\amp, 0.1, \pan, 1]); // Standard Synth
Synth(\sinus, [\freq, 68.midicps, \ffreq, 1000, \releaseTime, 5]); // MIDI-Note 68 - Frequenz, Release 5s
Synth(\sinus, [\freq, 600, \attackTime, 1, \releaseTime, 0.01]); // Langer Attack, kurzer Release
Synth(\sinus, [\freq, 340, \attackTime, 1, \releaseTime, 0.01]); // Andere Frequenz


// ---------------------------
// Beispiel 2
// ---------------------------
// Dieser Synth erzeugt einen Sinus-Oszillator mit Amplituden-Hüllkurve.
// Die Frequenz kann leicht mit der Maus nach oben oder unten moduliert werden (MouseY).
// Die Stereo-Panorama-Position wird mit MouseX gesteuert.
// Attack- und Release-Zeiten der Hüllkurve sind einstellbar.
// --------------------------------
(
SynthDef(\sinusInteractive, {|out=0, freq=440, attackTime=0.01, releaseTime=5, amp=0.1|

    var env = EnvGen.ar(Env.perc(attackTime, releaseTime), doneAction:2); // Amplituden-Hüllkurve (Attack und Release)
    var sig = SinOsc.ar(freq + MouseY.kr(-100, 100)) * env; // Sinus-Osz mit leichter Frequenzmodulation durch Maus Y

    Out.ar(out, Pan2.ar(sig, MouseX.kr(-1, 1)) * amp); // Ausgabe: Stereo, Pan über Maus X
}).add;
)

x = Synth(\sinusInteractive); // Synth starten
Synth(\sinusInteractive, [\amp, 0.1, \pan, 1]); // Standard Synth
Synth(\sinusInteractive, [\freq, 68.midicps, \ffreq, 1000, \releaseTime, 5]); // MIDI-Note 68 - Frequenz, Release 5s
Synth(\sinusInteractive, [\freq, 600, \attackTime, 1, \releaseTime, 0.01]); // Langer Attack, kurzer Release
Synth(\sinusInteractive, [\freq, 340, \attackTime, 1, \releaseTime, 0.01]); // Andere Frequenz
// ---------------------------
// 1. EnvGen.ar + Env.perc Erzeugt eine Attack-Release Hüllkurve, die den Klang formt.
// 2. MouseY.kr(-100, 100) Verschiebt die Frequenz dynamisch, erzeugt leichte Modulation.
// 3. Pan2.ar(sig, MouseX.kr(-1, 1)) Steuert Stereo-Panorama interaktiv mit Maus X.
// 4. amp Gesamtlautstärke des Signals.
// 5. doneAction:2 Synth stoppt automatisch, wenn Hüllkurve endet.
// ---------------------------

// ---------------------------
// Beispiel 3
// ---------------------------
(
SynthDef(\fmTexture, { |out=0, freq=180, modRatio=1.8, index=5,
    attack=2, sustain=4, release=6, amp=0.1, pan=0|

    var ampEnv;     // Amplituden-Hüllkurve
    var indexEnv;   // Hüllkurve für FM-Index
    var mod;        // Modulator-Signal
    var sig;        // Träger-Signal
    var filtered;   // Gefiltertes Signal

    // ---------------------------
    // Amplitudenhüllkurve (weich, langsam)
    // ---------------------------
    ampEnv = EnvGen.ar(
        Env.linen(attack, sustain, release),
        doneAction: 2
    );

    // ---------------------------
    // FM-Index-Hüllkurve
    // Bestimmt, wie stark die FM im Zeitverlauf ist
    // ---------------------------
    indexEnv = EnvGen.ar(
        Env([0.2, index, 1], [attack, release])
    );

    // ---------------------------
    // Modulator
    // Frequenz = Grundfrequenz * modRatio
    // ---------------------------
    mod = SinOsc.ar(freq * modRatio) * freq * indexEnv;

    // ---------------------------
    // Träger mit Frequenzmodulation
    // ---------------------------
    sig = SinOsc.ar(freq + mod);

    // ---------------------------
    // Langsam bewegter Tiefpassfilter
    // ---------------------------
    filtered = LPF.ar(
        sig,
        SinOsc.kr(0.08).range(400, 3500)
    );

    // ---------------------------
    // Stereo-Ausgabe mit Panorama
    // ---------------------------
    Out.ar(out, Pan2.ar(filtered * ampEnv * amp, pan));

}).add;
)


(Synth(\fmTexture, [
    \freq, 120,        // Grundfrequenz (Tonhöhe)
    \modRatio, 3,      // Verhältnis Modulator zu Carrier
    \index, 6,         // Modulationstiefe (Klangkomplexität)
    \attack, 3,        // Einschwingzeit
    \sustain, 1,       // Haltezeit
    \release, 1,       // Ausschwingzeit
    \amp, 0.1,        // Lautstärke
    \pan, 0            // Mitte
]);
)


s.scope;        // Zeitdarstellung
s.freqscope;   // Frequenzspektrum
)
// =======================================================
// BEISPIELE
// =======================================================

// Ruhige FM-Fläche
Synth(\fmTexture, [\freq, 140]);

// Heller, bewegter Klang
Synth(\fmTexture, [\freq, 260, \modRatio, 2.5, \index, 7]);

// Langsame Ambient-Textur
(Synth(\fmTexture, [
    \freq, 110,
    \attack, 4,
    \sustain, 6,
    \release, 10,
    \index, 9,
    \pan, -0.4
]);)


// --------------------------------
// Dieser Synth erzeugt einen dichten Bass-Klang mit Sägezahn-Oszillatoren,
// Hüllkurve und Filter-Modulation.
// --------------------------------

(
SynthDef(\synthBass, {|freq=440, attackTime=0.001, releaseTime=1, start_ffreq=800, end_ffreq=200, amp=0.1, pan=0|
    // ---------------------------
    // 1. Hüllkurve für Amplitude
    // ---------------------------
    var env = EnvGen.ar(Env.perc(attackTime, releaseTime), doneAction:2);

    // ---------------------------
    // 2. Hüllkurve für Filterfrequenz (XLine)
    // ---------------------------
    var fenv = XLine.ar(start_ffreq, end_ffreq, releaseTime / 2);

    // ---------------------------
    // 3. Oszillatoren (Sägezahn) + leichte Detune
    // ---------------------------
    var sig = Mix.ar(Saw.ar(freq * [1, 1.01, 0.997])) * 0.33333 * env;

    // ---------------------------
    // 4. Filter anwenden (resonanter Low-Pass)
    // ---------------------------
    sig = RLPF.ar(sig, fenv, 0.9);

    // ---------------------------
    // 5. Stereo-Ausgabe mit Pan und Lautstärke
    // ---------------------------
    Out.ar(0, Pan2.ar(sig, pan) * amp);
}).add;
)

// Einfacher Bass mit Standardwerten
Synth(\synthBass, [\freq, 100]);

// Längere Release-Zeit für sanften Ausklang
Synth(\synthBass, [\freq, 100, \releaseTime, 3]);

// Zufällige Frequenz, Lautstärke und Filterfrequenzen für Variation
(Synth(\synthBass, [
    \freq, rrand(100, 400),
    \amp, 0.2,
    \releaseTime, 4,
    \start_ffreq, rrand(200, 10000),
    \end_ffreq, rrand(200, 10000)
]);)



// --------------------------------
(
SynthDef(\kick, {|freq=60, pan=0, amp=0.1| 
var sig = SinOsc.ar(XLine.ar(5, 1, 0.02) * freq); 
sig = sig * EnvGen.ar(Env.perc(0.001, 0.4)); 
Out.ar(0, Pan2.ar(sig, pan) * amp); 
}).add;


SynthDef(\kick2, {|freq=50, amp=0.5, pan=0|
	var pitchEnv, ampEnv, body, click, sig;
	pitchEnv = EnvGen.ar(Env([2, 1], [0.03], curve: -8));
	ampEnv = EnvGen.ar(Env.perc(0.001, 0.5), doneAction: 2);
	body = SinOsc.ar(freq * pitchEnv);
	click = HPF.ar(WhiteNoise.ar, 8000) * EnvGen.ar(Env.perc(0.001, 0.02));
	sig = (body + click) * ampEnv;
	Out.ar(0, Pan2.ar(sig, pan) * amp);
}).add;

SynthDef(\snare, {|amp=0.3, pan=0|
	var noise, tone, env;
	noise = WhiteNoise.ar * 0.6;
	tone = SinOsc.ar(200);
	env = EnvGen.ar(Env.perc(0.005, 0.25), doneAction:2);
	Out.ar(0, Pan2.ar((noise + tone) * env, pan) * amp);
}).add;

SynthDef(\hihat, {|amp=0.2, pan=0|
	var sig, env;
	sig = HPF.ar(WhiteNoise.ar, 6000);
	env = EnvGen.ar(Env.perc(0.001, 0.1), doneAction:2);
	Out.ar(0, Pan2.ar(sig * env, pan) * amp);
}).add;

SynthDef(\pad, {|freq=200, amp=0.3, pan=0|
	var sig, env;
	sig = Saw.ar(freq * [1, 1.01]);
	env = EnvGen.ar(Env.linen(2, 4, 2), doneAction:2);
	sig = LPF.ar(sig, 1000);
	Out.ar(0, Pan2.ar(sig * env, pan) * amp);
}).add;

SynthDef(\pluck, {|freq=400, amp=0.25, pan=0|
	var sig, env;
	sig = Pluck.ar(
		WhiteNoise.ar * 0.5,
		Impulse.ar(0),
		0.1, 1/freq, 4
	);
	env = EnvGen.ar(Env.perc(0.01, 2), doneAction:2);
	Out.ar(0, Pan2.ar(sig * env, pan) * amp);
}).add;
)

(
Pbind( \instrument, \kick,
	    \freq, 60,
	     \amp, 0.5,
	     \dur, 1,
).play;

Pbind(
	\instrument, \kick2,
	\freq, 48,
	\dur, 1,
	\amp, 0.7
).play;

Pbind(
	\instrument, \snare,
	\dur, 1,
	\amp, Pseq([0, 0.4, 0, 0.4], inf)
).play;

Pbind(
	\instrument, \hihat,
	\dur, 0.25,
	\amp, 0.15,
	\pan, Pwhite(-0.3, 0.3)
).play;

Pbind(
	\instrument, \pad,
	\freq, Pseq([200, 250, 300, 180], inf),
	\dur, 4,
	\amp, 0.3,
	\pan, Pwhite(-0.5, 0.5)
).play;

Pbind(
	\instrument, \pluck,
	\freq, Pwhite(300, 1200),
	\dur, Pwhite(0.1, 0.5),
	\amp, 0.25,
	\pan, Pwhite(-1, 1)
).play;
)

Synth(\kick2, [\freq, 48, \amp, 0.8]);
Synth(\kick, [\amp, 0.5, \freq, 50])

TempoClock.default.tempo = 120 / 60;
