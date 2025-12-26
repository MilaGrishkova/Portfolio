SuperCollider I – Sitzung 05

p = ProxySpace.push(s.boot);
// --------------------------------
// Additive Synthese: Klangaufbau aus mehreren Sinusschwingungen
// --------------------------------
(
{
    var grundton = 220;   // Grundfrequenz
    var signal;

    signal =
        SinOsc.ar(grundton, 0, 0.3) +          // Grundton
        SinOsc.ar(grundton * 2, 0, 0.2) +      // 2. Oberton
        SinOsc.ar(grundton * 3, 0, 0.15) +     // 3. Oberton
        SinOsc.ar(grundton * 4, 0, 0.1);       // 4. Oberton

    signal ! 2;   // Stereo-Ausgabe
}.play;
)


s.scope
s.freqscope

// --------------------------------
// Mix
// --------------------------------
(~add = {
    var grundfreq = 220;                      // Grundfrequenz
    var teiltone;                             // Array für Teiltöne

    teiltone = [
        SinOsc.ar(grundfreq, 0, 0.3),         // Grundton
        SinOsc.ar(grundfreq * 2, 0, 0.2),     // 2. Oberton
        SinOsc.ar(grundfreq * 3, 0, 0.15),    // 3. Oberton
        SinOsc.ar(grundfreq * 4, 0, 0.1)      // 5. Oberton
    ];

    Mix(teiltone).dup ;                 // Alle Teiltöne mischen und Stereo
};)

~add.fadeTime = 6;
~add.play;

s.scope
s.freqscope

// --------------------------------
// Additive Synthese: Locale und globale Variablen
// --------------------------------
(
a = {
	arg freq = 50, freq2 = 150.01, freq3 = 250.98, freq4 = 50, amp = 0.1;
	var sig;
	sig = (Saw.ar(freq) + Saw.ar(freq2) + Saw.ar(freq3) + (Pulse.ar(freq4) * amp)).dup * amp;
}.play
)
~sound = {(Saw.ar(50) + Saw.ar(150.01) + Saw.ar(250.98) + (Pulse.ar(50) * 0.1)).dup * 0.1}
~sound.play

// --------------------------------
// Additive Synthese: Mouse.kr
// --------------------------------
~add2 = {SinOsc.ar(400) + SinOsc.ar(400, MouseX.kr(0, 2pi)) * 0.2};
~add2.play;

// --------------------------------
// Ist das auch eine Additive Synthese?
// --------------------------------
~x = {SinOsc.ar(220) - SinOsc.ar(440) - SinOsc.ar(880) * 0.1}
~x.play

//Das sind einzelne Sinus-Oszillatoren (Teiltöne).
//Man addiert und subtrahiert sie:
//Signal = Sinus + (-Sinus) + (-Sinus)
/*
Additive Synthese
- Arbeit mit einzelnen Oszillatoren
- Frequenzen sind explizit definiert
- Signale werden linear summiert
- Kein Filter
Subtraktive Synthese
- Ein komplexes Ausgangssignal (Saw, Pulse, Noise)
- Ein Filter wird angewendet (LPF, HPF, BPF)
- Frequenzen werden entfernt, nicht durch Phaseninvertierung kompensier
*/

// --------------------------------
// Collect für Frequenzarray
// --------------------------------
(
{
    var grund = 150;
    var ober = (1..10).collect { |i|
        SinOsc.ar(grund*i, 0, 0.2/i)  // Amplitude nimmt ab
    };
    Mix(ober) * 0.5
}.play;
)

// --------------------------------
// Collect für Global var
// --------------------------------
(~sound = {
    var grund = 220;
    Mix((1..4).collect { |i| SinOsc.ar(grund*i, 0, 0.3/i) })
};
)
~sound.play;

// --------------------------------
// SumOfSines für harmonische Arrays
// --------------------------------
(
{
    var freqs = [220, 330, 440, 550];
    Mix(freqs.collect { |f| SinOsc.ar(f, 0, 0.2) }) * 0.5
}.play;
)

// --------------------------------
// Stereo oder Mehrkanal
// --------------------------------
// Stereo mit unterschiedlichen Frequenzen
// --------------------------------
// local var
// --------------------------------
(
{
    var left = SinOsc.ar(220, 0, 0.3);
    var right = SinOsc.ar(440, 0, 0.3);
    [left, right]
}.play;
)
s.scope
s.freqscope
// Stereo mit unterschiedlichen Frequenzen
// --------------------------------
// global var
// --------------------------------
~leftright = { SinOsc.ar([300, 800]) * 0.1 };
~leftright.play;
s.scope
s.freqscope

// --------------------------------
// Links: Sinus, Rechts: Rauschen
// --------------------------------
~mehrch = { [SinOsc.ar(800), WhiteNoise.ar()] * 0.1 };
~mehrch.play;
s.scope
s.freqscope

// --------------------------------
// Unterschiedliche Lautstärken pro Kanal
// --------------------------------
// Rechts lauter als links
// --------------------------------
~sound = { SinOsc.ar([200, 400]) * [0.1, 0.3] };
~sound.play;

// --------------------------------
// Mit Hüllkurven (ADSR) für jeden Teiltton
// --------------------------------
(
{
    var grund = 200;
    var t = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    Mix((1..3).collect { |i|
        SinOsc.ar(grund*i, 0, 0.3/i) * t
    })
}.play;
)

// --------------------------------
// Schwebungen
// --------------------------------
~schwebungen = {SinOsc.ar(330) + SinOsc.ar(331) * 0.1}
~schwebungen.play

~schwebungen2 = {SinOsc.ar(330, SinOsc.ar(2) * 2pi) - SinOsc.ar(330) * 0.1};
~schwebungen2.play;

s.scope
s.freqscope
