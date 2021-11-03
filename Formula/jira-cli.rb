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
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.1/jira_0.1.1_macOS_x86_64.tar.gz"
      sha256 "636f31773f2a05a3c92042dd34a0ffc010ba665466fe91d906895d163e876af4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.1/jira_0.1.1_macOS_arm64.tar.gz"
      sha256 "32d857ace28f9798df3e0b30475fe2f95749e6e4f44d7fa281c2aa5e7cf4e5c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.1/jira_0.1.1_linux_armv6.tar.gz"
      sha256 "dfb3787eb705d222e2d05a2a6a1bd00730700c57c8f1ab8b3527c91f38b4ec93"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.1/jira_0.1.1_linux_arm64.tar.gz"
      sha256 "b7c09942790c5f746099165efcde4049255af3712cc5ebd00b21d65ddc273a07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.1/jira_0.1.1_linux_x86_64.tar.gz"
      sha256 "7ea03cd1ca6f7bcd18ae2e131cb526168fc2914ec302dbed8c7be46914effcd7"
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
