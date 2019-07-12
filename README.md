<img src="https://d3vv6lp55qjaqc.cloudfront.net/items/0F2U3y3k0z1z0W2y2H0e/git-friendly.jpg" width="100%" style="width:100%" />

A collection of shell scripts for making **pulling**, **pushing**, **branching**, **merging**, and **stashing** with Git fast and painless.

Git sometimes requires typing two or three commands just to execute something basic like fetching new code. git-friendly adds a few new commands — `pull`, `push`, `branch`, `merge` and `stash` which:

* do the most useful thing by default;
* **push** also copies a GitHub compare URL to your clipboard;
* **pull** runs commands like `bundle install`, `npm install`, `yarn install`, and `composer install` if necessary;
* **branch** tracks remote branches if they are available;
* **stash** stashes untracked files by default.

*Less time fighting Git — more time actually doing work.*

## Install

Run this one-liner, which will download the scripts into `/usr/local/bin`:

```bash
curl -sS https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh | bash
```

**Note:** If you don’t have write access to `/usr/local/bin` you’ll need to run this using `sudo`.

You can change the installation directory:

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

You now have new awesome commands: **branch**, **merge**, **pull**, **push** and **stash**:

![](https://d3vv6lp55qjaqc.cloudfront.net/items/3S3H2W1l1F3d1m2x3w1U/pull.png)

Example session:

```bash
pull
branch awesomeness # Create a new branch (or switch to existing one)
echo "BUMP" >> README
git commit -a -m "Righteous bump"
branch master      # Switch back to master
merge awesomeness  # Merge awesomeness branch to master
push               # Push changes
```


## Commands

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

### `stash`

* Stashes untracked files by default, when run without arguments;
* behaves like normal `git stash` otherwise.

```
stash
stash pop
```


## Configuration

To disable `bundle install`, `npm install`, `yarn install`, `bower install` or `composer install` for the `pull` command use environmental variables:

* `GIT_FRIENDLY_NO_BUNDLE`: disables `bundle install`
* `GIT_FRIENDLY_NO_NPM`: disables `npm install`
* `GIT_FRIENDLY_NO_YARN`: disables `yarn install`
* `GIT_FRIENDLY_NO_BOWER`: disables `bower install`
* `GIT_FRIENDLY_NO_COMPOSER`: disables `composer install`

To disable copying URL to clipboard after `push` use the `GIT_FRIENDLY_NO_COPY_URL_AFTER_PUSH` environmental variable.


For example, add this line to your `~/.bash_profile` to disable `bundle install`:

```bash
export GIT_FRIENDLY_NO_BUNDLE=true
```


## Bonus: Pimp Your Configs

We strongly recommend editing your global `~/.gitconfig` and adding features like ANSI color, command aliases (like `git st` instead of `git status`), automatic remote tracking and more. Check out [this sample ~/.gitconfig](https://gist.github.com/668161) to get started.

We also recommend adding the current Git branch to your Terminal prompt (PS1) or you’ll quickly lose your place — here is a [pimp_prompt() bash function](https://gist.github.com/790086) which goes in your `~/.bash_profile` or `~/.bashrc`, then type `source ~/.bashrc` to reload.

![](http://wow.sapegin.me/image/0Z1C1U00281j/pimped-prompt.jpg)



## Bonus: Shell Completion

![](https://d3vv6lp55qjaqc.cloudfront.net/items/1p1U1A2s3P1C0t0p0C0B/completion.png)

### Bash Shell Completion

Add to your shell config file `.bash_profile`, `.bashrc` or `.profile`:

```bash
if type __git_complete &> /dev/null; then
  _branch () {
    delete="${words[1]}"
    if [ "$delete" == "-d" ] || [ "$delete" == "-D" ]; then
      _git_branch
    else
      _git_checkout
    fi
  }

  __git_complete branch _branch
  __git_complete merge _git_merge
fi;
```

Now typing `branch <tab>` will suggest or autocomplete branches you can checkout to, `branch -d <tab>` branches you can delete and `merge <tab>` branches you can merge.

**Note:** You need to call your [git-completion](https://github.com/git/git/blob/0b0cc9f86731f894cff8dd25299a9b38c254569e/contrib/completion/git-completion.bash) script before the snippet.

### Zsh Shell Completion

Add to your `.zshrc`:

```bash
fpath=($(brew --prefix)/share/zsh/functions $fpath)
autoload -Uz _git && _git
compdef __git_branch_names branch
```

Now you can type `branch`, press Tab and you’ll see a list of branches in your repo.

**Note:** You’ll need to adjust the path in the first line if you’re not using Homebrew or macOS.

## License

[MIT license](LICENSE.md).

Fork away, do whatever. Pull requests welcome.

Following the practices of [Rubinius](http://www.programblings.com/2008/04/15/rubinius-for-the-layman-part-2-how-rubinius-is-friendly/), anyone who submits an accepted patch is granted a commit bit (write access to the repository).

Following the practices of [FAT Lab](http://fffff.at), anyone who submits an accepted patch is granted credit and attribution bits.


## Contributors

<!-- To add: npx all-contributors-cli add NAME code -->
<!-- To generate: npx all-contributors-cli generate -->
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars0.githubusercontent.com/u/1903?v=4" width="100px;"/><br /><sub><b>Jamie Wilkinson</b></sub>](http://jamiedubs.com)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=jamiew "Code") [📖](https://github.com/jamiew/git-friendly/commits?author=jamiew "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/70067?v=4" width="100px;"/><br /><sub><b>Artem Sapegin</b></sub>](http://sapegin.me)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=sapegin "Code") [📖](https://github.com/jamiew/git-friendly/commits?author=sapegin "Documentation") | [<img src="https://avatars3.githubusercontent.com/u/692459?v=4" width="100px;"/><br /><sub><b>Maciej Małecki</b></sub>](http://mmalecki.com)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=mmalecki "Code") | [<img src="https://avatars0.githubusercontent.com/u/12213?v=4" width="100px;"/><br /><sub><b>John Manoogian III</b></sub>](http://www.jm3.net)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=jm3 "Code") | [<img src="https://avatars1.githubusercontent.com/u/610598?v=4" width="100px;"/><br /><sub><b>Rafael Corrêa Gomes</b></sub>](https://rafaelstz.github.io)<br />[📖](https://github.com/jamiew/git-friendly/commits?author=rafaelstz "Documentation") | [<img src="https://avatars0.githubusercontent.com/u/707900?v=4" width="100px;"/><br /><sub><b>Harold Dennison</b></sub>](https://github.com/hdennison)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=hdennison "Code") | [<img src="https://avatars0.githubusercontent.com/u/237136?v=4" width="100px;"/><br /><sub><b>Ruan Carlos</b></sub>](http://ruancarlos.com.br)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=ruanltbg "Code") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [<img src="https://avatars1.githubusercontent.com/u/310912?v=4" width="100px;"/><br /><sub><b>Ethan Bruning</b></sub>](https://github.com/ebruning)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=ebruning "Code") | [<img src="https://avatars2.githubusercontent.com/u/40455?v=4" width="100px;"/><br /><sub><b>Ezekiel Templin</b></sub>](http://zeke.templ.in/)<br />[📖](https://github.com/jamiew/git-friendly/commits?author=ezkl "Documentation") | [<img src="https://avatars1.githubusercontent.com/u/676053?v=4" width="100px;"/><br /><sub><b>Andriy</b></sub>](http://andriyprokopenko.com)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=sleepyboy "Code") | [<img src="https://avatars1.githubusercontent.com/u/1697800?v=4" width="100px;"/><br /><sub><b>Ben Zörb</b></sub>](https://github.com/bezoerb)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=bezoerb "Code") | [<img src="https://avatars2.githubusercontent.com/u/14926950?v=4" width="100px;"/><br /><sub><b>Pavel Prichodko</b></sub>](https://github.com/prichodko)<br />[📖](https://github.com/jamiew/git-friendly/commits?author=prichodko "Documentation") | [<img src="https://avatars0.githubusercontent.com/u/1819?v=4" width="100px;"/><br /><sub><b>CJ Lazell</b></sub>](http://cj.io)<br />[💻](https://github.com/jamiew/git-friendly/commits?author=cj "Code") |
<!-- ALL-CONTRIBUTORS-LIST:END -->
