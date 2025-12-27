SuperCollider I
Sitzung 09 Hausaufgabe
// --------------------------------
Aufgabe1:
1) Erstelle eine eigene SynthDef (z.B. Sinus oder Saw).
2) Schreibe einen Pbind, der:
- mindestens 4 verschiedene Frequenzen oder MIDI-Noten verwendet
- unterschiedliche Notenlängen (\dur) nutzt
- genau 2-mal abgespielt wird (nicht unendlich!)
3) Die Melodie soll automatisch stoppen.
Hinweis:
Nutze Pseq(..., 2) statt inf.
// --------------------------------
Aufgabe 2:
1) Verwende die vorhandene SynthDef (Aufgabe1).
2) Schreibe einen Pbind, der:
- eine ruhige Melodie erzeugt
- \amp, \pan und \len mit Pseq steuert
- mindestens 8 Noten enthält
3) Die Sequenz soll unendlich laufen, aber manuell stoppbar sein.
// --------------------------------
Aufgabe 3:
1) Erstelle einen Task, der:
- 3 Durchläufe macht (3.do)
2) In jedem Durchlauf:
- wird ein neuer Pbind gestartet
- mit zufällig gemischten MIDI-Noten (scramble)
3) Nach jedem Durchlauf:
- wartet der Task 2 Sekunden, bevor der nächste startet
Hinweis:
Verwende Pseq(..., 1) damit jeder Pbind endlich ist
Nutze .scramble für Variation
