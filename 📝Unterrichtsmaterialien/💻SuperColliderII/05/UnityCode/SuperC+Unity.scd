~foodVar = Buffer.read(Server.default, "/Users/administrator/Desktop/SuperC+UnityAudio/scavengers_fruit1.aif");

SynthDef(\sampler, {
	arg out = 0, rate = 1, amp = 0.5, buffer = 0;
	var signal;
	signal =
	PlayBuf.ar(1, buffer,
		BufRateScale.kr(buffer) * rate,
		doneAction:2
	);
	Out.ar(out, signal!2 * amp);
}).add;

//Food OSC
OSCdef.new(
	\food,
	{arg msg;
		[msg].postln;
		Synth(\sampler, [\buffer, ~foodVar]);
	},
	'/food',
	nil, 57120
);

OSCdef.new(
	\soda,
	{arg msg;
		[msg].postln;
	},
	'/soda',
	nil, 57120
);

OSCdef.new(
	\move,
	{arg msg;
		[msg].postln;
	},
	'/move',
	nil, 57120
);

OSCdef.new(
	\chop,
	{arg msg;
		[msg].postln;
	},
	'/chop',
	nil, 57120
);

OSCdef.new(
	\exit,
	{arg msg;
		[msg].postln;
	},
	'/exit',
	nil, 57120
);

OSCdef.new(
	\enemyHit,
	{arg msg;
		[msg].postln;
	},
	'/enemyHit',
	nil, 57120
);

OSCdef.new(
	\gameOver,
	{arg msg;
		[msg].postln;
	},
	'/gameOver',
	nil, 57120
);

 OSCdef.new(
	\health,
	{arg msg;
		[msg].postln;
	},
	'/health',
	nil, 57120
);
