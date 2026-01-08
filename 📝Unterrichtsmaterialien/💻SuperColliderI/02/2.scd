SuperCollider I 
Sitzung 02

// --------------------------------
// Server booten
// --------------------------------
s.boot
// Cmd + B / Strg + B oder

// --------------------------------
// Kommentare
// --------------------------------

// Kommentare über eine Zeile: //

/*
Kommentare über mehrere Zeilen:
*/

// Hilfe (+ Shortcuts)

// --------------------------------
// Arithmetische Operatoren
// --------------------------------

// + - * / %

// --------------------------------
// Grundlegende Mathematik
// --------------------------------
1 + 2;      // Addition
5 - 3;      // Subtraktion
4 * 6;      // Multiplikation
10 / 4;     // Division
10 % 3;     // Modulo (Rest der Division)

// --------------------------------
// Variablen und Ausdrücke
// --------------------------------
var a, b;
a = 5;  // Variable a
b = 2;  // Variable b
a.postln;
b.postln;
a + b;      // Addition von Variablen
a.pow(b); // Potenz: a hoch b
c = a + b;
a = a + 2;
c = a + b;

// --------------------------------
// Mathematische Funktionen
// --------------------------------
sin(1);     // Sinusfunktion
cos(0.5);   // Kosinusfunktion
sqrt(16);   // Quadratwurzel
exp(1);     // Exponentialfunktion
log(10);    // Logarithmus

// --------------------------------
// Arbeit mit Arrays
// --------------------------------
// Liste erstellen
(
var zahlen = [1, 2, 3, 4, 5];   // Liste von Zahlen
zahlen.postln;
)

// --------------------------------
// Zugriff auf Elemente
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
zahlen[0].postln;  // erstes Element: 1
zahlen[4].postln;  // letztes Element: 5
)

// --------------------------------
// Element ändern
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
zahlen[2] = 99;     // Das 3. Element wird durch 99 ersetzt.
zahlen.postln;      // Ausgabe: [1, 2, 99, 4, 5]
)

// --------------------------------
// Element am Ende hinzufügen
// --------------------------------
(
var zahlen = [1, 2, 3];
zahlen = zahlen.add(4);   // Element an das Ende hinzufügen
zahlen.postln;            // Ausgabe: [1, 2, 3, 4]
)

// --------------------------------
// Element an bestimmter Stelle einfügen (mit ++)
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
var neueZahl = 99;
var index = 2;
zahlen = (zahlen[0..(index-1)] ++ [neueZahl] ++ zahlen[index..]); // neueZahl an Index 2
zahlen.postln; // Ausgabe: [1, 2, 99, 3, 4, 5]
)

// --------------------------------
// Element an bestimmter Stelle einfügen (mit insert)
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
var neueZahl = 99;
var index = 2;
zahlen = zahlen.copy;             // eine Kopie des Arrays erstellen, um das Original nicht zu verändern
zahlen.insert(index, neueZahl);   // die Zahl an der Position index einfügen
zahlen.postln;                    // Ausgabe: [1, 2, 99, 3, 4, 5]
)

// --------------------------------
// Letzte drei Elemente  und die Summe
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
var summe = summe;
var letzteDrei = zahlen.copyRange(zahlen.size-3, zahlen.size-1);
letzteDrei.postln; // Ausgabe: [3, 4, 5]

summe = letzteDrei.sum;
summe.postln; // Ausgabe: 12 (3+4+5)
)

(
var zahlen = [1, 2, 3, 4, 5];
var letzteDrei, summe, quadrate, groesserAlsDrei;

// Letzte drei Elemente auswählen
letzteDrei = zahlen.copyRange(zahlen.size-3, zahlen.size-1);
letzteDrei.postln; // Ausgabe: [3, 4, 5]

// Summe berechnen
summe = letzteDrei.sum;
summe.postln; // Ausgabe: 12

// Quadrat jedes Elements
quadrate = letzteDrei.collect { |x| x*x };
quadrate.postln; // Ausgabe: [9, 16, 25]

// Elemente größer als 3 filtern
groesserAlsDrei = letzteDrei.select { |x| x > 3 };
groesserAlsDrei.postln; // Ausgabe: [4, 5]
)

// --------------------------------
// Alle Elemente multiplizieren
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
var doppelt = zahlen * 2;                // Jeden Wert mit 2 multiplizieren
doppelt.postln;
)

(
var zahlen = [1, 2, 3, 4, 5] * 2;        // Jeden Wert mit 2 multiplizieren
zahlen.postln;
)

// --------------------------------
// Summe der Elemente
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5]; 
var summe = zahlen.sum;                  // Alle Elemente addieren
summe.postln;
)

[1, 2, 3] + [10, 20, 30];                // Elementweise Addition

// --------------------------------
// Zufällige Liste erstellen
// --------------------------------
(
var zufallsZahlen = Array.fill(5, { 10.rand });   // Liste mit 5 zufälligen Zahlen von 0 bis 9
zufallsZahlen.postln;
)

// --------------------------------
// Element entfernen
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
zahlen.removeAt(1);   // Entfernt das 2. Element, verändert das Array direkt
zahlen.postln;        // Ausgabe: [1, 3, 4, 5]
)

// --------------------------------
// Quadrat jedes Elements
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5];
zahlen.do { |x|
    (x * x).postln;    // Quadrat jedes Elements ausgeben
};
)

// --------------------------------
// Gerade Zahlen auswählen
// --------------------------------
(
var zahlen = [1, 2, 3, 4, 5, 6];
var gerade = zahlen.select { |x| x % 2 == 0 };  // Nur gerade Zahlen
gerade.postln;                                  // Ausgabe: [2, 4, 6]
)

// --------------------------------
// Zufallszahlen
// --------------------------------
10.rand;        // Zufällige ganze Zahl von 0 bis 9
1.0.rand;       // Zufällige Fließkommazahl von 0.0 bis 1.0
rrand(5, 10);   // Zufallszahl zwischen 5 und 10

// --------------------------------
// Werte skalieren
// --------------------------------
5.linlin(0, 10, 200, 800);   // Lineare Skalierung eines Wertes

// --------------------------------
// Schleifen
// --------------------------------
(
10.do { |i|                  // Schleife von 0 bis 9
    (i * i).postln;          // Quadrat der Zahl ausgeben
};
)

// --------------------------------
// Sortiert
// --------------------------------
(
[   "{ alt 8",
	"} alt 9",
	"[ alt 5",
	"] alt 6",
	"| alt 7"].sort({|a, b| a[6] <= b[6]})
              .do({|x| x.postln;})
)

// --------------------------------
// Aufgabe
// --------------------------------

Ein Mensch geht mit einer Geschwindigkeit von 5 km/h. Wie viele Kilometer legt er in 3 Stunden zurück?

(
var geschwindigkeit = 5;   // Geschwindigkeit in km/h
var zeit = 3;              // Zeit in Stunden
var strecke;               // Strecke in km

strecke = geschwindigkeit * zeit;
strecke.postln;
)
