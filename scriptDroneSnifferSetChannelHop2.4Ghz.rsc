{
    :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]
    
    :local channelItems {"2412";"2432";"2437";"2452";"2472"};
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

    :local currentChannel [/interface wifi get $ifaceBand2Ghz channel.frequency];
    #:log info "Current channel: $currentChannel, Selected channel: $selectedValue"

    :if ($currentChannel != $selectedValue) do={
        /interface wifi set $ifaceBand2Ghz channel.frequency=$selectedValue 
        #:log info [/interface wifi get $ifaceBand2Ghz channel.frequency];
    }

}