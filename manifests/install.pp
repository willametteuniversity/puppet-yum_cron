# @summary Install yum-cron
# @api private
class yum_cron::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::os['name'] == 'Fedora' and $::os['release']['major'] >= '28' {

    package { 'cron':
      ensure => 'present',
      name   => 'cronie',
    }

    package { 'anacron':
      ensure => 'present',
      name   => 'cronie-anacron',
    }
  }

  package { 'yum-cron':
    ensure => $yum_cron::package_ensure_real,
    name   => $yum_cron::package_name,
  }

  if $::operatingsystem =~ /Scientific/ and $yum_cron::yum_autoupdate_ensure == 'absent' {
    package { 'yum-autoupdate':
      ensure  => absent,
    }
  }
}
