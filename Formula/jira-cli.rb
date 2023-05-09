# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "🔥 Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.4.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_macOS_x86_64.tar.gz"
      sha256 "00dfed65840bc399cdf55e598d0d85d24de0f070be3803c0801b2bb8f7c372a9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_macOS_arm64.tar.gz"
      sha256 "9503d084743d96d45ec7799f40b32895eaf06135051dfc47e835724582f36e83"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_linux_armv6.tar.gz"
      sha256 "2f323ea69015fd5d5d1d21c960a2d77078837614ea2185f2377c689b942f703f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_linux_arm64.tar.gz"
      sha256 "d0b328d1330b673081a0ee4d74f18835967006c530dd942d2674e6d115e42014"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_linux_x86_64.tar.gz"
      sha256 "34f2aee621d2555d0e7e305a95e851dbb3bac695e893e95a339666a5d84da48d"
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
