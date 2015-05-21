class tachyon {
    require "tachyon::params"

    group { "${tachyon::params::tachyon_group}":
        ensure => present,
    }

    user { "${tachyon::params::tachyon_user}":
        ensure  => present,
        shell   => "/bin/bash",
        require => Group["${tachyon::params::tachyon_group}"],
    }

    package { "openjdk-7-jdk":
        ensure => installed,
    }

    package { "wget":
        ensure => installed,
    }
 
    #base directory
    file { "${tachyon::params::tachyon_base}":
        alias    => "tachyon-base",
        owner    => "${tachyon::params::tachyon_user}",
        group    => "${tachyon::params::tachyon_group}",
        ensure   => directory,
        require  => [ User["${tachyon::params::tachyon_user}"], Group["${tachyon::params::tachyon_group}"] ]
    }

    #install directory
    #file { "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}":
    #    alias    => "tachyon-install",
    #    owner    => "${tachyon::params::tachyon_user}",
    #    group    => "${tachyon::params::tachyon_group}",
    #    ensure   => directory,
    #    require  => [ User["${tachyon::params::tachyon_user}"], Group["${tachyon::params::tachyon_group}"] ]
    #}
 
    #download from the official tarball
    exec { "download tachyon":
        alias    => "download-tachyon",
        cwd      => "${tachyon::params::tachyon_base}",
        command  => "wget ${tachyon::params::download_link}",
        user     => "${tachyon::params::tachyon_user}",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
        creates  => "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}-bin.tar.gz",
        before   => Exec["untar-tachyon"],
        require  => File["tachyon-base"],
    }

    #untar the tarball
    exec { "untar tachyon":
        alias    => "untar-tachyon",
        cwd      => "${tachyon::params::tachyon_base}",
        command  => "tar xvfz ${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}-bin.tar.gz",
        user     => "${tachyon::params::tachyon_user}",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
        creates  => "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}",
        before   => [ File["tachyon-env"], File["tachyon-workers"]]
    }

    exec { "change owner":
        alias    => "change-owner",
        cwd      => "${tachyon::params::tachyon_base}",
        command  => "chown -R ${tachyon::params::tachyon_user}:${tachyon::params::tachyon_group} ${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}",
        path     => ["/bin", "/usr/bin", "/usr/sbin"],
    }

    #configuration file
    file { "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}/conf/tachyon-env.sh":
        alias    => "tachyon-env",
        content  => template("tachyon/templates/conf/tachyon-env.sh.erb"),
        owner    => "${tachyon::params::tachyon_user}",
        group    => "${tachyon::params::tachyon_group}",
    }

    #the worker file
    file { "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}/conf/workers" :
        alias    => "tachyon-workers",
        content  => "${tachyon::params::workers}",
        owner    => "${tachyon::params::tachyon_user}",
        group    => "${tachyon::params::tachyon_group}",
    }
}
