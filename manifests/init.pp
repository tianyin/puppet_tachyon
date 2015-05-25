class tachyon (
    $version         = $tachyon::params::version,
    $java_home       = $tachyon::params::java_home,
    $user            = $tachyon::params::tachyon_user,
    $group           = $tachyon::params::tachyon_group,
    $basedir         = $tachyon::params::tachyon_base,
    $download_link   = $tachyon::params::download_link,
    $workers         = $tachyon::params::workers,
    $underfs_address = $tachyon::params::tachyon_underfs_address,
    $master_address  = $tachyon::params::tachyon_master_address,
    $ram_folder      = $tachyon::params::tachyon_ram_folder 
    ) {
    
    require tachyon::params

    group { "$group":
        ensure => present,
    }

    user { "$user":
        ensure  => present,
        shell   => "/bin/bash",
        require => Group["$group"],
    }

    #package { "openjdk-7-jdk":
    #    ensure => installed,
    #}

    package { "wget":
        ensure => installed,
    }
 
    #base directory
    file { "$basedir":
        alias    => "tachyon-base",
        owner    => "$user",
        group    => "$group",
        ensure   => directory,
        require  => [ User["$user"], Group["$group"] ]
    }

    #install directory
    #file { "$basedir/tachyon-$version":
    #    alias    => "tachyon-install",
    #    owner    => "$user",
    #    group    => "$group",
    #    ensure   => directory,
    #    require  => [ User["$user"], Group["$group"] ]
    #}
 
    #download from the official tarball
    exec { "download tachyon":
        alias    => "download-tachyon",
        cwd      => "$basedir",
        command  => "wget $download_link",
        user     => "$user",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
        creates  => "$basedir/tachyon-$version-bin.tar.gz",
        before   => Exec["untar-tachyon"],
        require  => File["tachyon-base"],
    }

    #untar the tarball
    exec { "untar tachyon":
        alias    => "untar-tachyon",
        cwd      => "$basedir",
        command  => "tar xvfz $basedir/tachyon-$version-bin.tar.gz",
        user     => "$user",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
        creates  => "$basedir/tachyon-$version",
        before   => [ File["tachyon-env"], File["tachyon-workers"], Exec["change-owner"]]
    }

    exec { "change owner":
        alias    => "change-owner",
        cwd      => "$basedir",
        command  => "chown -R $user:$group $basedir/tachyon-$version",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
    }

    #configuration file
    file { "$basedir/tachyon-$version/conf/tachyon-env.sh":
        alias    => "tachyon-env",
        content  => template("tachyon/templates/conf/tachyon-env.sh.erb"),
        owner    => "$user",
        group    => "$group",
    }

    #the worker file
    file { "$basedir/tachyon-$version/conf/workers" :
        alias    => "tachyon-workers",
        content  => "$workers",
        owner    => "$user",
        group    => "$group",
    }
}
