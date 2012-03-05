## Jenkins Status Tools
Small tool to get the build status from Jenkins.

## Installation 
currently available only via source
```
[root@far-far-away] git clone git@github.com:kontera-technologies/jenkins-status-tool.git
[root@far-far-away] bundle install
[root@far-far-away] bundle exec rake install
```

## Usage
after installing the gem, the `jenkins-status-tool` command should be available

```bash
[root@far-far-away] jenkins-status-tool --help

The Jenkins Status Tool
Usage: jenkins-status-tool [options]

Options:
    -j, --jenkins URL                Jenkins url, e.g http://jenkins:8080, default is localhost
    -p, --port URL                   listening port, default is 7676
    -d, --daemonize                  run in background
    -P, --pid-file FILE              pid file, default /var/run/jenkins-status-tool.pid

More Info:
https://github.com/kontera-technologies/jenkins-status-tool

```

## API
* get "/" => list available commands

![DASH](https://github.com/kontera-technologies/jenkins-status-tool/raw/master/readme-files/dash.png)

* get "/project/:project-name/status.png" => return project status as image (images taken from [travis-ci](https://github.com/travis-ci/travis-ci))

![fail](https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/fail.png)

![pass](https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/pass.png)

![unknown](https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/unknown.png)

* get "/project/:project-name/status.json"
returns project status as json, e.g {"status":"pass"}

## Example
lets say that our Jenkins server running on server called ```jenkins-server``` and it's listening on port 1234.

```
[root@far-far-away] jenkins-status-tool --jenkins jenkins-server:1234 --port 5555 --daemonize
[root@far-far-away] curl http://localhost:5555/project/config-server/status.json
{"status":"pass"}
[root@far-far-away] wget http://localhost:5555/project/config-server/status.png
[...SHOULD DOWNLOAD ONE OF THE IMAGES ABOVE...]
``` 


## Credits
* CI Build images by [travis-ci](https://github.com/travis-ci/travis-ci)

