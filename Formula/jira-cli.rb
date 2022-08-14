# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.1.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.1.0/jira_1.1.0_macOS_x86_64.tar.gz"
      sha256 "019843cc89185f1e086d43b334623d7d431fefba504b454bb78552e7e81ba269"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.1.0/jira_1.1.0_macOS_arm64.tar.gz"
      sha256 "945d6f45a700783266993844c2e29d193ebda34f5b51733a9d6a12cfb0cc2962"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.1.0/jira_1.1.0_linux_armv6.tar.gz"
      sha256 "9e09a180b6583014c257c0effb79a09622fd5f526f95e7f003b0ed89517a029a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.1.0/jira_1.1.0_linux_arm64.tar.gz"
      sha256 "839c378a07d164c3db65d5db17479d145cb8398fbb6e7745aec37ca232a9679a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.1.0/jira_1.1.0_linux_x86_64.tar.gz"
      sha256 "af61390e1e029ef79b846e17a44fb2763f396965a9aca87a73794e698e5fe239"
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
