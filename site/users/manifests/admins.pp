class users::admins {

$users = [ 'justin', 'alice', 'bob', 'cee', ]
 
$users.each |$user| {
   users::user_defined { $user: }

}

