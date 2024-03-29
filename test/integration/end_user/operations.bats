load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "dojo init finished"
  assert_line --partial "/dojo/work"
  assert_line --partial "aws-dojo"
  refute_output --partial "IMAGE_VERSION"
  refute_output --partial "root"
  assert_equal "$status" 0
}
@test "correct awscli version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"aws --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "aws-cli/2.4.19"
  assert_equal "$status" 0
}
@test "awscli help can be requested" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"aws help\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "The  AWS  Command  Line  Interface"
  assert_equal "$status" 0
}
@test "saml2aws is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"saml2aws --help\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "usage: saml2aws"
  assert_equal "$status" 0
}
@test "correct ecs-cli version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"ecs-cli --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "1.20.0"
  assert_equal "$status" 0
}
@test "aws-nuke is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"aws-nuke --help\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "A tool which removes every resource from an AWS account"
  assert_equal "$status" 0
}
@test "make is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"make --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "GNU Make"
  assert_equal "$status" 0
}
@test "correct jq version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"jq --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "jq-1.5"
  assert_equal "$status" 0
}
@test "correct boto3 version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"pip list | grep boto3\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "1.21.3"
  assert_equal "$status" 0
}
@test "aws config directory is copied into dojo home" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cat /home/dojo/.aws/config\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "region"
  assert_equal "$status" 0
}
@test "boto3 uses aws config" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"python3 main.py\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Current region is: eu-west-1"
  assert_equal "$status" 0
}
