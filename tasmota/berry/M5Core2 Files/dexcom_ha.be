###### WAS WORKING #######
class DEXCOM_HA : Driver

var msg_dex
var dexvalue
def init()
  import json
  
    # self.msg_dex = {'DexcomHA': {}}
    # self.msg_dex['DexcomHA']['dexvalue'] = '1133'
    # self.msg_dex['DexcomHA']['dextrend'] = 'helpme'
    #tasmota.response_append(json.dump(self.msg_dex))
    # tasmota.publish_result(json.dump(self.msg_dex), 'DEX') 
    # print(json.dump(self.msg_dex))

  # end
  return true
end



def read_dex()
  var d1 = 6677
  var d2 = "tready"
  self.dexvalue = [d1, d2]
  
  return self.dexvalue
end
  def every_second()
    
    self.read_dex()

     #print("Every Second")    
     #print(int(self.dexvalue.find("dexvalue")))
    #print(str(self.dexvalue.find("dextrend")))
    #print(self.dexvalue)
  end

#- display sensor value in the web UI -#
  def web_sensor()
    if !self.dexvalue[0] return nil end  #- exit if not initialized -#
    import string
    var msg = string.format(
            "{s}MPU6886 dex_v{m}%i mgdl{e}"..
            "{s}MPU6886 dex_t{m}%s trend{e}",
            self.dexvalue[0], self.dexvalue[1])

      tasmota.web_send_decimal(msg)
    end

  def json_append()
    if !self.dexvalue[0] return nil end  #- exit if not initialized -#
    import string
    var msg = string.format(",\"DEXCOM\":{\"Dexvalue\":%i,\"Dextrend\":%s}", self.dexvalue[0], '"'+self.dexvalue[1]+'"')
    tasmota.response_append(msg)


  end
end
#return DEXCOM_HA
dexcom_ha = DEXCOM_HA()
tasmota.add_driver(dexcom_ha)