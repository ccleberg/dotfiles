BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

HOST=$(scutil --get ComputerName 2>/dev/null || hostname)

IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
IP=${IP:-unavailable}

SSID=$(networksetup -getairportnetwork en0 2>/dev/null | sed 's/^Current Wi-Fi Network: //')
case "$SSID" in
  ""|"You are not associated with an AirPort network.")
    SSID="unavailable"
    ;;
esac

BATTERY=$(pmset -g batt 2>/dev/null | awk -F'; *' '
  NR==2 {
    gsub(/^ +| +$/, "", $2)
    gsub(/^ +| +$/, "", $3)
    sub(/ present: true$/, "", $3)
    print $2 ", " $3
  }
')
BATTERY=${BATTERY:-unavailable}

UPTIME=$(uptime | sed 's/^.*up //; s/, [0-9]* user.*//; s/, load averages.*//')
UPTIME=${UPTIME:-unavailable}

if profiles status -type enrollment 2>/dev/null | grep -qi "MDM enrollment: Yes"; then
  MANAGED="yes"
else
  MANAGED="no"
fi

VPN="unavailable"

if command -v mullvad >/dev/null 2>&1; then
  STATUS=$(mullvad status 2>/dev/null)
  VPN=$(printf '%s\n' "$STATUS" | head -1)
  VPN=${VPN:-unavailable}
fi

printf "\n"
printf "  ${BOLD}%s${RESET}      ${DIM}%s${RESET}\n" "$USER" "$(uname -sr)"
printf "  ${DIM}%-14s${RESET}%s\n" "host" "$HOST"
printf "  ${DIM}%-14s${RESET}%s\n" "managed" "$MANAGED"
printf "  ${DIM}%-14s${RESET}%s\n" "wifi" "$SSID"
printf "  ${DIM}%-14s${RESET}%s\n" "ip" "$IP"
printf "  ${DIM}%-14s${RESET}%s\n" "mullvad" "$VPN"
printf "  ${DIM}%-14s${RESET}%s\n" "battery" "$BATTERY"
printf "  ${DIM}%-14s${RESET}%s\n" "uptime" "$UPTIME"
printf "\n"

