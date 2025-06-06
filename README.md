<img src="https://jamiedubs.com/images/git-friendly/git-friendly-logo.png" width="100%" style="width:100%" />

A collection of shell scripts for making **pulling**, **pushing**, **branching**, **merging**, and **stashing** with Git fast and painless.

Git sometimes requires typing two or three commands just to execute something basic like fetching new code. git-friendly adds a few new commands — `pull`, `push`, `branch`, `merge` and `stash` which:

* does the most useful thing by default; plus
* **push** copies a GitHub compare URL to your clipboard;
* **pull** runs commands like `bundle install`, `npm install`, `yarn install`, `pnpm install` and `composer install` if necessary;
* **branch** tracks remote branches if they are available;
* **stash** includes untracked files by default.

*Less time fighting Git — more time actually doing work.*

## Install

### Homebrew (macOS)

```sh
brew install git-friendly/git-friendly/git-friendly
```

The Homebrew tap for this project [can be found here](https://github.com/git-friendly/homebrew-git-friendly)

### Fedora

Unofficial builds of stable releases can be found in Fedora Copr:
[fuhrmann/git-friendly](https://copr.fedorainfracloud.org/coprs/fuhrmann/git-friendly/).

``` sh
dnf copr enable fuhrmann/git-friendly
dnf install git-friendly
```

### Installer script (curl)

Run this one-liner, which will download the scripts into `/usr/local/bin`:

```sh
curl -sS https://raw.githubusercontent.com/git-friendly/git-friendly/main/install.sh | bash
```

> [!NOTE]
> If you don’t have write access to `/usr/local/bin` you’ll need to run this command using `sudo`.

You can change the installation directory:

```bash
curl -sS https://raw.githubusercontent.com/git-friendly/git-friendly/main/install.sh | bash -s ~/bin/git-friendly
```

## Install from source

Checkout the code:

```sh
git clone git://github.com/git-friendly/git-friendly.git ~/dev/git-friendly
```

Then update your `~/.bash_profile` or `~/.bashrc` to make git-friendly available each time you launch a new terminal:

```sh
export PATH=~/dev/git-friendly:$PATH
```

## Usage

You now have some awesome new commands: **branch**, **merge**, **pull**, **push** and **stash**:

![](https://d3vv6lp55qjaqc.cloudfront.net/items/3S3H2W1l1F3d1m2x3w1U/pull.png)

Example session:

```sh
pull
branch awesomeness # Create a new branch (or switch to existing one)
echo "BUMP" >> README
git commit -a -m "Righteous bump"
branch main        # Switch back to main
merge awesomeness  # Merge awesomeness branch to main
push               # Push changes
```

## Commands

### `branch`

Switch branches or create new local branch if it doesn’t exist. Intelligently sets up remote branch tracking so you can just type `git pull` and not always `git pull origin newbranch`. If no argument specified, will list all local and remote branches.

```sh
branch [name]
```

Supports branch deletion with `-d` or `-D` keys:

```sh
branch -d [name]
branch -D [name]
```

And switching to a previous branch with `-`:

```sh
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
* run `bundle install`, `npm install`, `yarn install`, `pnpm install` or `composer install` if there are any changes in `Gemfile`, `package.json`, etc.

### `push`

* Push your changes to the remote;
* copy a compare URL, like [https://github.com/git-friendly/git-friendly/compare/e96033...5daed4](https://github.com/git-friendly/git-friendly/compare/e96033...5daed4), to your clipboard (works on Mac and Linux).

Any extra arguments will be passed through to `git push`, for example `push -f`.

### `stash`

* Stashes untracked files by default, when run without arguments;
* behaves like normal `git stash` otherwise.

```
stash
stash pop
```

## Configuration

Change git-friendly behavior using environment variables. For example, add this line to your `~/.bash_profile` to disable running `bundle install` in the `pull` command:

```bash
export GIT_FRIENDLY_NO_BUNDLE=true
```

Available environment variables:

| Variable | Description | Commands | Default value |
| --- | --- | --- | --- |
| `GIT_FRIENDLY_NO_BUNDLE` | Disables `bundle install` | `pull` | `false` |
| `GIT_FRIENDLY_NO_COMPOSER` | Disables `composer install` | `pull` | `false` |
| `GIT_FRIENDLY_NO_NPM` | Disables `npm install` | `pull` | `false` |
| `GIT_FRIENDLY_NO_YARN` | Disables `yarn install` | `pull` | `false` |
| `GIT_FRIENDLY_NO_PNPM` | Disables `pnpm install` | `pull` | `false` |
| `GIT_FRIENDLY_NO_REBASE_ON_PULL` | Disables rebasing local commits on top of the updated remote branch | `pull` | `false` |
| `GIT_FRIENDLY_NO_COPY_URL_AFTER_PUSH` | Disables copying URL to clipboard | `push` | `false` |

## Supported package managers for 'pull'

* bundler (ruby)
* composer (PHP)
* npm (JavaScript)
* yarn (JavaScript)
* pnpm (JavaScript)

Support for more is always welcome.

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

> [!NOTE]
> You need to call your [git-completion](https://github.com/git/git/blob/0b0cc9f86731f894cff8dd25299a9b38c254569e/contrib/completion/git-completion.bash) script before this snippet.

### Zsh Shell Completion

Add to your `.zshrc`:

```zsh
fpath=($(brew --prefix)/share/zsh/functions $fpath)
autoload -Uz _git && _git
compdef __git_branch_names branch
```

Now you can type `branch`, press Tab and you’ll see a list of branches in your repo.

> [!NOTE]
> You’ll need to adjust the path in the first line if you’re not using Homebrew or macOS.

## License

[MIT license](LICENSE.md).

Fork away, do whatever. Pull requests welcome.

Following the practices of [Rubinius](http://www.programblings.com/2008/04/15/rubinius-for-the-layman-part-2-how-rubinius-is-friendly/), anyone who submits an accepted patch is granted a commit bit (write access to the repository).

Following the practices of [FAT Lab](http://fffff.at), anyone who submits an accepted patch is granted credit and attribution bits.

## Contributors

<!-- To add: npx all-contributors-cli add NAME code -->
<!-- To generate: npx all-contributors-cli generate -->
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://jamiedubs.com"><img src="https://avatars0.githubusercontent.com/u/1903?v=4?s=100" width="100px;" alt="Jamie Wilkinson"/><br /><sub><b>Jamie Wilkinson</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=jamiew" title="Code">💻</a> <a href="https://github.com/jamiew/git-friendly/commits?author=jamiew" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://sapegin.me"><img src="https://avatars2.githubusercontent.com/u/70067?v=4?s=100" width="100px;" alt="Artem Sapegin"/><br /><sub><b>Artem Sapegin</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=sapegin" title="Code">💻</a> <a href="https://github.com/jamiew/git-friendly/commits?author=sapegin" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://mmalecki.com"><img src="https://avatars3.githubusercontent.com/u/692459?v=4?s=100" width="100px;" alt="Maciej Małecki"/><br /><sub><b>Maciej Małecki</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=mmalecki" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.jm3.net"><img src="https://avatars0.githubusercontent.com/u/12213?v=4?s=100" width="100px;" alt="John Manoogian III"/><br /><sub><b>John Manoogian III</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=jm3" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://rafaelstz.github.io"><img src="https://avatars1.githubusercontent.com/u/610598?v=4?s=100" width="100px;" alt="Rafael Corrêa Gomes"/><br /><sub><b>Rafael Corrêa Gomes</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=rafaelstz" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/hdennison"><img src="https://avatars0.githubusercontent.com/u/707900?v=4?s=100" width="100px;" alt="Harold Dennison"/><br /><sub><b>Harold Dennison</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=hdennison" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://ruancarlos.com.br"><img src="https://avatars0.githubusercontent.com/u/237136?v=4?s=100" width="100px;" alt="Ruan Carlos"/><br /><sub><b>Ruan Carlos</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=ruanltbg" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/ebruning"><img src="https://avatars1.githubusercontent.com/u/310912?v=4?s=100" width="100px;" alt="Ethan Bruning"/><br /><sub><b>Ethan Bruning</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=ebruning" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://zeke.templ.in/"><img src="https://avatars2.githubusercontent.com/u/40455?v=4?s=100" width="100px;" alt="Ezekiel Templin"/><br /><sub><b>Ezekiel Templin</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=ezkl" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://andriyprokopenko.com"><img src="https://avatars1.githubusercontent.com/u/676053?v=4?s=100" width="100px;" alt="Andriy"/><br /><sub><b>Andriy</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=sleepyboy" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/bezoerb"><img src="https://avatars1.githubusercontent.com/u/1697800?v=4?s=100" width="100px;" alt="Ben Zörb"/><br /><sub><b>Ben Zörb</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=bezoerb" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/prichodko"><img src="https://avatars2.githubusercontent.com/u/14926950?v=4?s=100" width="100px;" alt="Pavel Prichodko"/><br /><sub><b>Pavel Prichodko</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=prichodko" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://cj.io"><img src="https://avatars0.githubusercontent.com/u/1819?v=4?s=100" width="100px;" alt="CJ Lazell"/><br /><sub><b>CJ Lazell</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=cj" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://seresigo.com"><img src="https://avatars2.githubusercontent.com/u/30799665?v=4?s=100" width="100px;" alt="Philipp Trubchenko"/><br /><sub><b>Philipp Trubchenko</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=Seresigo" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://ricardof.dev/"><img src="https://avatars.githubusercontent.com/u/1160365?v=4?s=100" width="100px;" alt="Ricardo Fuhrmann"/><br /><sub><b>Ricardo Fuhrmann</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=Fuhrmann" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://elihorne.com/"><img src="https://avatars.githubusercontent.com/u/51566?v=4?s=100" width="100px;" alt="Eli Horne"/><br /><sub><b>Eli Horne</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=elihorne" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://nikkhan.com/"><img src="https://avatars.githubusercontent.com/u/579331?v=4?s=100" width="100px;" alt="Nick Khan"/><br /><sub><b>Nick Khan</b></sub></a><br /><a href="https://github.com/jamiew/git-friendly/commits?author=nicksp" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
