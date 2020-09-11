# ~/dotfiles

![](https://github.com/cristianmiranda/dotfiles/workflows/dotbot%20sync/badge.svg) [![Maintainability](https://api.codeclimate.com/v1/badges/d26f962b6f312f347e73/maintainability)](https://codeclimate.com/github/cristianmiranda/dotfiles/maintainability)

```bash
curl -L git.io/cm.files -o /tmp/cm.files && bash /tmp/cm.files
```

## Installing on ESH server
```
# Clone repo
cd ~
git clone --recursive https://github.com/cristianmiranda/dotfiles.git

# Install
. ~/dotfiles/scripts/esh-server-install.sh
```