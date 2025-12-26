SuperCollider I 
Hausaufgaben Sitzung 02
// --------------------------------
// Mathe
// --------------------------------
// Beispiel 1
// --------------------------------
Beispiel: Wetter im Jahr
Aufgabe:
Wir haben die Durchschnittstemperaturen eines Monats in einem Array.
Berechne die durchschnittliche Temperatur im Winter (Dezember, Januar, Februar).
Lösung:
(
var temperaturen = [0, 1, 5, 10, 15, 20, 25, 24, 18, 12, 5, 1];
// Monate: Jan, Feb, Mär, Apr, Mai, Jun, Jul, Aug, Sep, Okt, Nov, Dez
var winter = [temperaturen[0], temperaturen[1], temperaturen[11]];  // Jan, Feb, Dez
var durchschnitt = winter.sum / winter.size;                        // Summe / Anzahl
durchschnitt.postln;                                                // Ausgabe
)

// --------------------------------
// Aufgabe 1
// --------------------------------
Aufgabe:
Gegeben ist ein Array mit Frequenzen von verschiedenen Noten:
var freqs = [220, 233, 247, 262, 277, 294, 311, 330, 349, 370, 392, 415];

Aufgabe: Berechne die durchschnittliche Frequenz der letzten drei Werte im Array.
Hinweis: Gib das Ergebnis mit postln aus.

// --------------------------------
// Beispiel 2
// --------------------------------
Aufgabe: Quadratisches Wachstum von Zahlen
Aufgabe:
Erstelle in SuperCollider ein Array mit 10 Werten (n = 10), das von 100 bis 800 reicht.
Die Werte sollen quadratisch ansteigen, d.h. jeder folgende Wert wächst schneller als der vorherige.
Gib das Array mit postln aus.
Hinweis:
Verwende eine Iteration (Array.fill) und den Index i, um die Werte zu berechnen.
Normiere den Index auf den Bereich von 0 bis 1 und quadriere ihn, bevor du auf den Bereich 100–800 skalierst.
Lösung:
(
var n = 10;                     // Anzahl der Werte
var start = 100;                 // Startwert
var ende = 800;                  // Endwert
var zahlen = Array.fill(n, { |i|
    start + ((ende - start) * (i/(n-1)).squared)   // quadratisches Wachstum
});
zahlen.postln;
)

// --------------------------------
// Aufgabe 2
// --------------------------------
Aufgabe: Quadratisches Wachstum der Lautstärke
Aufgabe:
In SuperCollider wollen wir die Lautstärke (volume) eines Sinus-Oszillators über 8 Schritte quadratisch steigern.
Erstelle ein Array mit 8 Werten von 0.1 bis 0.8, das quadratisch ansteigt.
Gib das Array mit postln aus.
Hinweis:
Verwende Array.fill und den Index i.
Normiere den Index auf 0 bis 1, quadriere ihn und skaliere auf 0.1–0.8.

