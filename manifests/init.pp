class tachyon {
    
    require 'tachyon::params'

    package { 'openjdk-7-jdk':
        ensure => installed,
    }

    package { 'wget':
        ensure => installed,
    }
    
    exec { "wget":
        cwd     => "/mnt/",
        command => "/usr/bin/wget https://github.com/amplab/tachyon/releases/download/v0.6.4/tachyon-0.6.4-bin.tar.gz",
        creates => "/mnt/tachyon-0.6.4-bin.tar.gz",
    }

    exec { "untar":
        user    => "root",
        cwd     => "/mnt",
        command => "/bin/tar xvfz /mnt/tachyon-0.6.4-bin.tar.gz",
        creates => "/mnt/tachyon-0.6.4",
    }

    file { '/mnt/tachyon-0.6.4/conf/tachyon-env.sh':
        content => template('/home/tianyin/puppet/modules/tachyon/templates/conf/tachyon-env.sh.erb'),
    }

    notice('$params::servers')

}
