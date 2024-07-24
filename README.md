# Louis's bash prompt

![User Example](/res/user.png?raw=true)

![Root Example](/res/root.png?raw=true)

![Git Example](/res/git.png?raw=true)

### Usage
- Install powerline fonts from [here](https://github.com/powerline/fonts) or command `sudo apt install fonts-powerline` on Debian based systems
- Enable powerline fonts in your terminal emulator
- Copy the code below to your user or global bashrc. I use the global bashrc located at `/etc/bash.bashrc` (on Debian), so that it applies to all users.

### Notes
- Performance could be a problem as the whole PS1 variable gets recalculated every time the prompt gets printed; although it hasn't been a problem for me yet.
- The hostname gets printed if you ssh into another machine
- The prompt uses [`__git_ps1`](https://git-scm.com/book/cs/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash) to print git information at the end of the prompt if a repository is present
- The color is blue for a normal user and red for root to signify that it is "Danger Territory"
- To change the colors look for the variables starting with `PS1_COLOR_` and change the color codes to the one you like from [here](https://www.ditig.com/publications/256-colors-cheat-sheet)
