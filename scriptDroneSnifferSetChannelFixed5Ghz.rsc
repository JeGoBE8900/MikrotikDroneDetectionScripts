{
    #:local fixedChannel 5745; #channel 149
    :local fixedChannel 5180; #channel 36

    :local ifaceBand5Ghz [/interface/wifi/radio get [find bands~"5ghz"] interface]
    :local currentChannel [/interface wifi get $ifaceBand5Ghz channel.frequency];
  
    :if ($currentChannel != $fixedChannel) do={
        /interface wifi set $ifaceBand5Ghz channel.frequency=$fixedChannel
    }

}