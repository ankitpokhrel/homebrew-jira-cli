# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.2.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.2.0/jira_1.2.0_macOS_x86_64.tar.gz"
      sha256 "d5f4c4db2f07db6090da151dda29157b6fa54f1baec0d4fac50459d6ad83aaa0"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.2.0/jira_1.2.0_macOS_arm64.tar.gz"
      sha256 "9f6a42c909c8a409aca92a8f14d9568b66d65524ca9cfceb57129195d13dcaa5"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.2.0/jira_1.2.0_linux_armv6.tar.gz"
      sha256 "75cc5fdaef4b2796338fd15b902b507001012e9d03cf6c0faf6830b27d49d8d4"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.2.0/jira_1.2.0_linux_arm64.tar.gz"
      sha256 "1ef5d4b320c6e6599398339f1ae4cdf0db2dc6d017ccf4214b9652879467cc56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.2.0/jira_1.2.0_linux_x86_64.tar.gz"
      sha256 "dd26cd8f5e26ae8ba8296954c61c206b34e88e86ddf04c1af3f536a0e2884f08"
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
