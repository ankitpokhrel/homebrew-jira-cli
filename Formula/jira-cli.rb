# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.5.2"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_macOS_x86_64.tar.gz"
      sha256 "d1158338225b263c40fb4c60835e9241c135af1049e9dc35061f5a19db9c03f4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_macOS_arm64.tar.gz"
      sha256 "47654bd51faad87a7679a90f627824b95faa16b116dc2ea074cd4f1640bfdbbc"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_linux_armv6.tar.gz"
      sha256 "17e8b6b6e8bd481263aae41f85ede1cdf0ace3be1b9f4d392c8b1a8b03ac64d5"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_linux_arm64.tar.gz"
      sha256 "72b488f8c635fd74f377d155646eacb24f700820274a9dba248f62aad69bfc7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_linux_x86_64.tar.gz"
      sha256 "a0b3dbfd1eb64e217a2a74a3f79179328b5debf61d6be8a3ed0d0014bd51512a"
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
