class tachyon::params {    

    $version = $::hostname ? { 
        default => '0.6.4',
    }

    $tachyon_user = $::hostname ? {
        default => 'tachyon',
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
        #default => 'hdfs://localhost:9000'
        default => '/mnt/tachyon/underfs',
    }

    $tachyon_master_address = $::hostname ? {
        default => 'localhost' 
    }

    $tachyon_ram_folder = $::hostname ? {
        default => '/mnt/tachyon/ramdisk'
    }

    $servers = $::hostname ? {
        default => ['localhost']
    }

    $workers = join($servers, "\r\n")

    $download_link = $::hostname ? {
        default => "https://github.com/amplab/tachyon/releases/download/v${tachyon::params::version}/tachyon-${tachyon::params::version}-bin.tar.gz"
    }
}
