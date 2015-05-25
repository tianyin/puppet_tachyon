#Puppet module for deploying Tachyon memory-centric distributed storage system

The module is used for deploying Tachyon (http://tachyon-project.org/index.html), a memory-centric distributed storage system enabling reliable data sharing at memory-speed across cluster frameworks, such as Spark and MapReduce, from the Berkeley folks. 

Note that this module only deploys the software and help automatically update the master and workers by declaration. It does not include the commands for formatting filesystem and starting the master/workers, as Tachyon has already provided handy toolkits.

##Use the module

###Local deployment 
(http://tachyon-project.org/Running-Tachyon-Locally.html)
The default configuration is to run Tachyon locally. You can declare a tachyon class as follows,
```
include tachyon
```
or if you want to change the default configurations such as ```JAVA_HOME``` and tachyon ```user``` (checkout ```init.pp```)
```
class { 'tachyon':
        java_home => '/usr/lib/jvm/java-1.7.0-openjdk-amd64',
        user      => 'tachyon'
    }
```

###Cluster deployment 
(http://tachyon-project.org/Running-Tachyon-on-a-Cluster.html)
To run Tachyon on a cluster, you need to tell the tachyon class the master's address and the workers' addresses as follows (in local mode, they are set to ```localhost```),
```
class { 'tachyon':
        master_address => 'master.ip.address',
        workers        => ['worker1.ip.address', 'worker2.ip.address']
    }
```

##Use Tachyon
Check the Tachyon website (http://tachyon-project.org/) for more details. 
Basically, you only need to go to the master node and issue the following commands
```
$ ./bin/tachyon format
$ ./bin/tachyon-start.sh # use the right parameters here (e.g. all Mount)
```

