SuperCollider I 
Sitzung 04
// --------------------------------
// Filtern
// --------------------------------

p = ProxySpace.push(s.boot);

// Klangquelle (Beispiel)
~sound = { Saw.ar(200) * 0.1 };

// --------------------------------
// 1. Tiefpassfilter (LPF)
// --------------------------------
// Filtert hohe Frequenzen heraus
~filter = {
    LPF.ar(~sound.ar, MouseX.kr(100, 20000))
};
~filter.play;

// --------------------------------
// 2. Resonanter Tiefpassfilter (RLPF)
// --------------------------------
// Betonung an der Grenzfrequenz
~filter = {
    RLPF.ar(~sound.ar, MouseX.kr(100, 20000), 0.3)
};
~filter.play;

// --------------------------------
// 3. Hochpassfilter (HPF)
// --------------------------------
// Filtert tiefe Frequenzen heraus
~filter = {
    HPF.ar(~sound.ar, MouseX.kr(20, 5000))
};
~filter.play;

// --------------------------------
// 4. Resonanter Hochpassfilter (RHPF)
// --------------------------------
~filter = {
    RHPF.ar(~sound.ar, MouseX.kr(20, 5000), 0.4)
};
~filter.play;

// --------------------------------
// 5. Bandpassfilter (BPF)
// --------------------------------
// Lässt nur einen schmalen Frequenzbereich durch
~filter = {
    BPF.ar(~sound.ar, MouseX.kr(200, 8000), 0.1) * 5
};
~filter.play;

// --------------------------------
// 6. Bandsperrfilter (BRF / Notch)
// --------------------------------
// Entfernt einen bestimmten Frequenzbereich
~filter = {
    BRF.ar(~sound.ar, MouseX.kr(200, 8000), 0.3)
};
~filter.play;

// --------------------------------
// 7. Kombination: LPF + BRF
// --------------------------------
~filter = {
    BRF.ar(LPF.ar(~sound.ar, MouseX.kr(200, 8000)), 2000)
};
~filter.play;

// --------------------------------
// 8. Automatisierter Filter mit LFO
// --------------------------------
// Filterfrequenz bewegt sich langsam
~filter = {
    RLPF.ar(~sound.ar, SinOsc.kr(0.2).range(300, 6000), 0.2)
};
~filter.play;

// --------------------------------
// 9. Ohne Filter (Referenz)
// --------------------------------
~filter = {~sound.ar };
~filter.play;

// Abspielen
~filter.play;

s.scope
s.freqscope

// --------------------------------
// Oszillatoren: SinOsc, Pulse, Impulse
// --------------------------------
// Generatoren: Dust2
// --------------------------------
// LF Oszillatoren: LFPulse, LFSaw, LFTri, (alle anderen Oszillatoren gehen aber auch)
// --------------------------------

~sound = {Saw. ar(60).dup * 0.1}

~sound = {(Saw.ar(60) + Saw.ar(70) + Saw.ar(30) + (WhiteNoise.ar() * 0.1)).dup * 0.1}

~sound = {(Saw.ar(100) + Saw.ar(200) + Saw.ar(300) + (Pulse.ar(70) * 0.1)).dup * 0.1}

~sound = {Pulse.ar(70).dup * 0.1}

~sound = {Dust2.ar(1020).dup * 0.1}

~sound = {Impulse.ar(222).dup * 0.1}

~sound = {LFNoise0.ar(2200).dup * 0.1}

~sound = {WhiteNoise.ar().dup * 0.1}

~sound.play
s.scope
s.freqscope

(
a = {
	arg freq = 50, freq2 = 150.01, freq3 = 250.98, freq4 = 50, amp = 0.1;
	var sig;
	sig = (Saw.ar(freq) + Saw.ar(freq2) + Saw.ar(freq3) + (Pulse.ar(freq4) * amp)).dup * amp;
}.play
)
~sound = {(Saw.ar(50) + Saw.ar(150.01) + Saw.ar(250.98) + (Pulse.ar(50) * 0.1)).dup * 0.1}
~sound.play


// --------------------------------
// Low-Frequency Noise – Beispiele
// --------------------------------
// LFNoise0, LFNoise1, LFNoise2
// --------------------------------
~sound = { SinOsc.ar(440) * 0.2 };
~sound.play

// --------------------------------
// 1. LFNoise0 – stufig (Sprünge)
// --------------------------------
// Zufällige Werte, die abrupt wechseln
~mod = {
    LFNoise0.kr(2).range(200, 800)
};

~sound = {
    SinOsc.ar(~mod.kr) * 0.2
};

~sound.play;
s.scope
s.freqscope

// --------------------------------
// 2. LFNoise1 – linear (gleitend)
// --------------------------------
// Zufällige Werte mit geraden Übergängen
~mod = {
    LFNoise1.kr(2).range(200, 800)
};

~sound = {
    SinOsc.ar(~mod.kr) * 0.2
};
~sound.play;
s.scope
s.freqscope

// --------------------------------
// 3. LFNoise2 – weich (kurvig)
// --------------------------------
// Zufällige Werte mit glatten Kurven
~mod = {
    LFNoise2.kr(2).range(200, 800)
};

~sound = {
    SinOsc.ar(~mod.kr) * 0.2
};
~sound.play;
s.scope
s.freqscope
