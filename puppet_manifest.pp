# Puppet manifest for SE Exercise 2/2

# Package class
class package {

  package { 'vim':
  ensure => installed, 		# Ensures that vim is installed
  }

  package { 'curl':
  ensure => installed,		# Ensures that curl is installed
  }

  package { 'git':
  ensure => installed,		# Ensures that git is installed
  }
}
