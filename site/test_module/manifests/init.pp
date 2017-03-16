class test_module {

include epel
include redis

limits::fragment {
 "*/soft/nofile":
   value => "1024";
 "*/hard/nofile":
   value => "8192";
}


}
