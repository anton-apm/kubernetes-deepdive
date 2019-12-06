kubectl create serviceaccount wap-admin	
kubectl create clusterrolebinding wap-admin --clusterrole=cluster-admin --serviceaccount=$$(kubectl config view -o jsonpath="{.contexts[?(@.name==\"$$(kubectl config current-context)\")].context.namespace}"):wap-admin
kubectl set serviceaccount deployment admin-deployment wap-admin
