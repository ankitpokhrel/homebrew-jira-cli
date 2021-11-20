# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "0.1.1"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.2.0/jira_0.2.0_macOS_x86_64.tar.gz"
      sha256 "bd725519c81c20254758e7606d528e0eb553113b8f5362006f09f2f5d214441c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.2.0/jira_0.2.0_macOS_arm64.tar.gz"
      sha256 "de2d5611654af4735f7a7b47312725dd19a1bea654d68e3a391f4b95d1202266"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.2.0/jira_0.2.0_linux_armv6.tar.gz"
      sha256 "21ad860f9a48b40d882204d25063ac85c8130e2b1a89b3e7c04e15ea11181292"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.2.0/jira_0.2.0_linux_arm64.tar.gz"
      sha256 "7c8a6b5a3f350d0fa1d6f84630a8556447ca4599d0e9159e0ce26958f83c4724"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.2.0/jira_0.2.0_linux_x86_64.tar.gz"
      sha256 "45fe25922193b72920c8b840b9792ef86c8f59d10304fd3bdde85b5b1f0d7a57"
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
