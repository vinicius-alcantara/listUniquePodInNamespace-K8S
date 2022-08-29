#!/bin/bash

for NAMESPACE in $(cat namespaces-uniq.txt);
do

  POD_NAME=$(kubectl get po -n "$NAMESPACE" | egrep -i "production" | cut -d " " -f1);
  
  CPU_LIMIT=$(kubectl describe po "$POD_NAME" -n "$NAMESPACE" | egrep -i "cpu" | head -n1 | cut -d ":" -f2 | sed 's/ //g');
  MEM_LIMIT=$(kubectl describe po "$POD_NAME" -n "$NAMESPACE" | egrep -i "mem" | head -n1 | cut -d ":" -f2 | sed 's/ //g');

  echo "NAMESPACE: $NAMESPACE PODNAME: $POD_NAME" CPU_LIMIT: "$CPU_LIMIT" MEM_LIMIT: "$MEM_LIMIT" | tee -a report-uniq-pod-apps.txt;

done
