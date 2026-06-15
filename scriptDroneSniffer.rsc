{
  :local ifaceBand2Ghz [/interface/wifi/radio get [find bands~"2ghz"] interface]
  :local ifaceBand5Ghz [/interface/wifi/radio get [find bands~"5ghz"] interface]

  :foreach i in=[/interface wifi find] do={

      :local ifaceName [/interface wifi get $i default-name];
      :local ifaceComment [/interface wifi get $i comment];
      #:log info "Interface: $ifaceName, Comment: $ifaceComment" 

      :if ($ifaceName = $ifaceBand2Ghz) do={
          :local snifferJobsWifi24Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSniffer/script:scriptDroneSniffer2.4Ghz"]]
          #:log info "Number of current wifisniffer 2.4Ghz command jobs: $snifferJobsWifi24Ghz"

          :if ($ifaceComment = "drone" && $snifferJobsWifi24Ghz > 0) do={
              #:log info "wifisniffer command already running"

              /system script run "DroneSnifferSetChannel2.4Ghz"

              
          }

          :if ($ifaceComment = "drone" && $snifferJobsWifi24Ghz = 0) do={
              :log info "wifisniffer 2.4Ghz command start"
                /system script run "scriptDroneSniffer2.4Ghz"
          }

          :if ($ifaceComment != "drone" && $snifferJobsWifi24Ghz > 0) do={
             :log info "Removing wifisniffer 2.4Ghz command job"
             /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSniffer/script:scriptDroneSniffer2.4Ghz"]
          }

          :if ($ifaceComment != "drone" && $snifferJobsWifi24Ghz = 0) do={
              #:log info "wifisniffer 2.4Ghz command not running"
          } 
        }

      :if ($ifaceName = $ifaceBand5Ghz) do={
          :local snifferJobsWifi5Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSniffer/script:scriptDroneSniffer5Ghz"]]
          #:log info "Number of current wifisniffer 5Ghz command jobs: $snifferJobsWifi5Ghz"

          :if ($ifaceComment = "drone" && $snifferJobsWifi5Ghz > 0) do={
              #:log info "wifisniffer command already running"

              /system script run "DroneSnifferSetChannel5Ghz"
          }

          :if ($ifaceComment = "drone" && $snifferJobsWifi5Ghz = 0) do={
              :log info "wifisniffer 5Ghz command start"
              /system script run "scriptDroneSniffer5Ghz"
          } 

          :if ($ifaceComment != "drone" && $snifferJobsWifi5Ghz > 0) do={
              :log info "Removing wifisniffer 5Ghz command job"
              /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSniffer/script:scriptDroneSniffer5Ghz"]
          }

          :if ($ifaceComment != "drone" && $snifferJobsWifi5Ghz = 0) do={
              #:log info "wifisniffer 5Ghz command not running"
          } 
      }
  
  }
}