{
 #variables to configure
  :local streamIP 192.168.10.32
  :local wifiInterface "wifi2"

  #end variables to configure

    /interface/wifi sniffer $wifiInterface duration=0 stream-rate=4294967295 stream-address=$streamIP filter="type == 0 && subtype == 8"
}