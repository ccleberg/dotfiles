BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

VPN=$(mullvad status 2>/dev/null | head -1 || echo "disconnected")
IP=$(mullvad status | rg -o '(\d{1,3}\.){3}\d{1,3}')

printf "\n"
printf "  ${BOLD}%s${RESET}      ${DIM}%s${RESET}\n" "$USER" "$(uname -sr)"
printf "  ${DIM}vpn      ${RESET}%s\n" "$VPN"
printf "  ${DIM}ip       ${RESET}%s\n" "$IP"
printf "\n"
