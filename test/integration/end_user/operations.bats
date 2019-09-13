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
@test "correct aws version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"aws --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "aws-cli/1.16.238"
  assert_equal "$status" 0
}
@test "correct jq version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"jq --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "jq-1.5"
  assert_equal "$status" 0
}
