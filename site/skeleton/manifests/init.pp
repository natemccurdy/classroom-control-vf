class skeleton {

File {
      owner => 'root',
      group => 'root',
      mode => '0644'
      }

file {  '/etc/skel':
         ensure => directory   
      }

file { '/etc/skel/.bashrc':
       ensure => file,
       source => 'puppet:///modules/skeleton/mybashrc',
     }

}
