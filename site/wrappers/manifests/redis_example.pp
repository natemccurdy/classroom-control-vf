class wrappers::redis_example {

 # Redis requires EPEL
 class { 'epel':
   before => Class['redis', 'selinux'],
 }
 
 include redis
 
 # Lock down this redis box with selinux
 class { 'selinux':
   mode           => 'enforcing',
   manage_package => false,
 }

}
