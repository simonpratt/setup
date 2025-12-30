---
description: Write E2E tests in playwright for a feature or change
---

# Write E2E Tests

You are tasked with adding high-value E2E tests. You may optionally be provided with an approved technical plan from `thoughts/shared/plans/`. These plans contain phases with specific changes and success criteria.

## Getting Started

When given a plan path:
- Read the plan completely and check for any existing checkmarks (- [x])
- Read the original ticket and all files mentioned in the plan
- **Read files fully** - never use limit/offset parameters, you need complete context
- Think deeply about what functionality has been added and what e2e tests would be important to add
- Consider any unit-tests that have been added as part of the plan and avoid duplicating coverage too much
- Create a todo list to track your progress
- Start implementing if you understand what needs to be done

If no plan path provided, consider the user requirement that has been described and follow the same steps as if you had a plan.

Your work should be broken up into 3 distinct phases
1. Research
2. Planning
3. Implementation

## Research Philosophy

Use a **sub-agent** Research the codebase to identify test cases that are similar to the feature or change that we need to add tests for. This agent should return us a summary of tests not code. We want test names, files, and the outcome these tests are verifying.

## Planning Philosophy

Your job is to:
- Consider where we are up to in the plan. We want to write and verify tests for functionality that has been added
- Consider what tests we should add and what tests we should extend
- Consider which tests are critical, important, and nice to have
- Consider what should be done via the UI and what should be done via the API. We want to minimise UI usage and only use it when it's relevant to the outcome we're testing.
- Once you have planned out the best test coverage plan you should check-in with the user. Present the testing plan clearly
  ```
  Test #1
  Name: must xxx (new | existing)
  Priority: Critical | Important | Nice to have
  Type: UI | API
  File: <path-to-file> (new | existing)
  Summary:
    setup: create and login user
    setup: create a list
    act: add an item to the list
    assert: verify the item is on the list (API)
  ```

## Implementation Philosophy

Consider which tests the user has approved us to add. Your job is to add these tests
- Follow the test plans intent while adapting to what you find
- Verify your work makes sense in the broader codebase context

## Verification Approach

After implementing some tests we **need to verify them**
- Run the specific test files and test cases we have added
- If they fail we need to iterate by fixing the failing test case and running again
- Once all tests we have added are passing we need to run them 5x using `--repeat-each=5` to verify they are not flaky
- Once all tests we have added are verified as not flaky we need to run all tests in the suite to verify we haven't broken anything else. If you see failures that seem un-related they might be flaky; check-in with the user for these test cases

## If You Get Stuck

When something isn't working as expected:
- DO NOT go around in circles guessing
- First, consider what logging we can add to the test case to get more information
- Second, consider adding extra temporary API calls to verify the state of the application
- Second, consider what logging we can add to the application code to get more information. You will need to prompt the user to run the test manually and report back
