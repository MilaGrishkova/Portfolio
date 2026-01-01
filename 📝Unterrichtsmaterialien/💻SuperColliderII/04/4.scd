b = NetAddr.new("127.0.0.1", 7771);    // create the NetAddr
b.sendMsg("/hello", "there");    // send the application the message "hello" with the parameter "there"

NetAddr.langPort;    // retrieve the current port SC is listening to

NetAddr.localAddr;

thisProcess.openUDPPort(1121); // attempt to open 1121
thisProcess.openPorts; // list all open ports


n = NetAddr.new("127.0.0.1", 7771);    // create the NetAddr
// create the OSCFunc
o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/goodbye', n);
o.free;    // remove the OSCFunc when you are done.


o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/goodbye'); // create the OSCFunc
o.free;    // remove the OSCFunc when you are done.


OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off


// this example is basically like OSCFunc.trace but filters out
// /status.reply messages
(
f = { |msg, time, addr|
    if(msg[0] != '/status.reply') {
        "time: % sender: %\nmessage: %\n".postf(time, addr, msg);
    }
};
thisProcess.addOSCRecvFunc(f);
);

// stop posting.
thisProcess.removeOSCRecvFunc(f);


// https://doc.sccode.org/Guides/OSC_communication.html



