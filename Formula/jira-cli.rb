# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.7.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_macOS_x86_64.tar.gz"
      sha256 "c2cb2f6b440522ec73439ec9a10f4a194b78e4c409341d18da3f91dfef59d090"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_macOS_arm64.tar.gz"
      sha256 "f9c75d1b242a4cbd78fc49c00c9854c3856f1bd421bdf196c567b3bb71ccf527"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_linux_armv6.tar.gz"
      sha256 "05e17dbf67e74f9919ac27c9f8d185fc916a1b9c01767edf01588f478f3eaf38"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_linux_arm64.tar.gz"
      sha256 "80aa3cc02790892b29e1580a8e49eb49a6550815b362c5ef8c05aea1dee73a95"
    end
    if Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_linux_i386.tar.gz"
      sha256 "e0136f58465a13ca059e87b58d0e97eedb26080c271b743d55ba6aadf43a793f"
    end
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.7.0/jira_1.7.0_linux_x86_64.tar.gz"
      sha256 "b5e0ba4804f3f11f92c483d9a6ea9ebccec1c735cd2e12b0440cab9d7afd626a"
    end
  end

  def install
    if build.head?
      system "make", "install"
      bin.install ENV["GOPATH"] + "/bin/jira"
    else
      bin.install File.exist?("bin/jira") ? "bin/jira" : "jira"
    end
    generate_completions_from_executable(bin/"jira", "completion", shells: [:bash, :zsh, :fish])
  end

  test do
    help_text = shell_output("#{bin}/jira version")
    assert_includes help_text, "Version=\"#{version}\""
  end
end
