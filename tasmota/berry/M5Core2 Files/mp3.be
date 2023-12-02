class MP3_Player : Driver
  var audio_output, audio_mp3
  def init()
    self.audio_output = AudioOutputI2S(
      gpio.pin(gpio.I2S_OUT_CLK),
      gpio.pin(gpio.I2S_OUT_SLCT),
      gpio.pin(gpio.I2S_OUT_DATA),
      0,    #- I2S port -#
      64)    #- number of DMA buffers of 64 bytes each, this is the value required since we update every 50ms -#
    self.audio_mp3 = AudioGeneratorMP3()
  end

  def play(mp3_fname)
    if self.audio_mp3.isrunning()
      self.audio_mp3.stop()
    end
    var audio_file = AudioFileSourceFS(mp3_fname)
    self.audio_mp3.begin(audio_file, self.audio_output)
    self.audio_mp3.loop()    #- start playing now -#
  end

  def every_50ms()
    if self.audio_mp3.isrunning()
      self.audio_mp3.loop()
    end
  end
end

mp3_player = MP3_Player()
tasmota.add_driver(mp3_player)