SuperCollider I
Sitzung 06
// --------------------------------
// AM, FM, RM
// --------------------------------

p = ProxySpace.push(s.boot)

s.scope;
s.freqscope;

// --------------------------------
// Amplituden-Modulation
// --------------------------------
// erst Tremolo, dann AM
~sound = {SinOsc.ar(400).dup * 0.1 * SinOsc.ar(XLine.ar(1, 400, 60)).range(-1, 1)}
~sound.play

(
~sound2 = {
    var carrier = SinOsc.ar(300);   // Grundton 300 Hz
    var mod = SinOsc.ar(XLine.ar(0.5, 300, 30)).range(0.2, 1);
    carrier * 0.2 * mod           // Tremolo AM
}
)
~sound2.play;

// --------------------------------
// AM auf additiv aufgebautes Signal
// --------------------------------
(
~snd = {
    var grund = 220;
    var signal = SinOsc.ar([grund, grund*2, grund*3], 0, [0.3, 0.2, 0.1]);
    signal * SinOsc.ar(MouseY.kr(1, 20)).range(0.5, 1)
}
)
~snd.play;
)

// --------------------------------
// FM-Synthes
// --------------------------------
// Carrier-Frequenz ist Grundton des Klangs (~carFreq)
// Modulator-Frequenz moduliert die Frequenz des Carriers (~carFreq * ~modRatio)
// Modulationsindex bestimmt die Stärke der Modulation (~modIndex)
// Ganzzahlige Modulatorverhältnisse bringt harmonische Obertöne (.floor)
//Das Ergebnis ist ein komplexer Klang, oft metallisch oder klingelnd, abhängig von Ratio und Index

(
~carFreq = {200};                       // Carrier-Frequenz
~modRatio = { MouseX.kr(0, 8).floor };  // Modulator-Verhältnis interaktiv
~modIndex = { MouseY.kr(0, 6) };        // Modulationsindex interaktiv
~snd = {
    SinOsc.ar(
        ~carFreq + (SinOsc.ar(~carFreq * ~modRatio) * ~carFreq * ~modIndex)
    ).dup * 0.1
};                                      // FM-Signal
~snd.play;
~modRatio.play;                         // Optional: live Modulatorverhältnis anzeigen
)

// --------------------------------
~carFreq = {100};
~modRatio = {MouseX.kr(0, 10)};
~modRatio = {MouseX.kr(0, 10).floor};
~modIndex = {MouseY.kr(0, 8)};

~sound = { SinOsc.ar(~carFreq + (SinOsc.ar(~carFreq*~modRatio) * ~carFreq * ~modRatio * ~modIndex)).dup * 0.1 };
~sound.play;

~modRatio.play;

// --------------------------------
// Ringmodulation
// --------------------------------
// Ringmodulation ist eine Technik der Klangsynthese, bei der zwei Signale miteinander multipliziert werden
// --------------------------------
// Ringmodulation zwischen Sinus und sich beschleunigendem Modulator
// --------------------------------
~sound = {SinOsc.ar(440) * 0.1 * SinOsc.ar(MouseY.kr(50, 2000)).range(MouseX.kr(-1, 1),1)}

// --------------------------------
// Das gleiche, anderes geschrieben
// --------------------------------
(
~sound = {
    var carrier = SinOsc.ar(440);  // Träger-Frequenz
    var modulator = SinOsc.ar(MouseY.kr(50, 2000)).range(MouseX.kr(-1, 1),1);
    carrier * 0.1 * modulator       // Ringmodulation
};
~sound.play;
)

// --------------------------------
// Modulator als WhiteNoise unharmonische Ringmodulation
// --------------------------------
~sound = { SinOsc.ar(440) * 0.1 * WhiteNoise.ar() }.play;

// --------------------------------
// Träger und Modulator beide SinOsc mit leichten Frequenzunterschieden, Schwebung + Ringmod
// --------------------------------
~sound = { SinOsc.ar(440) * 0.1 * SinOsc.ar(442) }.play;

// --------------------------------
// Mehrkanal-Ringmodulation (Stereo)
// --------------------------------
~sound = { [SinOsc.ar(440), SinOsc.ar(330)] * [0.1, 0.2] * SinOsc.ar(MouseY.kr(50,1000)) }.play;
