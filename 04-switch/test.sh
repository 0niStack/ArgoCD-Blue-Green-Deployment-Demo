#!/usr/bin/env bash
# Shows what live traffic (svc/demo) currently serves
kubectl -n bluegreen port-forward svc/demo 8081:80 >/dev/null 2>&1 &
PF=$!; sleep 2
curl -s localhost:8081 | grep -o '<h1>[A-Z]*</h1>\|Served by [A-Za-z ]*' || true
kill $PF
