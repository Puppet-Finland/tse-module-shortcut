define shortcut (
  $target,
  $ensure            = 'present',
  $path              = $title,
  $arguments         = undef,
  $icon_location     = undef,
  $working_directory = undef,
  $description       = undef,
) {

  $lnk_path = $path ? {
    /\.lnk$/ => $path,
    default  => "${path}.lnk",
  }

  if $ensure == 'present' {
    exec { "ensure shortcut ${title}":
      provider => powershell,
      command  => template('shortcut/ensure.ps1.erb'),
      unless   => template('shortcut/exists.ps1.erb'),
    }
  } elsif $ensure == 'absent' {
    file { $title:
      ensure => 'absent',
    }
  } else {
    fail("Invalid value ${ensure} for parameter \$ensure!")
  }

}
