## The Jenkins Status Tool
Small tool to get the build status from Jenkins.
Useful for embedding Jenkins CI status images on your Github project.


## API
<table border=1>
	<thead align=left>
		<th>Method</th>
		<th>Action</th>
		<th>Info</th>
		<th>Examples</th>
	</thead>
	<tbody>
		<tr>
			<td align=center><b>GET</b></td>
			<td>/project/:project_id/status.json</td>
			<td>Get project status json string</td>
			<td>
				{"status":"pass"}<br/>
				{"status":"fail"}<br/>
				{"status":"unknown"}
			</td>
			
		</tr>

			<tr>
				<td align=center><b>GET</b></td>
				<td>/project/:project_id/status.png</td>
				<td>Get project status image</td>
				<td>
					<img src="https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/pass.png"><br/>
					<img src="https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/fail.png"><br/>
					<img src="https://github.com/kontera-technologies/jenkins-status-tool/raw/master/public/images/unknown.png">					
				</td>
			</tr>
			
			<tr>
				<td align=center><b>GET</b></td>
				<td>/project/:project_id/rcov.png</td>
				<td>Get project rcov graph image</td>
				<td>
					<img src="https://github.com/kontera-technologies/jenkins-status-tool/raw/master/readme-files/rcov.png"><br/>
				</td>
				
			</tr>
			

		</tbody>
</table>


## Installation 
currently available only via source

```bash
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
    -s, --https                      use this if running behind https forwarder (e.g stunnel)

More Info:
https://github.com/kontera-technologies/jenkins-status-tool

```

## Example
lets say that our Jenkins server is running on ```jenkins-server:1234```

```
[root@far-far-away] jenkins-status-tool --jenkins jenkins-server:1234 --port 5555 --daemonize
[root@far-far-away] curl http://localhost:5555/project/my-project/status.json
{"status":"pass"}
[root@far-far-away] wget http://localhost:5555/project/my-project/status.png
[...SHOULD DOWNLOAD ONE OF THE IMAGES ABOVE...]
``` 

## Embed it
you can easily embed the current status of your builds in any html type document.

TextLite

```bash
"!https://jenkins-status-tool-url/projects/PROJECT-NAME/status.png!":http://jenkins.example.com/jobs/PROJET-NAME
```

RDoc

```bash
{<img src="https://jenkins-status-tool-url/projects/PROJECT-NAME/status.png" />}[http://jenkins.example.com/jobs/PROJET-NAME]
```

MarkDown

```bash
[![Build Status](https://jenkins-status-tool-url/projects/PROJECT-NAME/status.png)](http://jenkins.example.com/jobs/PROJET-NAME)
```

>
> **The tunnel...** 
> We used STunnel to route jenkins-status-tool-url:443 <=> jenkins-status-tool-url:5555
> This allow us to fetch the status images using https.

## Credits
* Status images by [travis-ci](https://github.com/travis-ci/travis-ci)
