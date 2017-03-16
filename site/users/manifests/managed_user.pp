define users::managed_user (
  $username  = $title,
  $groupname = $title,
  $homedir   = "/home/${username}",
) {

  user { $username:
    ensure => present,
    gid    => $groupname,
  }
  
  group { $groupname:
    ensure => present,
  }
  
  file { $homedir:
    ensure => directory,
    owner  => $username,
    group  => $groupname,
    mode   => '0750',
  }
  
  file { "${homedir}/.ssh":
    ensure => directory,
    owner  => $username,
    group  => $groupname,
    mode   => '0750',
  }
  
}
