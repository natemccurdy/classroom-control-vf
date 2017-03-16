# defined type
define users::managed_user {
                             $username =$title,
                             $homedir ="/home/$(username)",
                            }     
# parameters
{
  user { $username:
         ensure => preset,
         gid => $username,
       }
   group { $groupname:
          ensure => present,
         }

}
