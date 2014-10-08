package { "vim":
  ensure => latest
}

package { "git":
  ensure => latest
}

node /staging\d./ {
  class { 'freaks::web':
    gemset => 'apibugfreak',
    app_name => 'apibugfreak'
  }
}

node /rubyproductionexample\d./ {
  class { 'freaks::web':
    gemset => 'apibugfreak',
    app_name => 'apibugfreak'
  }
}

node /^mongo\d.$/ {
  class { 'freaks::mongo': }
}
