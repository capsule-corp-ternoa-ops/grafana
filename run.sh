#!/bin/bash


get_latest_release() {
  curl --silent "https://api.github.com/repos/grafana/grafana/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
version=$(get_latest_release)
GRAFANA_VERSION="${version:1}"

export GF_PATHS_PLUGINS=$APP_HOME/grafana-$GRAFANA_VERSION/data/plugins
grafana-$GRAFANA_VERSION/bin/grafana-server -homepath grafana-$GRAFANA_VERSION
