
# 2D-Spiel
> [!NOTE]
> 2D-Plattformer
<br> <br>
<p align="center">
<img width="700"  alt="2D6.2" src="https://github.com/user-attachments/assets/a1f7d800-15f4-4813-b35f-6d3e690f80d9" />
 <br>
  <em> 2D-Plattformer </em>
</p>
<br> <br>

Dem Projekt liegt das Konzept „Homo Ludens“ von Johan Huizinga zugrunde, in dem Spiel als grundlegende Form kultureller Tätigkeit verstanden wird. 

Im Rahmen des Projekts wird das Spiel zugleich als spielerische Handlung und als Ausübung eines Musikinstruments konzipiert.

Das Level ist so gestaltet, dass es im klassischen Sinne gespielt werden kann als gewöhnlicher Plattformer. Wird das Level in einem bestimmten Tempo durchlaufen, wird eine elektronische Musikkomposition ausgelöst. Die Struktur des Levels orientiert sich an Prinzipien elektronischer Komposition: Durch die Interaktion mit Objekten der Spielwelt initiiert der Spieler Klangereignisse, die sich zu einem musikalischen Gesamtwerk zusammensetzen.

Gleichzeitig eröffnet das Projekt die Möglichkeit einer freien musikalischen Interaktion mit dem Spielraum. Das Durchspielen des Levels ist nicht zwingend erforderlich, vielmehr kann der Spieler das Level als musikalisches Instrument nutzen, mit Klängen experimentieren und durch spielerische Handlungen Musik erzeugen.


Eine elektronische Komposition hat ihre eigene Struktur.
<br> <br>

<p align="center">
<img width="700" alt="Struktur" src="https://github.com/user-attachments/assets/2ef41ca6-ad4f-4abf-a57a-dea3a277b258" />
 <br>
  <em> 2D-Plattformer </em>
</p>
<br> <br>

Sie hat einen ruhigen Start. Dann kommen Entwicklung und Dämpfung.

Danach ein kraftvoller Höhepunkt und das Ende. Diese Struktur bildete die Grundlage des Spieles als seinen rhythmischen Teil.

Dieses Prinzip wurde bei der Erstellung des Spiel-Levels komplett wiederholt, die Struktur der Komposition bildete die Grundlage des Level- Designs.

Am Anfang verläuft das Spiel ziemlich ruhig. Das Spiel am Anfang entspricht dem Intro und Breaks (siehe das Foto des Track-Aufbaus) im Aufbau der Musikkomposition. Der Spieler bewegt sich vorwärts und macht sich mit der Spielmechanik und seinen Regeln vertraut.
Im weiteren Verlauf stellt der Spieler fest, dass bestimmte Elemente des Spiels besonders klingen. Das Intro wird automatisch implementiert, der Level ist bewusst

so organisiert, dass der Spieler beim Passieren mit verschiedenen Objekten in Kontakt kommt und Geräusche verursacht.

Wenn der Spieler auf seinem Weg seine ersten Münzen und einen Schlüssel trifft, kann er, nachdem er sie gesammelt hat, feststellen, dass er die Tür benutzen kann, indem er sie öffnet.

<br> <br>
<p align="center">
<img width="700" alt="Door" src="https://github.com/user-attachments/assets/35428210-d6ca-42ce-a284-b333a76d72ad" />
 <br>
  <em> Die Tür </em>
</p>
<br> <br>

Nachdem der Spieler die Tür passiert hat, kommt er wider Erwarten nicht im Spiel vor, sondern er wird gleich zu Beginn des Spiels bewegt. Dieser Zug wird den Spieler mit der Notwendigkeit konfrontieren, den Level erneut zu durchlaufen, wobei er wieder mit den Elementen des Spiels in Kontakt kommt und die Klänge neu erzeugt.

Auf diese Weise reproduziert der Spieler das grundlegende Element, das die Musik bildet die Wiederholung.

Wenn wir das Level-Design mit dem Notentext schreiben würden, dann würde diese Stelle in den Noten so aussehen:
<br> <br>
<p align="center">
<img width="700" alt="Door2" src="https://github.com/user-attachments/assets/8148027b-214f-4d0c-b313-41f9288367c2" />
 <br>
  <em> Notentext </em>
</p>
<br> <br>

Es scheint sehr wahrscheinlich, dass der Spieler versucht, durch die Tür zu gehen und dabei das Prinzip der Wiederholung zu entdecken. An diesem Punkt des Spiels spricht das Spiel die grundlegende Neugier des Spielers und die grundlegende Vertrauenserfahrung an, da das Aufnehmen des Schlüssels und das Betreten der Tür

in den meisten Spielen eine sichere Situation bedeuten, die das Spiel weiter voranbringt. Im Code ist diese Stelle wie folgt implementiert:
<br> <br>
<p align="center">
<img width="700" alt="Door3" src="https://github.com/user-attachments/assets/b1bab76a-d2d6-450b-afe5-45d5b7249a0a" />
 <br>
  <em> Code Unity </em>
</p>
<br> <br>


Auf der Ebene der musikalischen Struktur wird dies durch Breakdown repräsentiert. Im Spiel entspricht dies dem Moment, in dem der Spieler ins Wasser fällt. Das Spieltempo verlangsamt sich. Das Geräusch, das durch Kontakt mit Wasser erzeugt wird, ist ruhig.
<br> <br>
<p align="center">
<img width="700" alt="Wasser" src="https://github.com/user-attachments/assets/53a55c78-492d-46da-937d-ce847a494440" />
 <br>
  <em> Ein ruhiger musikalischer Moment </em>
</p>
<br> <br>

In diesem Bereich trifft der Spieler auf die meisten Feinde. Feinde werden durch eine Säge, eine Säge an einer Kette und durch Stacheln dargestellt. Bei Berührung wird ein Ton erzeugt, der in Atmosphäre und Stil ähnlich dem Dubstep ist. Die an dieser Stelle des Levels platzierten Herzen helfen dem Spieler einerseits, in einem eher schwierigen Gebiet am Leben zu bleiben und den Level zu bestehen. Andererseits helfen sie auch dem Soundtrack, wodurch der Sound des Spiels abwechslungsreicher und melodischer wird.

<br> <br>
<p align="center">
<img width="700" alt="Säge" src="https://github.com/user-attachments/assets/7f4a529d-c117-40bb-a83d-ead70f218f05" />
 <br>
  <em> Ein aktiver und aggressiver musikalischer Moment </em>
</p>
<br> <br>

Da dieser Moment musikalisch aktiv und aggressiv genug ist, um eine Überlastung im Klangraum zu vermeiden, wurde eine Art Objekt geschaffen, das den Klang einmal auslöst und das Objekt selbst durch ein anderes ersetzt, das keinen Klang mehr reproduzieren kann. Optisch kann dieser Ersatz für den Spieler offensichtlich sein ein Plattformtyp wird durch einen anderen ersetzt. Oder es ist nicht offensichtlich, die Art der Plattform wird durch genau die gleiche ersetzt, aber sie gibt bei der Interaktion keinen Ton wieder.

<br> <br>
<p align="center">
<img width="700" alt="Diamanten" src="https://github.com/user-attachments/assets/4a8b3166-5498-4ff3-8233-fa6daa9c6461" />
 <br>
  <em> Diamanten </em>
</p>
<br> <br>


Im Moment des Spiels, der Main1 entspricht, sammelt der Spieler Diamanten. Diamanten wiederum fungieren als Elemente, die zur Entwicklung der Musik beitragen und die Musik näher an den Outro-Teil bringen.

Outro entspricht im Spiel dem letzten Level-Segment. Die Aufgaben in diesem Bereich sind für den Spieler ruhiger. Durch mechanisches Schieben von Kisten muss der Spieler die Kiste auf den Knopf fallen lassen, der den Durchgang öffnet. Der Fall der Kiste wird von einem Sounddesign begleitet.

<br> <br>
<p align="center">
<img width="700" alt="Box" src="https://github.com/user-attachments/assets/b69877b2-d67b-4ad2-822b-4eb30f7bcdf0" />
 <br>
  <em> Main </em>
</p>
<br> <br>



> [!NOTE]
> 🎮 [Hier](https://play.unity.com/en/games/d6f010d8-a973-4a7d-a8fb-b92abe2d8f48/webgl-builds) kann man das Spiel spielen.
>
> 👩‍💻[Hier](https://github.com/MilaGrishkova/Portfolio/tree/main/🎮GameDev/Unity/2D%20Platformer/Code) kann man den Code sehen.

<a href="https://github.com/MilaGrishkova/Portfolio/tree/main/🎮GameDev">
  <img src="https://github.com/user-attachments/assets/988bc5f1-81e9-4eb5-86b3-a12c67cee97b" alt="back-button-icon" width="70">
</a>
