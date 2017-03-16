class test_module {

include epel

package { 'logrotate' :
 ensure => installed
}

include redis

limits::fragment {
 "*/soft/nofile":
   value => "1024";
 "*/hard/nofile":
   value => "8192";
}


}
