# Puppet manifest for SE Exercise 2/2
#
class puppet {

  # Install packages
  package {
    'vim':
    ensure => installed; 		# Ensures that vim is installed

    'curl':
    ensure => installed;		# Ensures that curl is installed

    'git':
    ensure => installed;		# Ensures that git is installed
  }

  # Create user
  user {
    'monitor':		
    ensure => present,			# Ensures that user 'monitor' is present
    home   => '/home/monitor',		# Home directory is set to given path
    shell  => '/bin/bash';		# User's login shell
  }
  
  # Ensure home directory
  file {
    '/home/monitor':
    ensure => directory; 	         # Ensures monitor's home directory
  }

  # Creates scripts directory
  file {
    '/home/monitor/scripts':
    ensure => directory;
  }
  
  # Downloads memory_check script and store it to scripts directory
  exec {
    'wget --directory-prefix=/home/monitor/scripts https://raw.githubusercontent.com/ezieragabriel/memorycheck/master/memory_check':
    creates => '/home/monitor/scripts/memory_check',
    path    => '/usr/bin/';
  }
  
  # Creates src directory for softlink my_memory_check
  file {
    '/home/monitor/src':
    ensure => directory;
  }
  
  # Creates softlink (or symlink) my_memory_check
  file {
    '/home/monitor/src/my_memory_check':
    ensure => link,                                     # Ensures that my_memory_check is a link
    target => '/home/monitor/scripts/memory_check';     # Source file for link
  }

  # Cron job for my_memory_check
  cron { 'my_memory_check':
    ensure => present,
    command => '/home/monitor/src/my_memory_check',
    minute => '*/10';
  }

  # Set timezone to PHT (Manila)
  file {
    '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Asia/Manila';
  }

  # Change hostname to 'bpx.server.local'
  file {
    '/etc/hosts':
    ensure => file,
    content => '127.0.0.1    bpx.server.local';

    '/etc/sysconfig/network':
    ensure => file,
    content => "NETWROKING=yes\nHOSTNAME=bpx.server.local";
  } 

}

include puppet		# Calls for the 'puppet' class
### END ###
