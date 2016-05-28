# Puppet manifest for SE Exercise 2/2

# Package class
class package {
  package { 'vim':
  ensure => installed, 		# Ensures that vim is installed
}
