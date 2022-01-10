# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "0.3.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.3.0/jira_0.3.0_macOS_x86_64.tar.gz"
      sha256 "318a53bda6e1eef5aa9073bb5addcce5bbfe21280862fcfafe568657a877d33e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.3.0/jira_0.3.0_macOS_arm64.tar.gz"
      sha256 "acb77613faf83d9d93de574ae70ed10cac3333d0d4b1770b68263f21c1616996"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.3.0/jira_0.3.0_linux_armv6.tar.gz"
      sha256 "a264f3094ce7913602db037d9103539e32043e51dfcac23e3ff3ffacce37da42"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.3.0/jira_0.3.0_linux_arm64.tar.gz"
      sha256 "258f9e35f047b17115d2d327c88648dee2709b357c7fce29d26886c56a5b1a3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.3.0/jira_0.3.0_linux_x86_64.tar.gz"
      sha256 "7d5a6ad89aa19b86699a8bc305a8e5259f3e6f080e793612df6bb405fd223bf5"
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
