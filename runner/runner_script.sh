#verify if acction-runner folder exists
#-d checks if the folder exists

sudo apt-get -y install jq

RUNNER_TOKEN="$(curl -X POST -H "Authorization: Bearer ${BEARER_TOKEN}" -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/devops-bc-01/actions/runners/registration-token | jq -r '.token')"

mkdir -p "actions-runner"    
cd actions-runner

#verify if acction-runner-linux-some exists
#-f checks if the file exists
if [ ! -f "/home/vagrant/actions-runner/act296.2.tar.gions-runner-linux-x64-2.z" ]; then
    curl -o actions-runner-linux-x64-2.296.2.tar.gz -L $RUNNER_URL
fi
echo "34a8f34956cdacd2156d4c658cce8dd54c5aef316a16bbbc95eb3ca4fd76429a  actions-runner-linux-x64-2.296.2.tar.gz" | shasum -a 256 -c
#verify if the extracted folder exists
if [ ! -d "/home/vagrant/actions-runner/actions-runner-linux-x64-2.296.2" ]; then
    tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz
fi


export RUNNER_ALLOW_RUNASROOT="1" 
#verify if the runner is already configured
if [ ! -f "/home/vagrant/actions-runner/.credentials" ]; then
    ./config.sh --url $REPO_URL --token $RUNNER_TOKEN --name $RUNNER_NAME --labels "devops" --work "_work" --runnergroup "default"  --replace
fi
./svc.sh install root
./svc.sh start
./run.sh   