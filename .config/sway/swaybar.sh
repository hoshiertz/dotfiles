datetime=$(date +'%Y-%m-%d %I:%M %p')

uptime=$(uptime -p)

uname=$(uname -rs)

bat_percent=$(cat /sys/class/power_supply/BAT1/capacity)

bat_status=$(cat /sys/class/power_supply/BAT1/status)

adp_status=$(cat /sys/class/power_supply/ADP1/online)

if [ $adp_status == 1 ];then
  adp_online='AC connected'
else
  adp_online='AC disconnected'
fi

cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{print $1"%"}')

echo CPU: $cpu' | 'GPU: $gpu' | 'Battery: $bat_percent% [$bat_status / $adp_online]' | '$uname' | '${uptime#* }' | '$datetime
