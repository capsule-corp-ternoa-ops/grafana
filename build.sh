#!/bin/bash

if [[ -z "${GRAFANA_VERSION}" ]]; then
  echo "No GRAFANA_VERSION environment variable set"
  exit 1
fi

wget "https://dl.grafana.com/enterprise/release/grafana-enterprise-${GRAFANA_VERSION}.linux-amd64.tar.gz"
tar xvzf grafana-enterprise-${GRAFANA_VERSION}.linux-amd64.tar.gz
