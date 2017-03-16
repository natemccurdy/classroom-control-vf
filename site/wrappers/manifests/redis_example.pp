class wrappers::redis_example {

 # Redis requires EPEL
 class { 'epel':
   before => Class['redis'],
 }
 
 include redis
 
 # Lock down this redis box with selinux
 class { 'selinux':
   mode => 'enforcing',
 }

}
