#!/bin/bash
## Bash to prepare the Tail -f deployment for the history file
# Create directory for the Persistent Volume
mkdir /pv-data/
# Adapt the access rights
chmod 755 -R /pv-data
# Identify the user
USER=$(whoami)
# Change ownership
chown $USER:$USER /pv-data
# Write in the history file after each command (dont keep in memory)
export PROMPT_COMMAND='history -a'
# Make hardlink
ln  ~/.bash_history /pv-data/history.log
# Set the public ip for the ingress rule.
export PUBLIC_IP=$(curl -s ifconfig.me) 
sed "s/PUBLIC_IP/$PUBLIC_IP/g" 05-frontail-ingress.template > 05-frontail-ingress.yaml
kubectl apply -f .