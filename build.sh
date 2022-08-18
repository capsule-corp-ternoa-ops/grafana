#!/bin/bash
set -e
set -x

get_latest_release() {
  curl --silent "https://api.github.com/repos/grafana/grafana/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
version=$(get_latest_release)
GRAFANA_VERSION="${version:1}"
wget https://dl.grafana.com/oss/release/grafana-$GRAFANA_VERSION.linux-amd64.tar.gz
tar xvzf grafana-$GRAFANA_VERSION.linux-amd64.tar.gz
sleep 30
export GF_PATHS_PLUGINS=$APP_HOME/grafana-$GRAFANA_VERSION/data/plugins
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install ovh-warp10-datasource
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install vonage-status-panel
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-polystat-panel
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-piechart-panel
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-image-renderer
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-github-datasource
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install marcusolsson-json-datasource
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install redis-datasource
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-worldmap-panel

grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install marcusolsson-calendar-panel
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install cloudflare-app
grafana-$GRAFANA_VERSION/bin/grafana-cli --pluginsDir grafana-$GRAFANA_VERSION/data/plugins plugins install grafana-mongodb-datasource
