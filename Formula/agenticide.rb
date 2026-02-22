class Agenticide < Formula
  desc "AI-powered development assistant with extension marketplace"
  homepage "https://github.com/ivikasavnish/agenticide-go"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-arm64"
      sha256 "ee215cf9a4e783ededcb5d7ee98d3507ff79a4db94a87dbbf21b3144d1370ab4"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-amd64"
      sha256 "d75d52de85a9f466898387f33425c47f848e1724f3b0d8e44520b96b324b6266"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-arm64"
      sha256 "b6b9aca2a81c1f77d6bb2e685197f89c20e02eb9286287715649c9edbbc0143f"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-amd64"
      sha256 "8a3ca775730d1a28989127d350f394acd52061c369b58194aa29ce2aecf4f6fd"
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
      🎉 Agenticide Go v0.5.0 installed!
      
      🚀 First Run:
        Run 'agenticide' and follow the setup wizard to:
        - Enter your email and phone
        - Choose AI provider (OpenAI, Anthropic, Copilot, Ollama)
        - Configure API key
      
      💡 Extension Marketplace (12+ extensions):
        agenticide search           # Browse extensions
        agenticide install security # Install extension
        agenticide list             # List installed
      
      📖 Documentation:
        https://github.com/ivikasavnish/agenticide-go
    EOS
  end
end
