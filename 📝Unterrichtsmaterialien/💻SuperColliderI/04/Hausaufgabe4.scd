SuperCollider I
Hausaufgaben Sitzung 04
// --------------------------------
// Filtern und Osszilatoren
// --------------------------------
// Aufgabe1
// --------------------------------
1) Initialisiere ProxySpace.
2) Erstelle eine eigene Klangquelle ~sound.
3) Verwende mindestens zwei verschiedene Oszillatoren
(z. B. SinOsc, Saw, Pulse, WhiteNoise, Dust2).
4) Achte auf eine moderate Amplitude (max. 0.2).
Ziel: Unterschiedliche Klangquellen kombinieren.

// --------------------------------
// Aufgabe2
// --------------------------------
Erstelle nacheinander mindestens drei verschiedene Filter:
1) einen Tiefpass
2) einen Hochpass
3) einen Bandfilter
4) Steuere die Filterfrequenz mit MouseX.kr.
Ziel: Hören, wie Filter den Klangcharakter verändern.

// --------------------------------
// Aufgabe3
// --------------------------------
Erstelle drei Versionen desselben Patches:
mit LFNoise0
mit LFNoise1
mit LFNoise2
Verwende den Noise zur Modulation der Frequenz oder des Filters. Vergleich der LFNoise-Typen

// --------------------------------
// Aufgabe4
// --------------------------------
Unten siehst du zwei verschiedene Schreibweisen desselben Klangs
(1. mit einer Funktion mit Argumenten, 2. mit einer globalen Variable).
1.
(
a = {
	arg freq = 50, freq2 = 150.01, freq3 = 250.98, freq4 = 50, amp = 0.1;
	var sig;
	sig = (Saw.ar(freq) + Saw.ar(freq2) + Saw.ar(freq3) + (Pulse.ar(freq4) * amp)).dup * amp;
}.play
)

2.
~sound = {(Saw.ar(50) + Saw.ar(150.01) + Saw.ar(250.98) + (Pulse.ar(50) * 0.1)).dup * 0.1}
~sound.play

- Schreibe ein eigenes Klangbeispiel auf zwei verschiedene Arten:
Variante A:
- Schreibe eine Funktion mit arg-Parametern (freq, amp).
Variante B:
- Schreibe denselben Klang mit einer globalen Variable (~sound),
ohne arg, nur mit festen Werten oder globalen Variablen.
- Verwende mindestens zwei unterschiedliche Oszillatoren
(z. B. SinOsc, Saw, Pulse).
- Achte auf eine moderate Lautstärke (max. 0.2).
Beide Varianten sollen klanglich möglichst ähnlich sein.
Ziel: Den Unterschied zwischen parametrisierter Funktion und fest definiertem Patch verstehen.
Verschiedene Schreibweisen in SuperCollider vergleichen.

// Analyse
s.scope;
s.freqscope;
