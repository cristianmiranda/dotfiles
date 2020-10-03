#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# ~/.macos — https://mths.be/macos

# Some inspiration
# https://github.com/stephen-huan/macos_dotfiles#configuration

# Ask for the administrator password upfront
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General UI/UX                                                               #
###############################################################################

info ">>> General: Disable 'app is damaged and can't be opened' warning"
sudo spctl --master-disable >> $LOG_FILE 2>&1

info ">>> General: Disable automatic capitalization"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false >> $LOG_FILE 2>&1

info ">>> General: Disable smart dashes"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false >> $LOG_FILE 2>&1

info ">>> General: Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false >> $LOG_FILE 2>&1

info ">>> General: Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false >> $LOG_FILE 2>&1

info ">>> General: Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop" >> $LOG_FILE 2>&1

info ">>> General: Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png" >> $LOG_FILE 2>&1

info ">>> General: Clock format"
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss" >> $LOG_FILE 2>&1

info ">>> General: Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true >> $LOG_FILE 2>&1

info ">>> General: Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true >> $LOG_FILE 2>&1

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

info ">>> Trackpad: Enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true >> $LOG_FILE 2>&1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 >> $LOG_FILE 2>&1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 >> $LOG_FILE 2>&1

info ">>> Trackpad: Enable three finger drag"
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1 >> $LOG_FILE 2>&1

info ">>> Trackpad: Enable scroll gesture with the Ctrl (^) modifier key to zoom"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true >> $LOG_FILE 2>&1
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144 >> $LOG_FILE 2>&1

info ">>> Language: Set language and text formats"
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en-AR" "es-AR" >> $LOG_FILE 2>&1
defaults write NSGlobalDomain AppleLocale -string "en_US" >> $LOG_FILE 2>&1
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters" >> $LOG_FILE 2>&1
defaults write NSGlobalDomain AppleMetricUnits -bool true >> $LOG_FILE 2>&1

info ">>> Language: Hide language menu in the top right corner of the boot screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

info ">>> Finder: Enable copy/paste functionality while in QuickLook"
defaults write com.apple.finder QLEnableTextSelection -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Hide icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false >> $LOG_FILE 2>&1
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false >> $LOG_FILE 2>&1
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false >> $LOG_FILE 2>&1
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false >> $LOG_FILE 2>&1

info ">>> Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true >> $LOG_FILE 2>&1

info ">>> Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false >> $LOG_FILE 2>&1

info ">>> Finder: Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true >> $LOG_FILE 2>&1
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true >> $LOG_FILE 2>&1
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true >> $LOG_FILE 2>&1
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true >> $LOG_FILE 2>&1
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true >> $LOG_FILE 2>&1
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true >> $LOG_FILE 2>&1

info ">>> Finder: Use column list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv" >> $LOG_FILE 2>&1

info ">>> Finder: Show the ~/Library folder"
sudo chflags nohidden ~/Library >> $LOG_FILE 2>&1

info ">>> Finder: Show the /Volumes folder"
sudo chflags nohidden /Volumes >> $LOG_FILE 2>&1

###############################################################################
# Dock, Dashboard, and hot corners                                            #
##############################################################################

info ">>> Dock: Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true >> $LOG_FILE 2>&1

info ">>> Dock: Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true >> $LOG_FILE 2>&1

info ">>> Dock: Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true >> $LOG_FILE 2>&1

info ">>> Dock: Don’t group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false >> $LOG_FILE 2>&1

info ">>> Dock: Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false >> $LOG_FILE 2>&1

info ">>> Dock: Don’t show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false >> $LOG_FILE 2>&1

# Reset Launchpad, but keep the desktop wallpaper intact
# find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete >> $LOG_FILE 2>&1

info ">>> Dock: Automatically hide dock"
defaults write com.apple.dock autohide -bool true  >> $LOG_FILE 2>&1
# defaults write com.apple.dock autohide-time-modifier -float 0.25 >> $LOG_FILE 2>&1
# defaults write com.apple.dock launchanim -bool false
# killall Dock

# Restore Dock
# defaults write com.apple.dock autohide -bool false 
# defaults delete com.apple.dock autohide-time-modifier 
# defaults write com.apple.dock launchanim -bool true 
# killall Dock

# Automatically hide status bar
# defaults write NSGlobalDomain _HIHideMenuBar -bool false >> $LOG_FILE 2>&1

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

info ">>> Dock: Bottom left corner: Put display to sleep"
#
# Hot corners
#
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# 
# Top left screen corner → Mission Control
# defaults write com.apple.dock wvous-tl-corner -int 2
# defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
# defaults write com.apple.dock wvous-tr-corner -int 4
# defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Put display to sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Install the Solarized Dark theme for iTerm
#open "${HOME}/init/Solarized Dark.itermcolors"

info ">>> iTerm2: Don’t display the annoying prompt when quitting iTerm2"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false >> $LOG_FILE 2>&1

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

info ">>> Google Chrome: Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true >> $LOG_FILE 2>&1
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true >> $LOG_FILE 2>&1
