# Auto setup development environment

```
bash <(curl -L https://raw.githubusercontent.com/jayanatl/dotfiles/devel/kickstart.sh)
```

# Pick a custom branch or repo
```
branch="jayan_centos7" # Use this branch for installation
repo="https://github.com/jayanatl/dotfiles.git" # Use https, (optional) repo to clone dot files from
bash <(curl -L https://raw.githubusercontent.com/jayanatl/dotfiles/${branch}/kickstart.sh) ${branch} ${repo}
```

# WARNING
The creator or contributers of this repository is not responsible if your machine ends up in a state you are not happy with. Look at the code to review everything this will do to your machine before using this.

# NOTE
## EVERYTHING BELOW IS OUTDATED, DO NOT USE


>NOTE: If you are using Windows, install [powerline fonts](https://github.com/powerline/fonts) and configure your terminal emulator to use those fonts.
>Prefered font: noto mono for powerline

## BugFix:
- [ ] Fix output generated while creating links to dotfiles


## TODO
- [x] Create a skeleton structure for the repo
- [x] Basic prototype
- [x] Configure Autoload Alias, PATH, functions, variables
- [x] System update
- [x] Install Python(2,3), pip(2,3), and other useful tools
- [x] Install neovim
- [ ] Setup and test python support for nvim
- [ ] Configure code completion for nvim
- [ ] Configure skyline
- [ ] Configure 
- [ ] Configure virtual env for each python binaries
- [ ] configure ale python-cfn-lint
- [ ] fix current configuration for duplicate entries and may be remove unwanted plugins to optimize
- [ ] disable unwanted plugins by default
- [ ] remove output from .profile so that scp works fine

---

# New changes

## Optimize scripts to work for several oses
- Scripts for RHEL / CentOS may not be tested but should work
- Establish good folder structure / framework to
  - Build new machine
  - Rebuild new machine
  - Cleanup already configured machine
  - Update code and repo

- Configuration for mac

- List of interesting tools

- Vim help md file

- Todo manager

- Python Notes

- Bash Notes

- Rust Notes

- Go Notes?

- Other notes (probably notes will go into another repo

# TODO:
  - Cleanup repo
  - Organize scripts and support files
  - Make this simple, remove fancy decorations and all?
  - Install and cleanup files
  - List of interesting tools / packages (Document)
  - Installation of OS Specific tools
  - Vim basic configuration
  - Vim exteded configuration without custom fonts
  - Vim exteded configuration with custom fonts
  - Test on RHEL
  - Test on CentOS

# bin/findosversion
# bin/read_data # to read data needed to configure the everything from console
# bin/installnvim # takes one arg which is outoput of findosversion and runs that os specific code, if os not supported, throw a message and skip thatone and go to next one
# files in bin will be chronologicaly ordered so that dependancy and order and maintained during execution
# bin/../setup_my_dev_env.sh will find os_version and call everything in bin with that arg
# maybe move findosversion as a function in a lib file which is excluded from setup execution
# all executables in bin/should have a roll back mechanism 

# Folder structure
  Home: dotfiles
  /bin -> Binaries
  /os/{rhel,centos,mac,...} -> holds os specific configuration files
