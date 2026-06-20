{
    :local channel6Weight 75;
    :local finalChance  0;
    
    #:local channelItems ({"2412";"2417";"2422";"2427";"2432";"2437";"2442";"2447";"2452";"2457";"2462";"2467"});
    #:local channelWeights ({((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); $channel6Weight; ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11);((100-$channel6Weight)/11);});

    :local channelItems ({"2412";"2417";"2422";"2427";"2432";"2437";"2442";"2447";"2452";"2457";"2462";"2467"});
    :local channelWeights ({((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); $channel6Weight; ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11);((100-$channel6Weight)/11);});

    :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]

    #calculate total weight
    :local totalWeight 0;
    :foreach weight in=$channelWeights do={
        :set totalWeight ($totalWeight + $weight);
    }

    #choose random number between 1 and total weight
    :local randNum [:rndnum from=1 to=$totalWeight];

    :local selectedValue "Unknown";
    :local currentThreshold 0;

    :for i from=0 to=([:len $channelItems]) do={
        :local weight ($channelWeights->$i);
        :set currentThreshold ($currentThreshold + $weight);
        
        :if ($randNum < $currentThreshold) do={
            :set selectedValue ($channelItems->$i);
            :set finalChance (($weight * 100) / $totalWeight);
            
            # Output the result
   
            :break;
        }
    }

    #:log info "Rolled: $selectedValue (Weight: $weight, Probability: $finalChance %)";
    :local currentChannel [/interface wifi get $ifaceBand2Ghz channel.frequency];

    :if ($currentChannel != $selectedValue && "Unknown" != $selectedValue) do={
        #:log info "Rolled: $selectedValue (Weight: $weight, Probability: $finalChance %)";
        /interface wifi set $ifaceBand2Ghz channel.frequency=$selectedValue 
        #:log info [/interface wifi get $ifaceBand2Ghz channel.frequency];
    }
}