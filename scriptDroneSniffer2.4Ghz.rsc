{
 #variables to configure
  :local streamIP 192.168.10.32

  #end variables to configure
    :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]

    /interface/wifi sniffer $ifaceBand2Ghz duration=0 stream-rate=4294967295 stream-address=$streamIP filter="type == 0 && subtype == 8"
}