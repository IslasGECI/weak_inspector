Describe 'helper.sh'
  Include src/helper.sh
  Include src/notify_healthchecks.sh

  Mock curl
    echo "curl $@"
  End

  It 'notifies healtchecks with uuid and message'
    When call notify_healthchecks uuid mensaje
    The stdout should eq "curl --data-raw mensaje --fail --max-time 10 --output /dev/null --retry 5 --show-error --silent https://hc-ping.com/uuid"
  End

  Mock git
    echo "git $@"
    mkdir --parents repository
  End

  It 'pull_repository when repository already exists'
    mkdir --parents repository # Setup
    When call pull_repository repository branch
    The lines of stdout should equal 2
    The first line of output should equal "git checkout branch"
    The line 2 of output should equal "git pull"
  End

  It 'pull_repository when repository does not exist'
    rm --recursive repository # Setup
    When call pull_repository repository branch
    The lines of stdout should equal 3
    The first line of output should equal "git clone git@bitbucket.org:IslasGECI/repository.git"
    The line 3 of output should equal "git pull"
  End

  It 'test_and_make_all_by_repository'
    When call test_and_make_all_by_repository repositorio iduu
    The line 2 of output should equal "========================================"
    The line 3 of output should equal "Repository: repositorio"
    The line 4 of output should equal "UUID: iduu"
    The stderr should be present
  End
End
