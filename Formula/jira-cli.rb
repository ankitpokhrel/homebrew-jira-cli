# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "0.1.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.0/jira_0.1.0_macOS_x86_64.tar.gz"
      sha256 "c8d99498392108afbe103e9d63aaf8697377743cb5f8aa81674b90c81d6c45eb"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.0/jira_0.1.0_macOS_arm64.tar.gz"
      sha256 "aa6b38ac7b8f5026b8de0a0a4a69ceb63561baa43d6fcfa723b7299057e12b6a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.0/jira_0.1.0_linux_arm64.tar.gz"
      sha256 "b9bdad9bb48bc94810ac941395ddc2eb6469b8c518ed505a70e26e2aafdf231e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.0/jira_0.1.0_linux_x86_64.tar.gz"
      sha256 "750c48bf6abc088378a472f60e92ddf500706ab65d88478dfe459766714d04af"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v0.1.0/jira_0.1.0_linux_armv6.tar.gz"
      sha256 "c887a81aed3a0b8db69ec6ef56e6c7e7744e86c672df68a97fff3ff7f58a1433"
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
