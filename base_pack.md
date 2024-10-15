# Bin_Pack

See the pack folder in Modules for exampels etc !!!!


Packaging is a standard thing.

Can be used by my apps but also to package other apps.

## docs

all project need good docs.

Publish
https://doco.sh
https://github.com/paganotoni/doco

Edit
https://github.com/paganotoni/doco


Web, Desktop and Mobile

## mobile setup

https://github.com/worldiety/goup 
- does not pollute your disk at all.
- IOS and Android for Golang apps.
- just ned to wrap with a Makefile i think..

## Web View

https://github.com/webview/webview
https://github.com/webview/webview_go

https://github.com/gioui-plugins/gio-plugins/tree/main/webviewer


## all

ollama has alot of whats needed...
https://github.com/ollama/ollama/blob/main/scripts/build_darwin.sh

https://github.com/ollama/ollama/blob/main/scripts/build_windows.ps1



## mac icns

https://github.com/jackmordaunt/icns
- has a gio based preview thng too.

## mac desktop

https://github.com/dawenxi-tech/2fa


## Mac daemon

https://github.com/tprasadtp/go-launchd
- very advanced. not sure i can do it.

https://github.com/ollama/ollama/issues/2955#issuecomment-2064862349
pack_mac_daemon.plist

```sh
# Must first change username. Normalyl Roogt, but if you look at the others you can work it out.
# Must chaneg path to binary.

# list
ls -al /Library/LaunchDaemons/
# install
sudo cp pack_mac_daemon.plist /Library/LaunchDaemons/

# start/stop using
sudo launchctl load /Library/LaunchDaemons/pack_mac_daemon.plist
sudo launchctl unload /Library/LaunchDaemons/pack_mac_daemon.plist

```



