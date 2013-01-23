exec {
  'fix_stdin_is_not_a_tty':
    command => '/bin/sed -i "s/^mesg n$/[[ -t 0 ]] \&\& mesg n/" /root/.profile',
    onlyif  => '/bin/grep    "^mesg n$"   /root/.profile',
}

package {
  ['virtualbox-guest-utils', 'virtualbox-guest-dkms',
  'virtualbox-guest-additions']:
    ensure => latest;
}

# Ensure that native packages for Puppet community edition are purged.
package {
  ['puppet', 'puppet-common', 'facter']:
    ensure => purged,
}
