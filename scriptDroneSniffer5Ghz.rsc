{
 #variables to configure
  #:local streamIP 192.168.10.32
  :local streamIP 192.168.10.86

  #end variables to configure
    :local ifaceBand5Ghz [/interface/wifi/radio get [find bands~"5ghz"] interface]

    /interface/wifi sniffer $ifaceBand5Ghz duration=0 stream-rate=4294967295 stream-address=$streamIP filter="type == 0 && subtype == 8"
}