# Never touch your local /etc/hosts file in OS X again

## Requirements

* [Homebrew](https://brew.sh/)
* Mac OSX

## Install
```
brew install dnsmasq
```

### Setup *.test

nano $(brew --prefix)/etc/dnsmasq.conf
or 
code $(brew --prefix)/etc/dnsmasq.conf
or
code-insiders $(brew --prefix)/etc/dnsmasq.conf


port=53
domain-needed
bogus-priv
address=/.test/10.200.10.1
cache-size=10000

## Autostart - now and after reboot
```
sudo brew services start dnsmasq
```

## Add to resolvers

### Create resolver directory
```
sudo mkdir -v /etc/resolver
```

### Add your nameserver to resolvers
```
sudo bash -c 'echo nameserver 10.254.254.254 > /etc/resolver/test'
```


That's it! You can run scutil --dns to show all of your current resolvers, and you should see that all requests for a domain ending in .test will go to the DNS server at 10.254.254.254

Add all this to .bash_profile.  

```bash
alias dns-start="sudo brew services start dnsmasq"
alias dns-stop="sudo brew services stop dnsmasq"
alias dns-restart="brew services restart dnsmasq"
alias setup-local-ip="sudo ifconfig lo0 alias 10.254.254.254"
alias make-test-resolver="sudo bash -c 'echo nameserver 10.254.254.254 > /etc/resolver/test'"
alias remove-test-resolver="sudo rm /etc/resolver/test"
```

When you restart you will have to run
`dns-stop && setup-local-ip && dns-start`

ifconfig lo0