# docker-aws-dojo

[Dojo](https://github.com/kudulab/dojo) docker image with:
   * [awscli](https://github.com/aws/aws-cli)
   * [boto3](https://github.com/boto/boto3)
   * make
   * [saml2aws](https://github.com/Versent/saml2aws)
   * [aws-nuke](https://github.com/rebuy-de/aws-nuke)
   * ecs-cli

Based on alpine docker image.

## Usage

1. Install [Dojo](https://github.com/kudulab/dojo/#installation)
2. Provide a Dojofile:
```
$ cat Dojofile
DOJO_DOCKER_IMAGE="kudulab/aws-dojo:0.7.0"
```
3. Enter a docker container by running `dojo` in the same directory as Dojofile.
4. Example commands to run inside the Dojo created container:
```
aws --version
aws ec2 describe-instances --filters "Name=tag:Name,Values=ec2-ansible-test"
```

## Configuration
If the directory `$HOME/.aws` exists locally, then it will be read-only mounted into a Dojo Docker container. This is how we can provide AWS credentials to the Dojo Docker container.

## Contributing
Instructions how to update this project.

1. Create a new feature branch from the main branch: master
1. Work on your changes in that feature branch. If you want, describe you changes in [CHANGELOG.md](CHANGELOG.md)
1. Build your image locally to check that it succeeds: `./tasks build_local`
1. Test your image: `./tasks itest`
1. If you are happy with the results, create a PR from your feature branch to master branch
1. Someone will read your PR, merge it and ensure version bump (using `./tasks set_version`)
1. CI pipeline will run to automatically build and test docker image, release the project and publish the docker image.

## License

Copyright 2019-2022 Ewa Czechowska, Tomasz Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
