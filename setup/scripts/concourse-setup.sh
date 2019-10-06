fly -t main login --team-name main --concourse-url http://concourse.rancher.boxboat.io -u test -p test
fly -t main set-pipeline --pipeline vault-setup -c ci/pipeline.yml
fly -t main unpause-pipeline -p vault-setup
fly -t main ep -p vault-setup