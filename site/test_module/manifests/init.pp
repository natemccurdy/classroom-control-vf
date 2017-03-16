class test_module {

class { 'redis':
}

limits::fragment {
 "*/soft/nofile":
   value => "1024";
 "*/hard/nofile":
   value => "8192";
}


}
