class apache::mod::authnz_ldap (
  $ldapDirectives = [ ],
) {
  include 'apache::mod::ldap'
  apache::mod { 'authnz_ldap': }

  validate_array($ldapDirectives)
  $directiveStr = join($ldapDirectives, '
')
  validate_re($directiveStr, [ '^LDAP', '^$' ])

  file { 'authnz_ldap.conf':
    ensure  => file,
    path    => "${apache::mod_dir}/authnz_ldap.conf",
    content => $directiveStr,
    require => Exec["mkdir ${apache::mod_dir}"],
    before  => File[$apache::mod_dir],
    notify  => Service['httpd'],
  }
}
