#!/bin/bash
echo "Usage: sh check-whackapod-service.sh "
echo "Press [CTRL+C] to stop.."
PUBLIC_IP=$(curl -s ifconfig.me)

url="http://whackapod.$PUBLIC_IP.xip.io/api/"

contentType="Content-Type: application/json"
dtHeaderGet="x-dynatrace-test: LSN=check-whackapod-service.sh;LTN=CheckService;TSN=Check health of service;"

endless_check(){
  echo -e "\nChecking the health of the WackAPoD Service\n"
  while true
  do
    # Endless loop
    check_svc
    sleep 1
  done
}
# Do a URL Check with a timeut of 500
check_svc(){
  printf "Check: $url :"
  curl -X GET -H "$contentType" -H "$dtHeaderGet" $url --connect-timeout 0.5
}
endless_check