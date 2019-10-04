fly -t main login --team-name main --concourse-url http://concourse.rancher.boxboat.io
fly -t main set-pipeline --pipeline vault-setup -c ci/concourse.yaml
fly -t main unpause-pipeline -p vault-setup
fly -t main ep -p vault-setup