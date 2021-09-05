class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "0.0.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.0.0/jira_0.0.0_macOS_arm64.tar.gz"
      sha256 "1128decd52f3556feb00dbe3ad617545ed2966d3307f8b8f5e365adcd4c14b4d"
    else
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.0.0/jira_0.0.0_macOS_x86_64.tar.gz"
      sha256 "a0832bceb9087ce886fe2f0c2cb11654e023c93833738b806f429e06681cac5a"
    end
  end

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  bottle :unneeded

  def install
    system "make" if build.head?
    bin.install File.exist?("bin/jira") ? "bin/jira" : "jira"
    (bash_completion/"jira.sh").write `#{bin}/jira completion bash`
    (zsh_completion/"_jira").write `#{bin}/jira completion zsh`
  end

  test do
    help_text = shell_output("#{bin}/jira --help")
    assert_includes help_text, "Usage:"
  end
end
