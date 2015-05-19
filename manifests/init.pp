class tachyon {
    #package { 'tachyon':
    #    ensure => installed,
    #}

    package { 'wget':
        ensure => installed,
    }
    
    exec { "wget":
        command => "/usr/bin/wget https://github.com/amplab/tachyon/releases/download/v0.6.4/tachyon-0.6.4-bin.tar.gz",
        creates => "/home/tianyin/tachyon-0.6.4-bin.tar.gz"
    }

    exec { "untar":
        user    => "tianyin",
        command => "/bin/tar xvfz /home/tianyin/tachyon-0.6.4-bin.tar.gz -C /home/tianyin/",
        creates => "/home/tianyin/tachyon-0.6.4"
    }
} 	
