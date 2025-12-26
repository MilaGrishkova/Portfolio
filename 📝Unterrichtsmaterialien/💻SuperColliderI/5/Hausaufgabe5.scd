SuperCollider I – Hausaufgaben Sitzung 05
// --------------------------------
// Additive Synthese
// --------------------------------
// Aufgabe1
// --------------------------------
1) Erstelle einen Synth, der aus mindestens vier Sinus-Oszillatoren besteht.
2) Die Grundfrequenz soll 220 Hz betragen.
3) Die Obertöne sollen harmonisch sein (2f, 3f, 4f).
4) Die Amplituden sollen mit jedem Oberton kleiner werden.
5) Spiele das Signal stereo ab.
Hinweis:
Benutze SinOsc.ar und Mix oder direkte Addition.

// --------------------------------
// Aufgabe2
// --------------------------------
1) Erzeuge ein Array von 10 Sinus-Oszillatoren, deren Frequenzen Vielfache einer Grundfrequenz (150 Hz) sind.
2) Die Amplituden sollen mit zunehmendem Oberton abnehmen (z. B. 0.2/i).
3) Nutze collect und Mix, um ein einzelnes Stereo-Signal zu erhalten.
4) Spiele das Signal ab.
Zusatz:
Experimentiere, wie sich der Klang verändert, wenn du die Grundfrequenz live veränderst (global var).

// --------------------------------
// Aufgabe3
// --------------------------------
1) Erstelle ein Stereo-Signal:
2) Linker Kanal: 300 Hz Sinus
3) Rechter Kanal: Rauschen
4) Die Lautstärken sollen unterschiedlich sein (z. B. links 0.1, rechts 0.3)
Hinweis:
Verwende Arrays [left, right] und SinOsc.ar, WhiteNoise.ar.

// --------------------------------
// Aufgabe4
// --------------------------------
1) Erzeuge Schwebungen zwischen zwei Sinus-Oszillatoren.
2) Grundfrequenz: 330 Hz
3) Zweiter Ton: leicht verschoben, z. B. 331 Hz
4) Spiele das Signal ab und beobachte mit s.freqscope das Verhalten.
Zusatz:
Variiere die Amplitude des zweiten Tons (z. B. 0.05 bis 0.2) und beschreibe, wie sich die Schwebung verändert.

