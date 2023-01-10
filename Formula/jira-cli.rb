# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.3.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.3.0/jira_1.3.0_macOS_x86_64.tar.gz"
      sha256 "53fdd850d420abcc1bc55ded056cdff754a084ab6652a729b9b8874deb824e6c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.3.0/jira_1.3.0_macOS_arm64.tar.gz"
      sha256 "0cfc3837da0fef89fd1f46369a6d94c4fcd509022df5f8180eb28652240e6d28"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.3.0/jira_1.3.0_linux_armv6.tar.gz"
      sha256 "33306f785a8f984a0d59bf55443ba7b6a158905b345471891faaa1640163457a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.3.0/jira_1.3.0_linux_arm64.tar.gz"
      sha256 "cf8b5a62ee5a3c79a0db1244f3f1b69b60ad038e2543c641de0932d63a45da34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.3.0/jira_1.3.0_linux_x86_64.tar.gz"
      sha256 "e13d854d0bbcc9379c65d13aa1e8a299d9ea2a36ad4a86b457f99eed184a1891"
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
