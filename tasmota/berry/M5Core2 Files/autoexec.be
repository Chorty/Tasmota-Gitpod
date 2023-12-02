if tasmota.cmd("SSId1")["SSId1"] == "" && tasmota.cmd("SSId2")["SSId2"] == ""
    # this is the state after first flash or reset 1
    tasmota.cmd("so115 1") # make sure BLE is on
    tasmota.set_timer(10000, /->load("improv.be")) # let the system do some booting
end
load('partition.be')
#axp.set_speaker_enable(true)
#import mpu6886
axp.set_speaker_enable(1)
#load('TFDemo.be')
#load('mp3.be')
load('rainbow.be')
import audio_slm
#import haspmota
#haspmota.start()
# example that only allows Improv-Wifi via BLE, when the system is open anyway

