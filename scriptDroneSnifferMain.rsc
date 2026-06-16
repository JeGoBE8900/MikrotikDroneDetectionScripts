{
  #variables to configure
  :local channelHop 0

  #end variables to configure
  
  :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]
  :local ifaceBand5Ghz [/interface/wifi/radio get [find bands~"5ghz"] interface]

  :foreach i in=[/interface wifi find] do={

      :local ifaceName [/interface wifi get $i default-name];
      :local ifaceComment [/interface wifi get $i comment];
      :local ifaceManager [/interface wifi get $i configuration.manager];
      :local ifaceMode [/interface wifi get $i configuration.mode]

      #:log info "Interface: $ifaceName, Comment: $ifaceComment" 

      :if ($ifaceName = $ifaceBand2Ghz ) do={
          :local snifferJobsWifi24Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer2.4Ghz"]]
          #:log info "Number of current wifisniffer 2.4Ghz command jobs: $snifferJobsWifi24Ghz"

          :if ($ifaceComment = "drone" && $snifferJobsWifi24Ghz > 0 && $ifaceManager = "local" && $ifaceMode = "ap") do={
              #:log info "wifisniffer command already running"

              :if ($channelHop = 1 || $channelHop = true || $channelHop = "true") do={
                    /system script run "scriptDroneSnifferSetChannelHop2.4Ghz"
              } else={
                    /system script run "scriptDroneSnifferSetChannelFixed2.4Ghz"
              }
              
          }

          :if ($ifaceComment = "drone" && $snifferJobsWifi24Ghz = 0 && $ifaceManager = "local" && $ifaceMode = "ap") do={
               :log info "wifisniffer command start"
                /system script run "scriptDroneSniffer2.4Ghz"
          }

          :if (($ifaceComment != "drone" or $ifaceManager != "local" or $ifaceMode != "ap") && $snifferJobsWifi24Ghz > 0) do={
                :log info "Removing wifisniffer 2.4Ghz command job"
                /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer2.4Ghz"]
          }

        }

      :if ($ifaceName = $ifaceBand5Ghz) do={
          :local snifferJobsWifi5Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer5Ghz"]]
          #:log info "Number of current wifisniffer 5Ghz command jobs: $snifferJobsWifi5Ghz"

          :if ($ifaceComment = "drone" && $snifferJobsWifi5Ghz > 0 && $ifaceManager = "local" && $ifaceMode = "ap") do={
              #:log info "wifisniffer command already running"

                :if ($channelHop = 1 || $channelHop = true || $channelHop = "true") do={
                    /system script run "scriptDroneSnifferSetChannelHop5Ghz"
                } else={
                    /system script run "scriptDroneSnifferSetChannelFixed5Ghz"
                }
          }

          :if ($ifaceComment = "drone" && $snifferJobsWifi5Ghz = 0 && $ifaceManager = "local" && $ifaceMode = "ap") do={
               :log info "wifisniffer command start"
                /system script run "scriptDroneSniffer5Ghz"
          } 

          :if (($ifaceComment != "drone" or $ifaceManager != "local" or $ifaceMode != "ap") && $snifferJobsWifi5Ghz > 0) do={
              :log info "Removing wifisniffer 5Ghz command job"
              /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer5Ghz"]
          }

      }
  
  }
}