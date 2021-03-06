# My personal `~/.bashrc.d`

If you are here, you use Bash and you like to have the same bash setup across all your machines/accounts.

So, in line with the Unix principle organising _additional_ configuration files in a directory like `/path/to/normal/config/file.d/`,
I started to do the same for my bash. Create a collection of additional scripts/files/snippets to execute at the launch of my bash session.
This allows to personalize, tweak, colorize and what not.

When I created this repo on GitHub, I also discovered that many others have done similar things. This is in no way special, just my take on it.

## Install

**1.** Add the following to your `~/.bashrc` file
```bash
# Initialize `~/.bashrc.d`
[[ -s "${HOME}/.bashrc.d/.init.sh" ]] && source ${HOME}/.bashrc.d/.init.sh
```
**2.** Git clone this project as follows:
```bash
git clone https://github.com/detro/.bashrc.d.git ~/.bashrc.d
```
**3.** Start a new shell (i.e. bash session)

### Using _Terminal_ on macOS

By default, _Terminal_ starts the shell via `/usr/bin/login`, which makes the shell a login shell.
On every platform (not just Mac OS X) bash does not use `.bashrc` for login shells (only `/etc/profile` and
the first of `~/.bash_profile`, `~/.bash_login`, `~/.profile` that exists and is readable).
So, make sure to alter **step 1.** based on your needs. Personally? I like `~/.bash_profile`. 

## Personalization?

As much as one would love to write a set of Bash tweaks and functionalities, and have them work everywhere they work, there are still situations where you really need very specific things, in very circonscript contexts.

In other words, if there is a specific configuration that you want to keep local to a machine, just add the file to your local copy of `.bashrc.d` with the extension `.private.sh`. Git will ignore it but it will get loaded.

## Special mention

One of the scripts I use for my prompt is [posh-git-sh](https://github.com/lyze/posh-git-sh): thanks to [David Xu](https://github.com/lyze) for creating it.

## License

None. Do with this as you see fit: [unlicense](http://unlicense.org/).
