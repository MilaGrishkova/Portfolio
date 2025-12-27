/*OSC (Open Sound Control) und SuperCollider
OSC (Open Sound Control) ist ein flexibles Protokoll zur Kommunikation zwischen Musik- und Audio-Software oder Geräten. 

Es funktioniert ähnlich wie MIDI, ist aber deutlich vielseitiger: Es kann Float-, Integer- und String-Werte übertragen, 

komplexe Daten wie Listen oder Arrays transportieren und über Netzwerkverbindungen (UDP/IP) arbeiten. Dadurch lassen sich Parameter steuern, 

Events triggern oder Sensorwerte übertragen – sowohl auf demselben Computer als auch zwischen verschiedenen Geräten, z. B. von einem Tablet zu einem PC.

SuperCollider unterstützt OSC nativ und bietet dafür Klassen wie NetAddr, OSCFunc oder OSCdef. 

Nachrichten in OSC haben einen Adresspfad, zum Beispiel /synth/frequency, und können Werte enthalten. 

Um eine OSC-Nachricht zu empfangen, definiert man einen OSC-Handler:*/

OSCdef(\freq, { |msg|
    ("Frequenz: " ++ msg[1]).postln;
}, '/synth/frequency');

/*Hier wird jede eingehende Nachricht auf /synth/frequency verarbeitet, und msg[1] enthält den Wert, z. B. eine Frequenz. 

Um selbst Nachrichten zu senden, nutzt man NetAddr:*/

n = NetAddr("127.0.0.1", 57120); // localhost, Port 57120
n.sendMsg("/synth/frequency", 440); // Frequenz auf 440 Hz setzen

/*Praktische Anwendungen von OSC mit SuperCollider sind vielfältig: 

Live-Musik, Steuerung von Filtern oder Effekten von externen Geräten, 

Performance-Setups mit Tablets oder Controllern, Integration mit DAWs wie Logic Pro 

oder die Echtzeit-Synchronisation mehrerer Rechner oder Geräte. 

Durch die Kombination von OSC und SuperCollider lassen sich komplexe, interaktive Klangumgebungen einfach realisieren.*/
