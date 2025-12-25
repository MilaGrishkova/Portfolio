// Höhen herausfiltern
~filter = { LPF.ar(~klang.ar, MouseX.kr(50, 20000)) }
~filter = { RLPF.ar(~klang.ar, MouseX.kr(50, 20000), 0.2) }

// Tiefen herausfiltern
~filter = { HPF.ar(~klang.ar, MouseX.kr(50, 20000)) }
~filter = { RHPF.ar(~klang.ar, MouseX.kr(50, 20000), 0.2) }

// Bandpassfilter
~filter = { BPF.ar(~klang.ar, MouseX.kr(50, 20000), 0.1) * 10}

// Band-Reject-Filter
~filter = { BRF.ar(~klang.ar, MouseX.kr(50, 20000), 0.4)}

// Tiefpassfilter + Band-Reject-Filter
~filter = { BRF.ar( LPF.ar(~klang.ar, MouseX.kr(50, 20000)), 2000) }


// Ohne Filter
~filter = { ~klang.ar }


~filter = { RLPF.ar(~klang.ar, SinOsc.kr(LFTri.kr(0.1).range(1, 4)).range(200, XLine.ar(100, 8000, 60)), 0.2) }

// immer wieder erneut ausführen
~filter = { RLPF.ar(~klang.ar, XLine.ar(2400, 100, 0.5), 0.2) * XLine.ar(1, 0.001, 1.5) }

~filter.play


