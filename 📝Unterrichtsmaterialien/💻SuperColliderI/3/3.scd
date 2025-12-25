SuperCollider I – Sitzung 03

s.boot

// --------------------------------
// ProxySpace
// --------------------------------
p = ProxySpace.push(s.boot);

// --------------------------------
// Sound
// --------------------------------
// Ein Testsignal, drückt Command + Return
{SinOsc.ar(440) * 0.1}.play

// Test-Sound
().play

// --------------------------------
// Stop
// --------------------------------
// Stoppen: Cmd . bzw. Strg/Ctrl

// Markiert alles, was sich zwischen zwei Klammern befindet und drückt Command + Return
(
var sound = {SinOsc.ar(440) * 0.1};
sound.play;
)

// --------------------------------
// Variablen in SuperCollider
// --------------------------------
/*In SuperCollider ist eine Variable ein benannter Speicher für
Daten, der Werte, Signale, Funktionen oder andere Objekte enthalten kann.
Variablen ermöglichen es, Informationen zu speichern, wiederzuverwenden und den Klang oder Berechnungen zu steuern.

// --------------------------------
// Beispiel: Lokale und Globale Variablen in SuperCollider
// --------------------------------
Lokale und Globale Variablen
Lokale Variablen (var) – existieren nur innerhalb eines Blocks oder einer Funktion.
Globale Variablen (~) – sind in der gesamten SuperCollider-Session verfügbar.*/
var freq = 440;  // lokale Variable
~freq = 440;     // globale Variable

// --------------------------------
// Speicherung von Frequenz oder Amplitude in lokalen Variablen
// --------------------------------
(
{
    var freq = 330;  // локальная переменная
    var amp = 0.2;   // локальная переменная

    SinOsc.ar(freq, 0, amp); // использование локальных переменных
}.play;
)

// --------------------------------
// Speicherung von Frequenz oder Amplitude in globalen Variablen
// --------------------------------
~freq = 240;
~amp = 0.3;
(
{
    SinOsc.ar(~freq, 0, 1) * ~amp
}.play;
)

// --------------------------------
// Lokale
// --------------------------------
(
{
    var snd, freq, amp;  // Lokale Frequenz und Amplitude
    freq = 440;          // Hz
    amp = 0.3;           // Lautstärke
    // Sinus-Oszillator mit lokalen Variablen
    snd = SinOsc.ar(freq, 0, amp);
    snd  // Rückgabe des Signals
}.play;
)

// --------------------------------
// Globale
// --------------------------------
(
{
    ~sound = {
        Saw.ar(~freq, ~amp * 0.5) // Sägezahn-Oszillator mit globalen Parametern
    };
	~sound.play;
}.fork; // .fork startet den Block parallel, wie .play bei Synths
)


// Kontrolle über Maus
~klang = {SinOsc.ar( MouseX.kr(220, 440)) * 0.1};

~klang = {SinOsc.ar( XLine.kr(220, 440, 20)) + SinOsc.ar( XLine.kr(220, 880, 20)) * 0.1};

// Modulation
~klang = {SinOsc.ar(SinOsc.ar(Line.ar(0, 1, 30)).range(10, 60))};

~klang.play


// --------------------------------
// Mathematik im Sound (UGens)
// --------------------------------
(
{
    var freq;                                   // Variable für Frequenz
    freq = 440 + (SinOsc.kr(1) * 100);          // Frequenzmodulation
    SinOsc.ar(freq, 0, 0.2)                     // Sinusoszillator im Audiobereich
}.play;

)

// --------------------------------
// Einfache Oszillatoren
// --------------------------------

// SinOsc
// Saw, Impulse, Pulse

~sound = {SinOsc.ar(440) * 0.1};
~sound.fadeTime = 10
~sound.play

// Audio darstellen
s.scope

// lauter
~sound = {SinOsc.ar(440) * 0.3};

// leiser
~sound = {SinOsc.ar(440) * 0.02};

// andere Frequenz
~sound = {SinOsc.ar(220) * 0.02};

// Addition mischt Signale
~sound = {SinOsc.ar(300) + SinOsc.ar(400) * 0.01};
