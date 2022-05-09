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
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta/jira_1.0.0-beta_macOS_x86_64.tar.gz"
      sha256 "6e7223e1f96f23fab2cb05e4497a49295b41184ddf4fad2adef629f9ed27b5b9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta/jira_1.0.0-beta_macOS_arm64.tar.gz"
      sha256 "f93ac34cf3a415fd7fccea97aa20713bd7c0be90eb97549c18873923edde387c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta/jira_1.0.0-beta_linux_armv6.tar.gz"
      sha256 "466132f94ba16cb6cf9bce02d799b558642d0e4051f0fbc903bff05e4d7132d1"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta/jira_1.0.0-beta_linux_arm64.tar.gz"
      sha256 "aca2fc32f8e2ac08056f47b7f3e3c7056252440ec30c92021755ca250c159c58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta/jira_1.0.0-beta_linux_x86_64.tar.gz"
      sha256 "ece1799e4506a069ae069971c8d40071c987754a084212ba28ddbfbd37c6c465"
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
