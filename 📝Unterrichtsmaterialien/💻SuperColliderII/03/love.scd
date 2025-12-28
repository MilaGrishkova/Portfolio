s.record;
(s.scope.(~startRandomLetters);
s.meter;)
~startRandomLetters.();
(s.options.numOutputBusChannels = 16;
s.options.numWireBufs = 2048;
s.reboot;
s.waitForBoot({

    // Load buffer
    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Miss You.wav", channels:[0]);
    // HOA Encoder / Decoder
    ~enc = HoaMatrixEncoder.newDirection(0, 0, \basic, 3);
    ~dec = HoaMatrixDecoder.newModeMatch(
        directions: [
            [36, 54], [108, 54], [180, 54], [-108, 54],
            [-36, 54], [36, 18], [108, 18], [180, 18],
            [-108, 18], [-36, 18], [0, -18], [72, -18],
            [144, -18], [-144, -18], [-72, -18], [0, -54]
        ].degrad,
        beamShape: \energy,
        match: \rms
    );

    // HOA movement function
    ~hoaMove = { |sig|
        sig = HoaEncodeMatrix.ar(sig, ~enc);
        sig = HoaRTT.ar(sig,
            rotate: SinOsc.kr(0.05, 0).range(-pi, pi),
            tilt: SinOsc.kr(0.03, 0).range(-pi/4, pi/4),
            tumble: SinOsc.kr(0.02, 0).range(-pi/6, pi/6)
        );
        HoaDecodeMatrix.ar(sig, ~dec)
    };

    // HOA SynthDef with random start position
    SynthDef(\SampleHOA, { |out=0, bufnum, pitch=1, dur=1|
        var sig, env, numFrames, sr, startPos;
        numFrames = BufFrames.kr(bufnum);
        sr = BufSampleRate.kr(bufnum);

        // Random start position for short snippet
        startPos = rrand(0, (numFrames - (dur * sr)).max(0));

        env = EnvGen.kr(Env.perc(0.01, dur, 1, -4), doneAction:2);

       sig = PlayBuf.ar(
			numChannels: 2,
			bufnum: bufnum,
			rate: pitch * BufRateScale.kr(bufnum),
			startPos: startPos,
			doneAction:2).sum * 0.5 * env; // sum stereo -> mono

        sig = ~hoaMove.(sig);
        Out.ar(out, sig);
    }).add;
    s.sync;
// SynthDef for "love" that plays full buffer without fading
SynthDef(\LoveHOA, { |out=0, bufnum, pitch=1|
    var sig;
    // Play full buffer with pitch scaling and HOA processing
    sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: bufnum,
        rate: pitch * BufRateScale.kr(bufnum),
        loop: 0,          // play once
        doneAction: 2
    ).sum * 0.5;          // sum stereo to mono for HOA

    sig = ~hoaMove.(sig);
    Out.ar(out, sig);
}).add;
s.sync;

});

)

(
~alphabet = ["l","o","v","e"];
~randLetter = { ~alphabet.choose };
~running = false;

~startRandomLetters = {
    if(~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 1.5; // 40 BPM
        var word;

        while({ ~running }) {
            word = Array.fill(4, { ~randLetter.value }).join;

            if(word == "love") {
                ("💖 Could this finally be love?: %".format(word)).postln;
                "--> YES!!!".postln;
                ~running = false;
                Synth(\LoveHOA, [\bufnum, ~buf.bufnum, \pitch, 1]);
            } {
                ("Could this finally be love?: % (No)".format(word)).postln;
                word.do { |l|
                    Synth(\SampleHOA, [
                        \bufnum, ~buf.bufnum,
                        \pitch, rrand(0.9, 1.1),
                        \dur, 1
                    ]);
                };
            };

            interval.wait;
        };
    });
	("🎲 What is the probability?").postln;
};

~stopRandomLetters = {
    ~running = false;
    if(~task.notNil) { ~task.stop; ~task = nil };
    "🛑 Stopped.".postln;
};
)

























//----------------------------------------отлично работающий код
// Настройка сервера и буфера
//----------------------------------------
(
Server.default = s = Server.local;

s.waitForBoot({
    ~buf = Buffer.read(s,"/Users/mila/Supercollider/Sample/Miss You.wav");

    // Синт для коротких отрывков (1 сек, с fade-out)
    SynthDef(\Sample, { |out=0, bufnum, pitch=0.2, dur=1, pan=0|
        var env, sig, startPos, numFrames, sr;

        numFrames = BufFrames.kr(bufnum);
        sr = BufSampleRate.kr(bufnum);

        // старт позиции случайно
        startPos = TRand.kr(0, (numFrames - (dur * sr)).max(0), Dust.kr(1));

        env = EnvGen.kr(Env.perc(0.01, dur, 1, -4), doneAction:2);

        sig = PlayBuf.ar(
            2,                   // стерео
            bufnum,
            rate: pitch * BufRateScale.kr(bufnum),
            startPos: startPos,
            doneAction:2
        ) * env;

        Out.ar(out, Pan2.ar(sig[0], sig[1], pan));
    }).add;

    // Синт для полного проигрывания буфера
    SynthDef(\Love, {
        Out.ar(0, PlayBuf.ar(2, ~buf, doneAction:2))
    }).add;

    "✅ SynthDefs loaded and ready.".postln;
});
)

//----------------------------------------
// Генератор случайных букв
//----------------------------------------
(
~alphabet = ["l", "o", "v", "e"];
~randLetter = { ~alphabet.choose };
~running = false;

~startRandomLetters = {
    if(~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 1; // 40 BPM (секунд)
        var word;

        while({ ~running }) {
            word = Array.fill(4, { ~randLetter.value }).join;

            if(word == "love") {
                ("💖 Could this finally be love?: %".format(word)).postln;
                "--> Yes".postln;
                ~running = false;
                Synth(\Love); // полный буфер
            } {
                ("Could this finally be love?: % (No)".format(word)).postln;
                word.do { |l|
                    var pan = rrand(-1.0, 1.0);
                    var pitch = rrand(0.9, 1.1);
                    Synth(\Sample, [
                        \bufnum, ~buf.bufnum,
                        \pitch, pitch,
                        \dur, 1,
                        \pan, pan
                    ]);
                };
            };

            interval.wait;
        };
    });
    "🎲 Random letters started (call ~stopRandomLetters.() to stop).".postln;
};

~stopRandomLetters = {
    ~running = false;
    if(~task.notNil) { ~task.stop; ~task = nil };
    "🛑 Stopped.".postln;
};
)



~startRandomLetters.();




















(
Server.default = s = Server.local;

s.waitForBoot({
    ~buf = Buffer.read(s, "/Users/mila/Supercollider/Sample/Miss You.wav");

    SynthDef(\Sample, { |out=0, pitch=1, dur=1, pan=0, bufnum|
        var env, sig, startPos, numFrames, sr;

        numFrames = BufFrames.kr(bufnum);
        sr = BufSampleRate.kr(bufnum);

        startPos = TRand.kr(0, (numFrames - (dur * sr)).max(0), Dust.kr(1));

        env = EnvGen.kr(Env.perc(0.01, dur, 1, -4), doneAction:2);

        sig = PlayBuf.ar(
            2,
            bufnum,
            rate: pitch * BufRateScale.kr(bufnum),
            startPos: startPos,
            doneAction: 2
        ) * env;

        sig = Balance2.ar(sig[0], sig[1], pan);
        Out.ar(out, sig);
    }).add;

    SynthDef(\Love, {
        Out.ar(0, PlayBuf.ar(2, ~buf, doneAction:2));
    }).add;

    "✅ Both SynthDefs loaded and ready.".postln;
});
)
)


//----------------------------------------
// Генератор случайных букв
//----------------------------------------
(
~alphabet = ["l", "o", "v", "e"];
~randLetter = { ~alphabet.choose };
~running = false;

~startRandomLetters = {
    if (~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 2; // 40 BPM
        var word;

        while({ ~running }) {
            word = Array.fill(4, { ~randLetter.value }).join;

            if (word == "love") {
                ("💖 Generated word: %".format(word)).postln;
                "--> target 'love' detected! Playing full sample...".postln;
                ~running = false;
                Synth(\Love); // проигрываем полностью
            } {
                ("Generated word: % (not love)".format(word)).postln;

                // короткие кусочки из буфера
                word.do { |l|
                    var pan = rrand(-1.0, 1.0);
                    var pitch = rrand(0.9, 1.1);
                    Synth(\Sample, [
                        \bufnum, ~buf.bufnum,
                        \pitch, pitch,
                        \dur, 1,
                        \pan, pan
                    ]);
                };
            };

            interval.wait;
        };
    });

    "🎲 Random letters started (call ~stopRandomLetters.() to stop).".postln;
};

~stopRandomLetters = {
    ~running = false;
    if (~task.notNil) { ~task.stop; ~task = nil };
    "🛑 Stopped.".postln;
};
)

~startRandomLetters.();













// supercollider_love.scd
// Проект: случайная последовательность букв, при появлении "love" — воспроизвести аудио из буфера; одиночные буквы вызывают звук тиканья с рандомным питчем
// Совместимо с SC 3.13.0

//----------------------------------------
// Настройка сервера и буфера с мелодией
//----------------------------------------
(
Server.default = s = Server.local;

/*SynthDef для тиканья с рандомным питчем
SynthDef.new("tick", { |amp=0.2|
    var freq = 800 + Rand(-50,50); // основной тон колокольчика с небольшой вариацией
    var env = EnvGen.kr(Env.perc(0.01, 0.6, 1, -4), doneAction:2); // быстрый мягкий старт, плавное затухание
    var sig = SinOsc.ar(freq) * env; // основной тон
    sig = sig + SinOsc.ar(freq*1.5, 0, 0.3) * env; // добавим обертку для гармоники
    sig = sig + SinOsc.ar(freq*2.1, 0, 0.2) * env; // еще гармоника
    sig = sig * amp;
    Out.ar(0, (sig!2)); // стерео
}).add;*/
 ~buf = Buffer.read(s,"/Users/mila/Supercollider/Sample/Miss You.wav" );

 SynthDef(\Sample, { |out=0, pitch=1|
    var sig;
    sig = PlayBuf.ar(1, ~buf, rate: pitch, doneAction:2);
    Out.ar(out, sig!2); // стерео
}).add;

"Tick SynthDef added.".postln;
)

//----------------------------------------
//----------------------------------------
// Генератор случайных букв и проверка на 'love'
//----------------------------------------
(
~alphabet = ["l", "o", "v", "e"];
~randLetter = { ~alphabet.choose };

~running = false;

~startRandomLetters = {
    if(~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 0.15;

        while({ ~running }) {
            // генерируем слово из 4 букв сразу
            var word = Array.fill(4, { ~randLetter.value }).join;

            if(word == "love") {
                ("Generated word: %".format(word)).postln;
                "--> target 'love' detected! Playing audio from buffer...".postln;
                ~running = false; // останавливаем генерацию
                b.play;
            } {
                ("Generated word: % (this was not love)".format(word)).postln;
                // проигрываем сэмпл для каждой буквы
                word.do { |l| Synth(\Sample) }; // <-- здесь просто вызываем Synth
            };

            interval.wait;
        };
    });
    "Random letters started (call ~stopRandomLetters.() to stop).".postln;
};
)
~startRandomLetters.();

~startRandomLetters.();


















// supercollider_love.scd
// Проект: случайная последовательность букв, при появлении "love" — воспроизвести аудио из буфера; одиночные буквы вызывают звук тиканья
// Совместимо с SC 3.13.0

//----------------------------------------
// Настройка сервера и буфера с мелодией
//----------------------------------------
(
Server.default = s = Server.local;

    // SynthDef для тиканья
    SynthDef.new("tick", { |amp=0.2|
        var sig = Impulse.ar(8) * Decay.ar(Impulse.ar(0), 0.05) * amp;
        sig = sig + WhiteNoise.ar(0.01) * sig; // немного шума для реалистичности
        Out.ar(0, (sig!2));
    }).add;

    "Buffer allocated and tick SynthDef added.".postln;

)

//----------------------------------------
// Генератор случайных букв и проверка на 'love'
//----------------------------------------
(
~alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m",
             "n","o","p","q","r","s","t","u","v","w","x","y","z"];
~randLetter = { ~alphabet.choose };

~running = false;

~startRandomLetters = {
    if(~running) { "Already running".postln; ^nil };
    ~running = true;

    ~task = Routine.run({
        var interval = 0.15;

        while({ ~running }) {
            var l = ~randLetter.value;

            if(l == "l") {
                var word = "l";
                3.do {
                    var nextLetter = ~randLetter.value;
                    word = word ++ nextLetter;
                };

                if(word == "love") {
                    ("Generated word: %".format(word)).postln;
                    "--> target 'love' detected! Playing audio from buffer...".postln;
                    b.play;
                } {
                    ("Generated word: % (this was not love)".format(word)).postln;
                };
            } {
                // одиночная буква
                ("Letter: %".format(l)).postln;
                Synth.new("tick");
            };

            interval.wait;
        };
    });
    "Random letters started (call ~stopRandomLetters.() to stop).".postln;
};

~stopRandomLetters = {
    ~running = false;
    if(~task.notNil) { ~task.stop; ~task = nil };
    "Stopped.".postln;
};
)
~startRandomLetters.();

