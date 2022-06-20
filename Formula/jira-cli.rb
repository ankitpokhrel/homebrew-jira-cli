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
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.2/jira_1.0.0-beta.2_macOS_x86_64.tar.gz"
      sha256 "b670a0a88e54a6fe192e880192fb3ef3db23028981d42438276140e25e1c07f0"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.2/jira_1.0.0-beta.2_macOS_arm64.tar.gz"
      sha256 "464745ca37db27c194699e2ff620feae08f1af8d1bf613c98be95a9dd6199fe3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.2/jira_1.0.0-beta.2_linux_armv6.tar.gz"
      sha256 "e860fbbdc1216d3774d6427bce6610f8832b92cdc1c54cc2eaa677acc84fa6f6"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.2/jira_1.0.0-beta.2_linux_arm64.tar.gz"
      sha256 "48d4757b758276166eece8af07cf28d0dda80489ce620c9ec06694335835ace2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.0.0-beta.2/jira_1.0.0-beta.2_linux_x86_64.tar.gz"
      sha256 "8b388aa7a6b142fd96db7c9794cc3b3f1aaff4452874a41457d9dfe075a67e40"
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
