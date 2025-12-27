SuperCollider I 
Hausaufgaben Sitzung 03
// --------------------------------
// Variablen und SinOsc
// --------------------------------

1) ProxySpace initialisieren
Starte SuperCollider und initialisiere ProxySpace mit
p = ProxySpace.push(s.boot);

2) Block mit lokalen Variablen erstellen
Erstelle einen Block { ... } mit lokalen Variablen freq und amp.
Weise freq = 230 und amp = 0.2 zu.
Erzeuge einen Sinus-Oszillator SinOsc.ar(freq, 0, amp)
und spiele das Signal ab.

3) Block mit globalen Variablen erstellen
Erstelle globale Variablen ~freq und ~amp.
Weise ~freq = 480 und ~amp = 0.5 zu.
Erzeuge einen Sinus-Oszillator mit den globalen Variablen.
Setze .fadeTime = 5 Sekunden.
Spiele das Signal ab.

Experimentiert mit der Tonhöhe (Frequenz).
Seid vorsichtig mit der Lautstärke (Amplitude)
sie beeinflusst die Lautstärke des Tons.

Ziel:
Den Unterschied zwischen lokalen und globalen Variablen erkennen.
Mit fadeTime ein sanftes Ein- und Ausblenden des Signals ausprobieren.
