Feature: About Me

  Scenario:
    When I run `jaxx-aboutme -h`
    Then the exit status should be 0
    And the output should contain "jaxx-aboutme [options]"
