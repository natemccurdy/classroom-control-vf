class users::admins {

  $users = [
    'jose',
    'alice',
    'chen',
    'bob',
    'sally',
    'elmo',
  ]

  $users.each |$user| {
    users::managed_user { $user: }
  }

}
