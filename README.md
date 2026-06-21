# Mikrotik RouterOS DroneDetection Scripts
Mikrotik RouterOS scripts, to snif wifi packets for Drones and forward them to droneaware.io node device

Tested with 7.23, 7.24 beta & 7.25 alpha

Proof of concept, current findings:
- EU/US Regularity differences (Set country to Brazil)
- Cant change frequencies while sniffing
- Stream address only IP address, no port options. So streaming to different Virtual WLAN devices isnt possible.
