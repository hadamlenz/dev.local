# dnsmasq on osx 

## Requirements

* [Homebrew](https://brew.sh/)
* Mac OSX

## Install
```bash
brew install dnsmasq
```

### Setup *.test

we are going to use 10.200.10.1.  Its a local ip that is not used.  I have also used others but this is what I am using now

`nano $(brew --prefix)/etc/dnsmasq.conf`
or 
`code $(brew --prefix)/etc/dnsmasq.conf`
or
`code-insiders $(brew --prefix)/etc/dnsmasq.conf`

paste the following

```bash
port=53
domain-needed
bogus-priv
address=/.test/10.200.10.1
cache-size=10000
```

## Autostart - now and after reboot
```bash
sudo brew services start dnsmasq
```

## Add to resolvers

### Create resolver directory
```bash
sudo mkdir -v /etc/resolver
```

### Add your nameserver to resolvers
```bash
sudo bash -c 'echo nameserver 10.200.10.1 > /etc/resolver/test'
```

run `scutil --dns` to show all of your current resolvers


### Get the Loopback interface seeing your requests
```bash
sudo ifconfig lo0 alias 10.200.10.1
```

you can run the following to see you've done something
```bash
ifconfig lo0
```

you should see the following
```bash
inet 10.200.10.1 netmask 0xff000000
```

Add all this to .bash_profile to make thigns faster

```bash
alias dns-start="sudo brew services start dnsmasq"
alias dns-stop="sudo brew services stop dnsmasq"
alias dns-restart="brew services restart dnsmasq"
alias setup-local-ip="sudo ifconfig lo0 alias 10.200.10.1"
alias make-test-resolver="sudo bash -c 'echo nameserver 10.200.10.1 > /etc/resolver/test'"
alias remove-test-resolver="sudo rm /etc/resolver/test"
```

When you restart you will have to run
`dns-stop && setup-local-ip && dns-start`

to get around this you can add a launch deamon 



```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>org.my.loopbackalias</string>
    <key>RunAtLoad</key>
    <true/>
    <key>ProgramArguments</key>
    <array>
      <string>/sbin/ifconfig</string>
      <string>lo0</string>
      <string>alias</string>
      <string>10.200.10.1</string>
    </array>
</dict>
</plist>
```