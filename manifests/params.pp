class tachyon::params {    
    $version = $::hostname ? { 
        default => '0.6.4',
    }

    $tachyon_underfs_address = $::hostname ? {
        default => '/mnt/tachyon',
    }

    $java_home = $::hostname ? {
        default => '/usr/lib/jvm/java-1.7.0-openjdk-amd64',
    }

    $servers = $::hostname ? {
        default => ["test2.openstacklocal", "test3.openstacklocal", "test4.openstacklocal"]
    }

    file { '/mnt/tachyon-0.6.4/conf/workers2' :
        content => join($servers, "\r\n"),
    }
}
