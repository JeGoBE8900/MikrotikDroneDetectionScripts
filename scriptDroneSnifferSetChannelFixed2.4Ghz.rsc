{
    :local fixedChannel 2437;
    :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]
    :local currentChannel [/interface wifi get $ifaceBand2Ghz channel.frequency];


    :if ($currentChannel != $fixedChannel) do={
        /interface wifi set $ifaceBand2Ghz channel.frequency=$fixedChannel
    }
}