class GitFriendly < Formula
  desc "Streamline your Git workflow"
  homepage "https://github.com/git-friendly/git-friendly"
  url "https://github.com/git-friendly/git-friendly/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "214337068f7e2157ef5244dac2493450ff96f57e9e0f2d47528db178fb3d76b1"
  license "MIT"

  depends_on "git"

  uses_from_macos "ncurses"

  def install
    bin.install "branch", "merge", "pull", "push", "stash"
  end

  test do
    ENV["TERM"] = "xterm"
    ENV["GIT_CONFIG_NOSYSTEM"] = "1"
    ENV["GIT_CONFIG_GLOBAL"] = (testpath/".gitconfig").to_s
    (testpath/".gitconfig").write <<~EOS, mode: "a"
      [user]
        name = Homebrew Test
        email = test@example.com
      [commit]
        gpgsign = false
    EOS

    system "git", "init", "--bare", "--initial-branch=main", "remote.git"
    system "git", "clone", testpath/"remote.git", "work"

    cd "work" do
      Pathname("README").write "Initial content\n"
      system "git", "add", "README"
      system "git", "commit", "--no-gpg-sign", "-m", "Initial commit"
      system bin/"push"
      assert_equal shell_output("git rev-parse HEAD").strip,
                   shell_output("git --git-dir=../remote.git rev-parse main").strip

      system bin/"branch", "feature"
      assert_equal "feature", shell_output("git branch --show-current").strip
      Pathname("feature.txt").write "Feature content\n"
      system "git", "add", "feature.txt"
      system "git", "commit", "--no-gpg-sign", "-m", "Add feature"
      system bin/"branch", "main"
      system bin/"merge", "feature"
      assert_equal "main", shell_output("git branch --show-current").strip
      assert_equal "Feature content\n", Pathname("feature.txt").read

      File.write "README", "Local changes\n"
      Pathname("untracked.txt").write "Untracked content\n"
      system bin/"stash"
      assert_equal "Initial content\n", Pathname("README").read
      refute_path_exists "untracked.txt"
      system bin/"stash", "pop"
      assert_equal "Local changes\n", Pathname("README").read
      assert_equal "Untracked content\n", Pathname("untracked.txt").read
    end

    system "git", "clone", testpath/"remote.git", "peer"
    cd "peer" do
      Pathname("remote.txt").write "Remote content\n"
      system "git", "add", "remote.txt"
      system "git", "commit", "--no-gpg-sign", "-m", "Add remote change"
      system "git", "push"
    end

    cd "work" do
      system bin/"pull"
      assert_equal "Remote content\n", Pathname("remote.txt").read
      assert_equal "Feature content\n", Pathname("feature.txt").read
      assert_equal "Local changes\n", Pathname("README").read
      assert_equal "Untracked content\n", Pathname("untracked.txt").read
    end
  end
end
