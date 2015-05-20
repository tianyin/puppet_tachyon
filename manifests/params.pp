class tachyon::params {    

    $version = $::hostname ? { 
        default => '0.6.4',
    }

    $tachyon_user = $::hostname ? {
        default => 'tianyin',
    }

    $tachyon_group = $::hostname ? {
        default => 'tianyin',
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
        default => 'localhost' 
    }

    $tachyon_ram_folder = $::hostname ? {
        default => '/mnt/tachyon/ramdisk'
    }

    $servers = $::hostname ? {
        default => ["test2.openstacklocal", "test3.openstacklocal", "test4.openstacklocal"]
    }

    $workers = join($servers, "\r\n")
}
