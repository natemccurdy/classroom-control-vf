class nginx::params {
case $facts['os']['family'] {
'redhat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
$docroot = '/var/www'
$confdir = '/etc/nginx'
$logdir = '/var/log/nginx'
}

default : {
fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}
}
$user = $facts['os']['family'] ? {
'redhat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
}
$port = '80'
}
