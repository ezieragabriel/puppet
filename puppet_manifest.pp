# Puppet manifest for SE Exercise 2/2
#
# class
class puppet {

  # Install packages
  package { 'vim':
    ensure => installed, 		# Ensures that vim is installed
  }

  package { 'curl':
    ensure => installed,		# Ensures that curl is installed
  }

  package { 'git':
    ensure => installed,		# Ensures that git is installed
  }

  # Create user
  user { 'monitor':		
    ensure => present,		# Ensures that user 'monitor' is present
    home => '/home/monitor',	# Home directory is set to given path
    shell => '/bin/bash',		# User's login shell
  }
  
  # Ensure home directory
  file { '/home/monitor':
    ensure => directory,          # Ensures monitor's home directory
  }

  # Creates scripts directory
  file { '/home/monitor/scripts':
    ensure => directory,
  }
  
  # Downloads memory_check script and store it to scripts directory
  exec { 'wget --directory-prefix=/home/monitor/scripts https://raw.githubusercontent.com/ezieragabriel/memorycheck/master/memory_check':
    creates => '/home/monitor/scripts/memory_check',
    path    => '/usr/bin/'
  }
}
