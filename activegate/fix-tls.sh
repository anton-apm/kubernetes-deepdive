
#!/bin/bash

# We copy the custom.properties to the default path.
printf "copying custom.properties file to /var/lib/dynatrace/gateway/config/custom.properties"
cp custom.properties /var/lib/dynatrace/gateway/config/custom.properties
printf "restarting dynatrace gateway.."
# We restart the service
service dynatracegateway restart
printf "done restarting dynatrace"