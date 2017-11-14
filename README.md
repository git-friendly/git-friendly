<img src="https://d3vv6lp55qjaqc.cloudfront.net/items/0F2U3y3k0z1z0W2y2H0e/git-friendly.jpg" width="100%" style="width:100%" />

A collection of shell scripts for making **pulling**, **branching**, and **merging** with Git fast and painless.

Git sometimes requires typing two or three commands just to execute something basic like fetching new code. git-friendly adds a few new commands — `pull`, `push`, `branch` and `merge` which:

* stash and pop changes as needed;
* **push** also copies a GitHub compare URL to your clipboard;
* **pull** runs commands like `bundle install`, `npm install`, `yarn install`, and `composer install` if necessary;
* **branch** tracks remote branches if they are available.

*Less time fighting Git — more time actually doing work.*

## Install

Run this one-liner, which will download the scripts into `/usr/local/bin`:

```bash
curl -sS https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh | bash
```

**Note:** If you don’t have write access to `/usr/local/bin` you’ll need to run this using `sudo`.

You can change an installation directory:

```bash
curl -sS https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh | bash -s ~/friendly
```

## Manual Install

Checkout the code:

```bash
git clone git://github.com/jamiew/git-friendly.git ~/dev/git-friendly
```

Then update your `~/.bash_profile` or `~/.bashrc` to make git-friendly available each time you launch a new terminal:

```bash
export PATH=~/dev/git-friendly:$PATH
```

## Usage

You now have new awesome commands: **pull**, **push**, **branch**, **merge**:

![](https://d3vv6lp55qjaqc.cloudfront.net/items/3S3H2W1l1F3d1m2x3w1U/pull.png)

Example session:

```bash
$ pull
$ branch awesomeness
$ echo "BUMP" >> README
$ git commit -a -m "Righteous bump"
$ branch master
$ merge awesomeness
$ push
```


## Commands

### `pull`

* Stash any local changes;
* pull from the remote using rebase;
* update submodules;
* pop your stash;
* run `bundle install`, `npm install`, `yarn install`, `bower install` or `composer install` if there are any changes in `Gemfile`, `package.json`, etc.

### `push`

* Push your changes to the remote;
* copy a compare URL, like [https://github.com/jamiew/git-friendly/compare/e96033...5daed4](https://github.com/jamiew/git-friendly/compare/e96033...5daed4), to your clipboard (works on Mac and Linux).

Any extra arguments will be passed through to `git push`, for example `push -f`.

### `branch`

Switch branches or create new local branch if it doesn’t exist. Intelligently sets up remote branch tracking so you can just type `git pull` and not always `git pull origin newbranch`. If no argument specified, will list all local and remote branches. 

```
branch [name]
```

Supports branch deletion with `-d` or `-D` keys:

```
branch -d [name]
branch -D [name]
```

And switching to a previous branch with `-`:

```
branch -
```

### `merge`

* Merge the specified branch into the current branch;
* rebase first if the branch is local-only.

```
merge [name]
```

## Configuration

To disable `bundle install`, `npm install`, `yarn install`, `bower install` or `composer install` for the `pull` command use environmental variables:

* `GIT_FRIENDLY_NO_BUNDLE`: disables `bundle install`
* `GIT_FRIENDLY_NO_NPM`: disables `npm install`
* `GIT_FRIENDLY_NO_YARN`: disables `yarn install`
* `GIT_FRIENDLY_NO_BOWER`: disables `bower install`
* `GIT_FRIENDLY_NO_COMPOSER`: disables `composer install`

For example, add this line to your `~/.bash_profile` to disable `bundle install`:

```bash
export GIT_FRIENDLY_NO_BUNDLE=true
```


## Bonus: Pimp Your Configs

We strongly recommend editing your global `~/.gitconfig` and adding features like ANSI color, command aliases (e.g. `git st` instead of `git status`), automatic remote tracking and more. Check out [this sample ~/.gitconfig](https://gist.github.com/668161) to get started.

We also recommend adding the current Git branch to your Terminal prompt (PS1) or you’ll quickly lose your place — here is a [pimp_prompt() bash function](https://gist.github.com/790086) which goes in your `~/.bash_profile` or `~/.bashrc`, then type `source ~/.bashrc` to reload.

![](http://wow.sapegin.me/image/0Z1C1U00281j/pimped-prompt.jpg)


## License

MIT license.

Fork away, do whatever. Pull requests welcome.

Following the practices of [Rubinius](http://www.programblings.com/2008/04/15/rubinius-for-the-layman-part-2-how-rubinius-is-friendly/), anyone who submits an accepted patch is granted a commit bit (write access to the repository).

Following the practices of [FAT Lab](http://fffff.at), anyone who submits an accepted patch is granted credit and attribution bits.


## Contributors

* [Ethan Bruning](https://github.com/ebruning) ([ebruning](https://github.com/ebruning))
* [Rafael Corrêa Gomes](https://rafaelstz.github.io/) ([rafaelstz](https://github.com/rafaelstz))
* [Harold Dennison](http://hdennison.com/) ([hdennison](https://github.com/hdennison))
* [CJ Lazell](http://cj.io/) ([cj](http://github.com/cj))
* [Maciej Małecki](http://twitter.com/mmalecki) ([mmalecki](https://github.com/mmalecki))
* [John Manoogian](II":http://jm3.net) ([jm3](http://github.com/jm3))
* [Andriy Prokopenko](http://andriyprokopenko.com/) ([sleepyboy](https://github.com/sleepyboy))
* [Artem Sapegin](http://sapegin.me/) ([sapegin](https://github.com/sapegin))
* [Ezekiel Templin](http://blog.ezkl.org/) ([ezkl](https://github.com/ezkl))
* [Jamie Wilkinson](http://jamiedubs.com) ([jamiew](http://github.com/jamiew))
* Ben Zörb ([bezoerb](https://github.com/bezoerb))
