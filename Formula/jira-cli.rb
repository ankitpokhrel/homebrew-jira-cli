# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.5.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.0/jira_1.5.0_macOS_x86_64.tar.gz"
      sha256 "8ae2d70196ed89df9235ac327db3b4abc14bddc810791a5efb291b50451ed488"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.0/jira_1.5.0_macOS_arm64.tar.gz"
      sha256 "3618b22d85d54eb04368107d3e388f2907018757f940718aa0cfb90ef56ca7d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.0/jira_1.5.0_linux_armv6.tar.gz"
      sha256 "bc99b41e1cfe2035da355b3c5a2d7b06819c2653ece63ed5ee01074565b64bd2"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.0/jira_1.5.0_linux_arm64.tar.gz"
      sha256 "9fc13576a35ab2c84f4aeacec2c6d87e94027ee0933b0fbfba804291d547e99b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.0/jira_1.5.0_linux_x86_64.tar.gz"
      sha256 "4545c4715c17901430655797759643d7e86daf3c78f5b1a2406ebfca24fcc3ef"
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
