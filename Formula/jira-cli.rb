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
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.1/jira_1.0.0-beta.1_macOS_x86_64.tar.gz"
      sha256 "cb1bfaebc534a1d2af86a6cf422c9aa155e878dd09cd0b9dfc99705901b7b50c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.1/jira_1.0.0-beta.1_macOS_arm64.tar.gz"
      sha256 "13a2b0efba3a76cc25d16e7e952ebef986981668ac0899a7932365a4b6cf0b0c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.1/jira_1.0.0-beta.1_linux_armv6.tar.gz"
      sha256 "cd2e3e14c9e34d8100eb6a5cdced8276cb9b0f6e0e80a4fc91b756e4a00497f3"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.1/jira_1.0.0-beta.1_linux_arm64.tar.gz"
      sha256 "3967c9cba56be644e568584e8e288a45b02ab981659ee589762d310999bbf68e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.1/jira_1.0.0-beta.1_linux_x86_64.tar.gz"
      sha256 "9e02d52f3c66c8b8f7d368e30403a25d70248a36804c7802718858869f421a08"
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
