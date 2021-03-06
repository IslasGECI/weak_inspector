Describe 'geci-maketests.sh'

  BeforeAll 'mkdir --parents isla-guadalupe'

  Mock curl
    echo "curl $@"
  End

  Mock git
    echo "git $@"
  End

  Mock docker
    echo "docker $@"
  End

  It 'Notifies healtchecks.io'
    output="curl --data-raw tests@isla-guadalupe:latest --fail --max-time 10 --output /dev/null --retry 5 --show-error --silent https://hc-ping.com/4fd77125-7f38-4996-b1e8-bbd337b338"
    When call src/geci-maketests.sh isla-guadalupe 4fd77125-7f38-4996-b1e8-bbd337b338
    The lines of stdout should equal 6
    The first line of output should equal "${output}/start"
    The line 6 of output should equal "${output}"
  End
End
