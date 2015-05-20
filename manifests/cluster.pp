class tachyon::cluster {

    exec { "format tachyon":
        cwd      => "${tachyon::params::tachyon_base}/tachyon-${tachyon::params::version}",
        command  => "./bin/tachyon format",
        user     => "${tachyon::params::tachyon_user}",
        path     => ["/bin", "/usr/bin", "${tachyon::params::tachyon_base}/bin"],
    }   

    #exec { "launch tachyon":
    #    command  => "./bin/tachyon-start.sh",
    #    user     => "${tachyon::params::tachyon_user}",
    #    cwd      => "${tachyon::params::tachyon_base}",
    #    path     => ["/bin", "/usr/bin", "${tachyon::params::tachyon_base}/bin"],
    #}
}
