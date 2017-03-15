class test {

file {'testmodule':
ensure => file,
path => '/etc/test.txt',
owner => 'root',
group => 'root',
mode => '0644',
source => 'puppet://modules/test/abc',

}


}
