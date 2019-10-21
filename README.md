# docker-aws-dojo

[Dojo](https://github.com/kudulab/dojo) docker image with:
   * [awscli](https://github.com/aws/aws-cli)
   * [boto3](https://github.com/boto/boto3)
   * make
   * [saml2aws](https://github.com/Versent/saml2aws)
   * [aws-nuke](https://github.com/rebuy-de/aws-nuke)

Based on alpine docker image.

## Usage

1. [Install docker](https://docs.docker.com/install/), if you haven't already.
1. Install [Dojo](https://github.com/kudulab/dojo)
2. Install Dojo, it is a self-contained binary, so just place it somewhere on the `PATH`. **On OSX** you can use `brew install kudulab/homebrew-dojo-osx/dojo`.

**On Linux**
```bash
DOJO_VERSION=0.6.2
wget -O dojo https://github.com/kudulab/dojo/releases/download/${DOJO_VERSION}/dojo_linux_amd64
sudo mv dojo /usr/local/bin
sudo chmod +x /usr/local/bin/dojo
```

2. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/aws-dojo:0.3.0"
```
3. Enter a docker container by running `dojo`. Use the AWS CLI.


## License

Copyright 2019 Ewa Czechowska, Tomasz Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
