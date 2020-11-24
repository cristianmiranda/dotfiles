#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh
. ${UTILS_PATH}/path.sh

if [[ $INSTALL_PACKAGES =~ n|N ]];
then
    warning ">>> Skipping Packages..."
    exit 0
fi

# Ask for the administrator password upfront
sudo -v

# MANUALLY:
# - https://www.sempliva.com/tiles/
# - iStat Menus

# APP STORE:
# - Spark
# - ToothFairy
# - Twitter

# Make sure we’re using the latest Homebrew.
# Upgrade any already-installed formulae.
brewUpdateUpgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

ESSENTIALS=(
	bash
	coreutils
	findutils
	git
	gnu-indent
	gnu-sed
	gnutls
	grep
	gnu-tar
	gawk
	moreutils
	rename
	tree
	vim
	wget
	zsh
)

PACKAGES=(
	ant
	bat
	bash-completion
	jakehilborn/jakehilborn/displayplacer
	fd
	ffmpeg
	git-delta
	git-lfs
	git-secret
	gqlplus
	htop
	InstantClientTap/instantclient/instantclient-sqlplus
	jq
	maven
	node
	ranger
	svn
	tmux
	yarn
	w3m
)

CASKS=(
	1password
	balenaetcher
	discord
	docker
	dozer
	duplicati
	element
	evernote
	firefox
	homebrew/cask-versions/firefox-developer-edition
	gitify
	gitkraken
	google-backup-and-sync
	google-chrome
	gpg-suite
	iterm2
	jetbrains-toolbox
	jitsi-meet
	kindle
	maccy
	microsoft-office
	nordvpn
	openvpn-connect
	paragon-extfs
	paragon-ntfs
	pgadmin4
	postman
	slack
	spotify
	steam
	telegram
	the-unarchiver
	transmission
	visual-studio-code
	whatsapp
	zoomus
)

FONTS=(
	font-clear-sans
	font-consolas-for-powerline
	font-dejavu-sans-mono-for-powerline
	font-fira-code
	font-fira-mono-for-powerline
	font-liberation-mono-for-powerline
	font-menlo-for-powerline
	font-roboto
	font-fontawesome
)

QUICKLOOK=(
	qlcolorcode
	qlmarkdown
	qlprettypatch
	qlstephen
	qlimagesize
	quicklook-csv
	quicklook-json
	epubquicklook
)

# Remove outdated versions from the cellar.
brewCleanup

for pkg in ${ESSENTIALS[@]}; do
    brewInstall $pkg
done

for pkg in ${PACKAGES[@]}; do
    brewInstall $pkg
done

for pkg in ${CASKS[@]}; do
    brewCaskInstall $pkg
done

for pkg in ${QUICKLOOK[@]}; do
    brewCaskInstall $pkg
done

brew tap homebrew/cask-fonts >> $LOG_FILE 2>&1
for pkg in ${FONTS[@]}; do
    brewCaskInstall $pkg
done

pip3InstallForUser pipenv-shebang
pip3Install termdown
pip3Install PyPDF2
pip3Install black
pip3Install PyYAML
pip3Install osascript
pip3Install bpytop

npm i -g gitmoji-cli
npm i -g libgen-downloader

# SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 11.0.8-amzn
