Feature: As a CLI user I want to download a file from S3

  Scenario: Show CLI help with -h
    When I run `jaxx-download -h`
    Then the exit status should be 0
    And the output should contain "jaxx [options]"

  Scenario: Show CLI help with --help
    When I run `jaxx-download --help`
    Then the exit status should be 0
    And the output should contain "jaxx [options]"

  Scenario: Downloading a single file with missing bucket
    When I run `jaxx-download --bucket `
    Then the exit status should be 1
    And the output should contain "bucket is required"

  Scenario: Downloading a single file with missing credentials
    When I run `jaxx-download --bucket foo`
    Then the exit status should be 1
    And the output should contain "credentials for access key and access secret required"

  Scenario: Downloading a single file with missing file argument
    When I run `jaxx-download --bucket foo`
    Then the exit status should be 1
    And the output should contain "file presence is required"
