# Logic & SuperCollider

> [!TIP]
>  🎶 Hier kann man es sehen: Logic & SuperCollider
<br> <br>
<p align="center">
<em>  Klick auf das Bild, um das Video zu schauen👇</em>
  <p align="center">
<a href="https://youtu.be/xTNkz9WZF08">
 <img width="700" alt="Logic1" src="https://github.com/user-attachments/assets/aba862c7-bbe4-4de3-a66e-4345f95ba58b" />
 <br>
</a>
 <em> Klick auf das Bild, um das Video zu schauen☝️</em>
</p>

<p align="center">
<img width="700" alt="Logic2" src="https://github.com/user-attachments/assets/72f6858b-0617-4555-863e-65948553ef20" />
<br>
  <em>Logic & SuperCollider</em>
</p>


Ein Sampler in der Umgebung SuperCollider stellt eine Synthesizer-Struktur dar, die zur Wiedergabe von zuvor aufgenommenem Audiomaterial (Samples) dient, das in Buffers gespeichert ist. Die Wiedergabe erfolgt über Buffer-Objekte, die Audiodateien in den Arbeitsspeicher des Servers laden und einen schnellen Echtzeitzugriff ermöglichen.

Die Grundlage des Samplers bilden UGens (Unit Generators) wie PlayBuf, BufRd oder GrainBuf, die es erlauben, Audiodaten aus dem Buffer mit variabler Geschwindigkeit abzuspielen, vorwärts oder rückwärts, mit der Möglichkeit zum Loopen und zur präzisen Positionierung des Wiedergabestarts. Die Steuerung der Abspielgeschwindigkeit ist direkt mit dem Parameter Pitch verknüpft, wodurch eine Transposition des Samples und eine Veränderung seiner klanglichen Eigenschaften möglich ist.

Der Sampler wird in SuperCollider programmatisch als SynthDef realisiert, was eine flexible Kontrolle seiner Parameter erlaubt. Zu den zentralen Parametern gehören Amplitude, Hüllkurve, Panoramierung und die Signal-Routing zum Main Output. Die Panoramierung ermöglicht die Positionierung des Klangs im Stereo- oder Mehrkanalraum, wodurch ein Gefühl von Bewegung und räumlicher Tiefe erzeugt wird.

Für die räumliche und zeitliche Klanggestaltung können in den Sampler Effekte wie Delay und Reverb integriert werden. Delay erzeugt eine zeitliche Verschiebung und Wiederholung des Audiosignals, verstärkt die rhythmische Struktur und das Zeitgefühl. Reverb wird verwendet, um akustische Räume zu simulieren und Tiefe hinzuzufügen, wodurch das Sample in eine virtuelle Umgebung mit unterschiedlichen räumlichen Eigenschaften eingebettet wird.

Eine Besonderheit des Samplings in SuperCollider ist die Möglichkeit der algorithmischen Steuerung aller Parameter. Parameter wie Pitch, Panoramierung, Verzögerungszeit und Reverb-Stärke können in Echtzeit auf der Basis zufälliger, stochastischer oder deterministischer Prozesse sowie unter Verwendung von Patterns verändert werden. Dies ermöglicht die Erzeugung dynamischer und sich entwickelnder Klangstrukturen.

Somit fungiert der Sampler in SuperCollider nicht nur als Werkzeug zur Wiedergabe von Audiomaterial, sondern als komplexes Klangsystem, das Sample-Wiedergabe, räumliche Organisation, zeitliche Verarbeitung und algorithmische Steuerung vereint und ihn zu einem leistungsfähigen Instrument für Sounddesign und experimentelle Komposition macht.

> [!TIP]
> [Hier](https://github.com/MilaGrishkova/Portfolio/blob/main/📝Unterrichtsmaterialien/💻SuperColliderII/02/Sampler.scd) kann man den Code sehen.

<a href="https://github.com/MilaGrishkova/Portfolio/tree/main/📝Unterrichtsmaterialien/💻SuperColliderII">
  <img src="https://github.com/user-attachments/assets/988bc5f1-81e9-4eb5-86b3-a12c67cee97b" alt="back-button-icon" width="70">
</a>

