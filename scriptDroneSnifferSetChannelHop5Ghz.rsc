{
    :local ifaceBand5Ghz [/interface/wifi/radio get [find bands~"5ghz"] interface]
    
    #:local channelItems {"5180";"5200";"5220";"5240";"5260";"5280";"5300";"5320";"5500";"5520";"5540";"5560";"5580";"5600";"5620";"5640";"5660";"5680";"5700";"5720";"5745";"5765";"5785";"5805";"5825"};
    :local channelItems {"5180";"5200";"5220";"5240"};
    :local itemCnt [:len $channelItems]
    
    :local randNum ([:rndnum from=1 to=1000])
    #:log info "Random number: $randNum"

    :local selectedValue 0
    :local weight (1000 / $itemCnt)

    :for i from=1 to=$itemCnt do={
        :if (($randNum >= ($weight * ($i-1))) and ($randNum <= ($weight * ($i)))) do={
            :set selectedValue ($channelItems->($i-1));   
            :break;
        }
    }

    :local currentChannel [/interface wifi get $ifaceBand5Ghz channel.frequency];
     #:log info "Current channel: $currentChannel, Selected channel: $selectedValue"

    :if ($currentChannel != $selectedValue) do={
        /interface wifi set $ifaceBand5Ghz channel.frequency=$selectedValue 
        #:log info [/interface wifi get $ifaceBand5Ghz channel.frequency];
    }

}