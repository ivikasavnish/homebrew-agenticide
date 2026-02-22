class Agenticide < Formula
  desc "AI-powered development assistant with extension marketplace"
  homepage "https://github.com/ivikasavnish/agenticide-go"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-arm64"
      sha256 "bdfbe71a360630b3bb1de2de16cca93a2e5073e1107c48d7b7864dd919affa8c"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-amd64"
      sha256 "8b830376851ebd8c9799bd22e6c9047a022fc4c3f44ae85e04f69d550c750184"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-arm64"
      sha256 "6ab4373f4a66983e9538a1aea7bd81fe9055bf38e756969b39d3fe335616e669"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-amd64"
      sha256 "ad89bba51b6cd35b59757096c55a9fc7e638bfc9c516870baab3ba5a819050ae"
    end
  end

  def install
    bin.install "agenticide-darwin-arm64" => "agenticide" if OS.mac? && Hardware::CPU.arm?
    bin.install "agenticide-darwin-amd64" => "agenticide" if OS.mac? && Hardware::CPU.intel?
    bin.install "agenticide-linux-arm64" => "agenticide" if OS.linux? && Hardware::CPU.arm?
    bin.install "agenticide-linux-amd64" => "agenticide" if OS.linux? && Hardware::CPU.intel?
  end

  test do
    assert_match "0.", shell_output("#{bin}/agenticide --version")
  end

  def caveats
    <<~EOS
      🎉 Agenticide v0.5.0 installed!
      
      🚀 First Run - Setup Wizard:
        Run 'agenticide' to start the setup wizard:
        ✓ Enter your email and phone
        ✓ Choose AI provider (OpenAI, Anthropic, Copilot, Ollama)
        ✓ Configure API key
        
        After setup, launches directly into chat!
      
      💡 Extension Marketplace (12+ extensions):
        agenticide search           # Browse extensions
        agenticide install security # Install extension
        agenticide list             # List installed
      
      📖 Docs: https://github.com/ivikasavnish/agenticide-go
    EOS
  end
end
