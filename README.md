## DevOps challenge

---

The task
--------

Automated setup of two Percona instances where one is a master
and the other a replica using my [puppet-percona](https://github.com/kjpopov/puppet-percona) module as a git submodule.

### Howto test

./test script will ssh to your master instance create a dummy random table and will show this table from the slave.


License
-------
Apache License Version 2.0, from January 2004 - http://www.apache.org/licenses/

Secial thanks to Honeypot GmbH for making this challane and reporting some bugs.
