SuperCollider I
Sitzung 09
// --------------------------------
// Pbind und Pseq in SuperCollider
// --------------------------------
// 1. Was ist Pbind
// Pbind ist ein Pattern, das Synthesizer-Parameter mit einer Sequenz von Werten verbindet.
// Jeder Parameter wird durch ein Symbol definiert (\instrument, \dur, \freq, \amp usw.)
// und der Wert kann eine Zahl, ein Pattern oder eine Funktion sein.

(
Pbind(
    \instrument, \default,  // Welchen Synth benutzen
    \dur, 0.25,             // Dauer jeder Note in Sekunden
    \freq, [440, 550, 660]  // Frequenzen für jede Note
).play;
)

// \instrument — Synthesizer
// \dur — Dauer der Note
// \freq — Frequenzen der Noten

// --------------------------------
// 2. Pseq wiederholende Sequenzen
// --------------------------------
// Pseq erzeugt eine wiederholende Sequenz von Werten.
// Beispiel mit Pbind
(
Pbind(
    \instrument, \default,
    \dur, 0.5,
    \midinote, Pseq([60, 62, 64], 3)  // 3-mal wiederholen
).play;
)

// Es werden 9 Noten gespielt: 60, 62, 64, 60, 62, 64, 60, 62, 64

// --------------------------------
// 3. Unendliche Sequenzen
// --------------------------------
// Wenn statt einer Zahl 'inf' verwendet wird, wiederholt sich die Sequenz unendlich

(
Pbind(
    \instrument, \default,
    \dur, 0.25,
    \freq, Pseq([440, 550, 660], inf)
).play;
)
// Die Sequenz läuft endlos, bis der Pattern gestoppt wird

// --------------------------------
// 4. Nutzung von Arrays und Funktionen
// --------------------------------
// Pbind und Pseq können mit Arrays und Funktionen kombiniert werden, um dynamische Effekte zu erzeugen

(
Pbind(
    \instrument, \default,
    \dur, 0.25,
    \freq, Pseq([440, 550, { rrand(600, 800) }.asStream], 5)
).play;
)
// { rrand(600, 800) }  zufällige Frequenz bei jeder Iteration
// .asStream erlaubt die Nutzung von Funktionen innerhalb von Pseq

// --------------------------------
// Melodie mit unterschiedlichen Dauern
// --------------------------------

(
Pbind(
    \instrument, \default,
    \dur, Pseq([0.1, 0.2, 0.4], inf),  // unterschiedliche Dauern
    \freq, Pseq([440, 493.88, 523.25, 587.33], inf),  // Noten C4, D4, E4, F4
    \amp, 0.3
).play;
)

// --------------------------------
(
// Sanfte Synth-Definition für Melodien
SynthDef(\melody, { |out=0, freq=440, amp=0.2, pan=0, len=1|
    var env = EnvGen.kr(Env.perc(0.01, len, 1, -4), doneAction:2);
    var sig = SinOsc.ar(freq, 0, amp) * env;
    sig = LPF.ar(sig, SinOsc.kr(0.1).range(800, 1500)); // sanfte Filterbewegung
    sig = sig * 0.8; // leicht dämpfen
    Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
// Lange, zarte Melodie mit Pbind + Pseq
Pbind(
    \instrument, \melody,
    \dur, Pseq([1.2, 0.8, 1.5, 1.0, 0.6, 1.3, 1.0, 1.4], inf), // längere Noten
    \freq, Pseq([
        261.63, // C4
        329.63, // E4
		293.66, // D4
		329.63, // E4
        349.23, // F4
        392.00, // G4
        440.00, // A4
        392.00, // G4
		261.63, // C4
        329.63, // E4
		293.66, // D4
		329.63, // E4
        349.23, // F4
        329.63, // E4
        293.66, // D4
        261.63, // C4
    ], inf),
    \amp, Pseq([0.15,0.18,0.2,0.16,0.18,0.2,0.17,0.19], inf),
    \pan, Pseq([-0.2,0.1,0,0.3,-0.1,0.2,0,0], inf),
    \len, Pseq([1.0,0.9,1.2,1.0,0.7,1.1,1.0,1.3], inf)
).play;
)

// --------------------------------
(
Pbind(
    \instrument, \melody,
    \dur, Pseq([0.15, 0.25, 0.35, 0.2, 0.3], inf),  // abwechslungsreiche Notenlängen
    \freq, Pseq([440, 493.88, 523.25, 587.33, 659.25, 698.46], inf), // C4, D4, E4, F4, G4, A4
    \amp, Pseq([0.2, 0.25, 0.3, 0.2, 0.28], inf), // dynamische Lautstärke
    \pan, Pseq([-0.7, -0.3, 0, 0.3, 0.7], inf),  // Stereo-Panning
    \len, Pseq([0.1, 0.15, 0.2, 0.25], inf)
).play;
)

// --------------------------------
(
Pbind(
    \instrument, \melody,
    \dur, Pseq([0.3, 0.2, 0.5, 0.3, 0.4, 0.2, 0.6, 0.3], inf), // Notendauer
    \freq, Pseq([261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25], inf), // C4 D4 E4 F4 G4 A4 B4 C5
    \amp, Pseq([0.3, 0.25, 0.35, 0.3, 0.28, 0.3, 0.32, 0.3], inf),
    \pan, Pseq([-0.5, 0, 0.5, -0.3, 0.3, 0, -0.5, 0.5], inf),
    \len, Pseq([0.2, 0.25, 0.3, 0.2, 0.25, 0.3, 0.35, 0.2], inf)
).play;
)

// --------------------------------
(
// poetische Melodie mit Pbind + Pseq
Pbind(
    \instrument, \melody,
    \dur, Pseq([0.4, 0.2, 0.3, 0.6, 0.5, 0.3, 0.7, 0.4, 0.3], inf),
    \freq, Pseq([
        261.63, // C4
        329.63, // E4
        293.66, // D4
        392.00, // G4
        349.23, // F4
        440.00, // A4
        392.00, // G4
        523.25, // C5
        466.16  // Bb4
    ], inf),
    \amp, Pseq([0.3,0.25,0.28,0.35,0.3,0.32,0.28,0.33,0.3], inf),
    \pan, Pseq([-0.3,0.2,0,0.5,-0.2,0.3,0,0.1,-0.1], inf),
    \len, Pseq([0.35,0.25,0.3,0.6,0.4,0.3,0.5,0.4,0.3], inf)
).play;
)
// --------------------------------
// ---------------------------
// Task & do in SuperCollider
// ---------------------------
// 1. 'do' Schleife
// Wiederholt einen Block eine bestimmte Anzahl von Malen
(
3.do { |i|
    ("Iteration: " ++ i).postln;  // Ausgabe im Postfenster
};
)

// ---------------------------
// 2. Task
// Ein Task ermöglicht zeitlich gesteuerte Abläufe
(
Task({
    5.do { |i|
        ("Task Iteration: " ++ i).postln;
        2.wait;  // Warte 2 Sekunden zwischen den Iterationen
    };
}).play;
)

// ---------------------------
// 3. Task mit Synthesizer
(
SynthDef(\simpleTone, {|freq=440, amp=0.2, dur=1|
    var env = EnvGen.ar(Env.perc(0.01, dur), doneAction: 2); // Perc-Envelope, doneAction 2 = Synth automatisch free
    var sig = SinOsc.ar(freq) * amp * env;
    Out.ar(0, sig.dup);
}).add;
)

// ---------------------------
// Task, das Töne nacheinander spielt
(
Task({
    [440, 550, 660].do { |i|
        Synth(\simpleTone, [\freq, i, \amp, 0.2]);
        2.wait;  // Wartezeit zwischen den Tönen
    };
}).play;
)

// ---------------------------
(
Task({
    5.do {  // fünf Wiederholungen der ganzen Sequenz
        [440, 550, 660].do { |i|
            Synth(\simpleTone, [\freq, i, \amp, 0.2, \dur, 0.5]);
            0.6.wait;  // kurze Pause zwischen den Tönen
        };
    };
}).play;
)

// ---------------------------
(
Task({
             // (C4, D4, E4, F4, G4, A4, B4)
    var notes = [60, 62, 64, 65, 67, 69, 71];

    2.do { |iteration|  // 2
        var melody = notes.scramble[0..4];
        ("Iteration: " ++ iteration ++ " - Noten: " ++ melody).postln;

        Pbind(
            \instrument, \default,
            \midinote, melody,
            \dur, Pseq([0.25, 0.5, 0.75].scramble, 5),
            \amp, 0.2
        ).play;

        2.wait;
    };
}).play;
)
