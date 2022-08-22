# dotfiles

![dotfiles](./preview/dotfiles.png?raw=true "dotfiles")

WIP..

## Some details

+ **OS**: Manjaro
+ **WM**: i3-gaps
+ **Terminal**: kitty and urxvt
+ **Shell**: bash-it
+ **File Manager**: pcmanfm for GUI, Ranger for terminal
+ **Bar**: polybar
+ **Bar Icons**: Typicons Font
+ **Launcher**: Rofi
+ **Editor**: NeoVim
+ **Browser**: Chrome
+ **Music players**: mpd (with ncmpcpp)

## Latest preview
![Screenshot](./previews/desktop.png?raw=true "Latest")

## Dependencies
Here is a list of dependencies needed for making these themes work.
If you install all of them you will have a (mostly) smooth out of the box experience.
Of course, not all of them actually do something useful (see `fortune-mod` dependency).
Also if you are willing to edit a few configuration files, **which you will have to do** at some point, most of these dependencies can be replaced. For example you can replace `i3lock` with your own command, `rofi` with `dmenu`, my `screenshot.sh` script with `scrot`.

If you notice that something is missing, please open an issue so I can add the dependency to this table.

| Dependency                                                       | Description                                                                    | Why/Where is it needed?                                                |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| `i3-gaps`                                                        | Window manager                                                                 | (explains itself)                                                      |
| `rofi`                                                           | Window switcher, application launcher and dmenu replacement                    | (explains itself)                                                      |
| `xorg-xbacklight`                                                | Gets/Sets screen brightness (intel GPU only)                                   | brightness widget                                                      |
| `lm_sensors`                                                     | CPU temperature sensor                                                         | CPU temperature widget                                                 |
| `upower`                                                         | Abstraction for enumerating power devices, listening to device events and more | battery widget                                                         |
| `pulseaudio`, `libpulse`                                         | Sound system **(You probably already have these)**                             | volume widget, [bin/volume-control.sh](./bin/volume-control.sh) script |
| [bin/volume-control.sh](./bin/volume-control.sh) in your `$PATH` | Commands to control your volume                                                | volume buttons, volume widget                                          |
| `jq`                                                             | Parses `json` output                                                           | weather widget                                                         |
| `fortune-mod`                                                    | Displays random quotations (fortune cookies)                                   | fortune widget                                                         |
| `mpd`                                                            | Server-side application for playing music                                      | **sidebar** music widget                                               |
| `mpc`                                                            | Minimalist command line interface to MPD                                       | **sidebar** music widget                                               |
| `i3lock`                                                         | Screen locker                                                                  | exit screen lock command                                               |
| `maim`                                                           | Takes screenshots (improved `scrot`)                                           | [bin/screenshot.sh](./bin/screenshot.sh) script                        |
| [bin/screenshot.sh](./bin/screenshot.sh) in your `$PATH`         | Commands to take/view screenshots                                              | screenshot button                                                      |
| `feh`                                                            | Image viewer and wallpaper setter                                              | screenshot previews, wallpapers                                        |
| *Typicons* font                                                  | Icon font                                                                      | text exit screen, text weather icons, *skyfall* bar                    |
| Any *Nerd Font*                                                  | Icon font                                                                      | *manta* bar icons, *skyfall* taglist icons                             |
| [openweathermap](https://openweathermap.org/) key                | Provides weather data                                                          | weather widgets                                                        |

## Things to do after you set up dependencies
+ Backup your current `~/.config/i3` directory if you have one and copy this repo's `config/i3` directory in its place.

+ Configure default applications

   In `~/.config/i3/config` there is a section where default applications such as terminal, editor and file manager are defined.
   You should change those to your liking.

+ Configure autostart applications in `~/.config/i3/config`

+ *(Optional)* Load any `Xresources` colorscheme (`xrdb -merge <colorscheme file>`). In the [.xfiles](.xfiles) directory I provide you with a few of my own colorschemes, but you can also use your favorite one.

+ Have a general idea of what keybinds do

   My keybinds will most probably not suit you, but on your first login you might need to know how to navigate the desktop.

   See the **Basic keybinds** section for more details.

**You are now ready to login with Manjaro I3**

## Some recommended applications

+ **Terminals**: Termite / Kitty / urxvt / st
+ **File managers**: Nemo / Thunar
+ **Launchers**: Rofi / dmenu
+ **Browsers**: Firefox (with Vimium extension) / Qutebrowser
+ **Editors**: Vim / Sublime Text (with NeoVintageous plugin) / Spacemacs
+ **Music players**: mpd (with ncmpcpp)

### Eye-candy suggestions
- [bin/bunnyfetch](./bin/bunnyfetch) script - Display some system info
- `neofetch` - Display a ton of system info
- [even-better-ls](https://github.com/illinoisjackson/even-better-ls) - Icons for the `ls` command
- `cava` - Audio visualizer

## Basic keybinds

I use `super` AKA Windows key as my main modifier.

#### Keyboard
+ `super + enter` - Spawn terminal
+ `super + shift + enter` - Spawn floating terminal
+ `super + d` - Launch rofi
+ `super + shift + q` - Close client
+ `super + control + space` - Toggle floating client
+ `super + [1-0]` - View tag AKA change workspace (for you i3 folks)
+ `super + shift + [1-0]` - Move focused client to tag
+ `super + s` - Tiling layout
+ `super + shift + s` - Floating layout
+ `super + w` - Maximized / Monocle layout
+ `super + [arrow keys]` - Change focus by direction
+ `super + j/k` - Cycle through clients
+ `super + h/l` - Add / remove clients to / from master area
+ `super + shift + [arrow keys] / [hjkl]` - Move client by direction. Move to edge if it is floating.
+ `super + control + [arrow keys] / [hjkl]` - Resize
+ `super + f` - Toggle fullscreen
+ `super + m` - Toggle maximize
+ `super + n` - Minimize
+ `super + shift + n` - Restore minimized
+ `super + c` - Center floating client
+ `super + u` - Jump to urgent client (or back to last tag if there is no such client)
+ `super + shift + b` - Toggle bar
+ `super + =` - Toggle tray
+ ... And many many more.

## Tips / Notes
+ You can open an issue if you have any questions / problems.
   
   Do not forget to search through old issues first. They could already contain an answer to your question.
   Also make sure you have the latest version of the repo. Little fixes happen all the time.

+ If you are new to i3 or i3-gaps...
   
   I suggest you start from the default configuration and add pieces you like to it instead of trying to modify someone else's configuration even if you feel really comfortable with that specific config.
   Otherwise you will have no idea how anything works and how you can modify things to your own liking. Trust me, I've been there.

+ Don't forget to use the [API Documentation for I3]().
   
   It is well written and has plenty of examples.
