class Agenticide < Formula
  desc "The best agentic layer for developers - AI-powered CLI with extension marketplace"
  homepage "https://github.com/ivikasavnish/agenticide-go"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-releases/releases/download/v0.5.0/agenticide-darwin-arm64"
      sha256 "b94a47e001c899e58bc383ae0753962e8c7a8b4f841eb113590fa10477077157"
    else
      url "https://github.com/ivikasavnish/agenticide-releases/releases/download/v0.5.0/agenticide-darwin-amd64"
      sha256 "d496649dd3d423d985560bee7f8272e21a3c814e33cbf56c0504b7b87129eddb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-releases/releases/download/v0.5.0/agenticide-linux-arm64"
      sha256 "520e6d9ad8eb559c19d7b4d197ce9936ad1827bce394d20acd229767d7a68292"
    else
      url "https://github.com/ivikasavnish/agenticide-releases/releases/download/v0.5.0/agenticide-linux-amd64"
      sha256 "b5ec64baf5241c6d67e0b9b0ba1e42097f2f4c72dc90eab7ec5c9c7d95c21302"
    end
  end

  def install
    # The download is a raw binary, not a tarball
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "agenticide-darwin-arm64" : "agenticide-darwin-amd64"
    else
      Hardware::CPU.arm? ? "agenticide-linux-arm64" : "agenticide-linux-amd64"
    end

    # Rename and install the binary
    mv binary_name, "agenticide" if File.exist?(binary_name)
    bin.install "agenticide"
  end

  def post_install
    # Create config directory
    config_dir = "#{ENV["HOME"]}/.agenticide"
    system "mkdir", "-p", config_dir
    system "mkdir", "-p", "#{config_dir}/extensions"

    # Create default config if not exists
    config_file = "#{config_dir}/config.json"
    unless File.exist?(config_file)
      File.write(config_file, <<~JSON
        {
          "version": "0.5.0",
          "default_provider": "openai",
          "extensions_enabled": true
        }
      JSON
      )
    end
  end

  test do
    assert_match "agenticide", shell_output("#{bin}/agenticide --help")
  end

  def caveats
    <<~EOS
      Agenticide v0.5.0 installed!

      Quick Start:
        agenticide              # Start chat (default)
        agenticide --help       # See all commands

      Extension Marketplace:
        agenticide search           # Browse extensions
        agenticide install security # Install extension
        agenticide list             # List installed

      Get started:
        agenticide
    EOS
  end
end
