
#!/bin/bash

# We copy the custom.properties to the default path.
cp custom.properties /var/lib/dynatrace/gateway/config/custom.properties

# We restart the service
service dynatracegateway restart