# DevOps challenge

---

The task
--------

Automate the setup of two Percona instances where one is a master
and the other a replica.

* Configuration Management scripts have to be tracked and delivered in form
of a private git repository to witch you should have or will receive
access shortly.

* The scripts should be covered with tests that verify the final working state
of both instances and preferably test the functionality in a more granular/unit level.

* Add a README file describing:
  - what the project does
  - what libraries, frameworks, tools are used and why
  - possible improvements eg. for performance, readibility, maintainability ...

* Contain the following **executables**:
  - `setup` - for fetching, installing the dependencies and other setup
    related tasks
  - `start` - for provisioning and starting the instances
  - `test` - for running the test suit

* The completed version should be marked with a git tag `v1.0.0`


License
-------

Copyright © 2015 Honeypot GmbH. All right reserved.


About Honeypot
--------------

![Honeypot](https://www.honeypot.io/logo.png)

Honeypot is a developer focused job platform.
The names and logos for Honeypot are trademarks of Honeypot GmbH.
