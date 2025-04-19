# typed: false
# frozen_string_literal: true

class JiraCli < Formula
  desc "Feature-rich interactive Jira command-line"
  homepage "https://github.com/ankitpokhrel/jira-cli"
  version "1.6.0"
  license "MIT"

  head do
    url "https://github.com/ankitpokhrel/jira-cli.git", branch: "main"
    depends_on "go"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_macOS_x86_64.tar.gz"
      sha256 "8c6b20d1c3b4a8a09ef85347d8de656ce38da26170727a15660951011487a6ca"
    end
    if Hardware::CPU.arm?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_macOS_arm64.tar.gz"
      sha256 "83fa573be5721755f11bbeeb78a4a55d439b983d4d6ddb367eb6652c48842ba6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_linux_armv6.tar.gz"
      sha256 "968a6c49f98a655f682e74bfd0fa033e11da106c2c21dfeb4fadde0185b880b9"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_linux_arm64.tar.gz"
      sha256 "a68070e2461ac672fbc9284736db9f3fbf40e52f695dfb96be1fe10c5c1fba48"
    end
    if Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_linux_i386.tar.gz"
      sha256 "9ccdd68ea71b0c3a9565f7906b55a996db9f754e4ebaf45f10c64244bd5cfcb5"
    end
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/ankitpokhrel/jira-cli/releases/download/v1.6.0/jira_1.6.0_linux_x86_64.tar.gz"
      sha256 "9702ac03198fc389aa92b2500ee278ffdecb7064f2accca7aea4086323ad5352"
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
