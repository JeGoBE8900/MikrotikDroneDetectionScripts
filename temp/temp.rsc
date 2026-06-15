

#:log info [/interface wifi get $i comment];

#:put [interface wifi find where comment ~"^sniffer"];
:put [/system script job get [find where owner~"wifisniffer"] id]
:put [/system script job find  owner=wifisniffer type=command] 
:put [[/system script job find where trace~"scheduler:schedulerDroneSniffer/script:scriptDroneSniffer"]]


:put [/interface/wifi/radio get [find bands~"2ghz"] interface]
:put [/interface/wifi/radio get [find bands~"5ghz"] interface]




# Check for newer wifi (wifiwave2) interfaces configuration.mode,
:foreach i in=[/interface wifi find] do={
    :local ifaceName [/interface wifi get $i name];
    :local ifaceConfigMode [/interface wifi get $i configuration.mode];
    :local ifaceConfigMode [/interface wifi get $i configuration.manager];
    :local ifaceConfigMode [/interface wifi get $i channel.frequency];


    :log info [/interface wifi get $i name];
    :log info [/interface wifi get $i configuration.mode];
    :log info [/interface wifi get $i configuration.manager];
    :log info [/interface wifi get $i channel.frequency];
    :log info [/interface wifi get $i about];
}


/interface/wifi sniffer wifi1 duration=0 stream-rate=4294967295 stream-address=192.168.10.32

:execute {/interface/wifi sniffer wifi1 duration=0 stream-rate=4294967295 stream-address=192.168.10.32}
 /system/script/job/print detail 
 /system/script/job/remove 2


