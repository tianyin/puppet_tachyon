class tachyon::params {    

    $version = $::hostname ? { 
        default => '0.6.4',
    }

    $tachyon_user = $::hostname ? {
        default => 'cse223_tixu',
    }

    $tachyon_group = $::hostname ? {
        default => 'root',
    }

    $java_home = $::hostname ? {
        default => '/usr/lib/jvm/java-1.7.0-openjdk-amd64',
    }

    $tachyon_base = $::hostname ? {
        default => '/mnt/tachyon',
    }

    $tachyon_underfs_address = $::hostname ? {
        default => '/mnt/tachyon/underfs',
    }

    $tachyon_master_address = $::hostname ? {
        default => 'ccied8.sysnet.ucsd.edu' 
    }

    $tachyon_ram_folder = $::hostname ? {
        default => '/mnt/tachyon/ramdisk'
    }

    $servers = $::hostname ? {
        default => ["ccied6.sysnet.ucsd.edu", 
                    "ccied8.sysnet.ucsd.edu",
                    "ccied9.sysnet.ucsd.edu"
                   ]
    }

    $workers = join($servers, "\r\n")
}
