# @summary Define module defaults
# @api private
class yum_cron::params {

  case $facts['os']['family'] {
    'RedHat': {
      $service_hasstatus  = true
      $service_hasrestart = true

      case $facts['os']['name'] {

        'RedHat', 'CentOS': {
          case $facts['os']['release']['major'] {
            '8': {
              $package_name     = 'dnf-automatic'
              $service_name     = 'dnf-automatic.timer'
              $config_path      = '/etc/dnf/automatic.conf'
              $debug_level      = '-2'
              $randomwait       = '360'
            }
            '7': {
              $package_name     = 'yum-cron'
              $service_name     = 'yum-cron'
              $config_path      = '/etc/yum/yum-cron.conf'
              $debug_level      = '-2'
              $randomwait       = '360'
            }
            '6': {
              $package_name     = 'yum-cron'
              $service_name     = 'yum-cron'
              $config_path      = '/etc/sysconfig/yum-cron'
              $debug_level      = '0'
              $randomwait       = '60'
            }
            default: {
              fail("Unsupported ${facts['os']['name']} operatingsystemmajrelease: ${facts['os']['release']['major']}, module ${module_name} only supports RedHat 6,7, and 8.")
            }
          }
        }

        'Fedora': {
          case $facts['os']['release']['major'] {
            '30', '31', '32': {
              $package_name     = 'dnf-automatic'
              $service_name     = 'dnf-automatic.timer'
              $config_path      = '/etc/dnf/automatic.conf'
              $debug_level      = '-2'
              $randomwait       = '360'
            }
            '22', '23', '24', '25', '26', '27', '28', '29': {
              $package_name     = 'yum-cron'
              $service_name     = 'yum-cron'
              $config_path      = '/etc/yum/yum-cron.conf'
              $debug_level      = '-2'
              $randomwait       = '360'
            }
            default: {
              fail("Unsupported ${facts['os']['name']} operatingsystemmajrelease: ${facts['os']['release']['major']}, module ${module_name} only supports Fedora versions 22-32.")
            }
          }
        }

        default: {
          fail("Unsupported operatingsystem: ${facts['os']['name']}, module ${module_name} only supports RedHat, CentOS, and Fedora.")
        }
      }
    }

    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}, module ${module_name} only support osfamily RedHat")
    }
  }

}
