{
  :local shedulerDisabled [/system/scheduler get schedulerDroneSniffer disabled]
  #:log info $shedulerDisabled

  :local snifferJobsWifi24Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer2.4Ghz"]]
  #:log info $snifferJobsWifi24Ghz

  :if ($shedulerDisabled = true and $snifferJobsWifi24Ghz > 0) do={
        /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer2.4Ghz"]
        :log info "Stop scriptDroneSniffer2.4Ghz"
  }

  :local snifferJobsWifi5Ghz [:len [/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer5Ghz"]]
  #:log info $snifferJobsWifi5Ghz
  :if ($shedulerDisabled = true and $snifferJobsWifi5Ghz > 0) do={
        /system/script/job remove [find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSnifferMain/script:scriptDroneSniffer5Ghz"]
        :log info "Stop scriptDroneSniffer5Ghz"
  }

  :foreach i in=[/interface wifi find] do={
      :local ifaceName [/interface wifi get $i default-name];
      :local countryChannel [/interface wifi get $i configuration.country];
      :local ifaceComment [/interface wifi get $i comment];

      :if ($countryChannel = "Brazil" and $ifaceComment = "drone" and $shedulerDisabled = true) do={
            /interface wifi unset $ifaceName configuration.country 
      }
  }
}