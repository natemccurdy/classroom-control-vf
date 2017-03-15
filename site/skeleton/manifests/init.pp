class skeleton {

File {
      owner => 'root',
      group => 'root',
}

file {  '/etc/skel':
         ensure => directory   
         mode => '0755',
     }

file { '/etc/skel/.bashrc':
       ensure => file,
       mode => '0644',
       source => 'puppet:///modules/skeleton/mybashrc',
}

}
