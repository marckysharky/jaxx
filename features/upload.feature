Feature: As a CLI user I want to upload a file to S3

  Scenario: Show CLI help with -h
    When I run `jaxx-upload -h`
    Then the exit status should be 0
    And the output should contain "jaxx [options]"

  Scenario: Show CLI help with --help
    When I run `jaxx-upload --help`
    Then the exit status should be 0
    And the output should contain "jaxx [options]"

  Scenario: Uploading a single file with missing bucket
    When I run `jaxx-upload --bucket `
    Then the exit status should be 1
    And the output should contain "bucket is required"

  Scenario: Uploading a single file non-existing file
    When I run `jaxx-upload --file foo.txt`
    Then the exit status should be 1
    And the output should contain "file exists returned false"

  Scenario: Uploading a single file with missing file
    When I run `jaxx-upload --file`
    Then the exit status should be 1
    And the output should contain "file presence is required"

  Scenario: Downloading a single file with missing credentials
    When I run `jaxx-upload --bucket foo`
    Then the exit status should be 1
    And the output should contain "credentials for access key and access secret required"
