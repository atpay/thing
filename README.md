Thing
=====

Simple distributed testing server

Client implementation is up to the user.  Below is a description of the server API and behavior.

## API

Thing tries to be as simple as possible.  There are a few exposed methods that should let you do everything you need.  If not fork, fix and request.

### start_run

When you first start a test run you should call this method.  It expects a run id and a suite name.  The run id is simply an index that keeps the data for this test run separate from any others that may be executing at the same time.  The suite name is a little different.  Currently that identifies a yml file in the thing/suites directory.  

This file should be in the format of: 

```yaml
test_name: 2
other_test: 12
```

Basically the keys should be some kind of name your client understands and the value is simply the number of times the test is to be executed during the run.

### launch_test

Once you have setup a test run you need to call launch_test for each actual test case.  launch_test expects a two element array the first element should be the run identifier the second element should be something identifying the actual test execution.  launch_test will return the name of the test to be run as specified in your suite file.  Once the suite is finished launch_test will return nil.

### end_test

When your test case has finished you should call end_test.  end_test takes the same two element array as launch_test as well as a hash of results namely the outcome and test {outcome: 'victory', test: 'never fail'}

### end_run

When you are finished you should call end_run with the test run id.  This closes the data file and cleans up the "state tree" for the test run.