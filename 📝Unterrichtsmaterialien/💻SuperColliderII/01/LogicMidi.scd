MIDIClient.init;
MIDIClient.destinations;
m = MIDIOut.new(0);

(~inst = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, m,
	\chan, 0,
	\midinote, Pseq([53, 65, 63, 0, 0, 60, 58, 0, 0, 56, 58, 60, 53, 0, 0, 0], inf),
	\amp, Pexprand(4, 6, inf),
	\dur, 0.25
	).play;

~inst2 = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, m,
	\chan, 1,
	\midinote, Pseq([29, 29, 32, 32], inf),
	\amp, Pexprand(4, 6, inf),
	\dur, 2
).play;

~inst = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, m,
	\chan, 2,
	\midinote, Pseq([29, 48, 39, 39, 48, 53, 29, 29], inf),
	\amp, Pexprand(4, 6, inf),
	\dur, 0.25
	).play;)
