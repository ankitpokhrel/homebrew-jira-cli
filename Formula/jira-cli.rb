# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.5.1"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.1/jira_1.5.1_macOS_x86_64.tar.gz"
      sha256 "6f2331700d48bebebe6b6bece3bda839fa30e43b5b145062ac0eb94c3f9b51db"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.1/jira_1.5.1_macOS_arm64.tar.gz"
      sha256 "ba0b04a86928808a8fdc80bc210f2621246b4fea237de3f4ec84d495f8de5641"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.1/jira_1.5.1_linux_armv6.tar.gz"
      sha256 "fdae6b08536a211a209d8ff65ba538fe5f9f2d37a8270c05f3d814dbd7417170"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.1/jira_1.5.1_linux_arm64.tar.gz"
      sha256 "d1c8173b18fdbcbe5d5acb10a6781f40f9b439ff7061f2d7b0c71d0ac0858eed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.1/jira_1.5.1_linux_x86_64.tar.gz"
      sha256 "1dfe69a3156afcfff25e7755df1508ea9a72762942904899ad8edad1799182a1"
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
