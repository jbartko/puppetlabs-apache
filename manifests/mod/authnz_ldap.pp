class apache::mod::authnz_ldap (
  $ldap_directives = [ ],
) {
  include '::apache::mod::ldap'
  ::apache::mod { 'authnz_ldap': }

  $newline = '
'
  validate_array($ldap_directives)
  $temp = join($ldap_directives, $newline)
  $directiveStr = "${temp}${newline}"
  validate_re($directiveStr, [ '^LDAP', '^$' ])

  file { 'authnz_ldap.conf':
    ensure  => file,
    path    => "${::apache::mod_dir}/authnz_ldap.conf",
    content => $directiveStr,
    require => Exec["mkdir ${::apache::mod_dir}"],
    before  => File[$::apache::mod_dir],
    notify  => Service['httpd'],
  }
}
