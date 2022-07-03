# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.0.0-beta"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0/jira_1.0.0_macOS_x86_64.tar.gz"
      sha256 "a74a92cad800f6820a8133c96f228fe6f23dc6df56f6b645c2bfeeaaee847e25"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0/jira_1.0.0_macOS_arm64.tar.gz"
      sha256 "f8d2d92a111755adb77194c2bded451e58279b8e58c5291014615597196d2764"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0/jira_1.0.0_linux_armv6.tar.gz"
      sha256 "97ca651b51690158272e3b779e4c6a074376eb13d39a11a89173f151be14d91f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0/jira_1.0.0_linux_arm64.tar.gz"
      sha256 "95f885fcf06f7c1b5837556aabfbd7f429770771aabf68403953aafb89dfc19f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0/jira_1.0.0_linux_x86_64.tar.gz"
      sha256 "13e179f241547a9f8f206f351ebcfa7b31aea2aa742ae04da1da72b7a84620da"
    end
  end

  def install
    if build.head?
      system "make", "install"
      bin.install ENV["GOPATH"] + "/bin/jira"
    else
      bin.install File.exist?("bin/jira") ? "bin/jira" : "jira"
    end
  end

  test do
    help_text = shell_output("#{bin}/jira version")
    assert_includes help_text, "Version=\"#{version}\""
  end
end
