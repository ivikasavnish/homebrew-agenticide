class Agenticide < Formula
  desc "AI-powered development assistant with extension marketplace"
  homepage "https://github.com/ivikasavnish/agenticide-go"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-arm64"
      sha256 "9140ad490a92fb30d8b23a4920a4572a4162e06adad34fa20c1cee70b51a126c"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-darwin-amd64"
      sha256 "f7035b7358c2e2e9374b83f087b3df181eb1df88ab2f5c89c3fbe1ed6b3ff186"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-arm64"
      sha256 "f66d27f36ef4f6549a614bd41c5c1a8dbd4fc8bb8779ce9cce75d54504a04d52"
    else
      url "https://github.com/ivikasavnish/agenticide-go/releases/download/v0.5.0/agenticide-linux-amd64"
      sha256 "4b203a3890d8d2f654334dc2f91da8c30c668470b18694a7fe8f19acad8b070e"
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
      
      🚀 Quick Start:
        agenticide search           # Browse extensions
        agenticide install security # Install extension
        agenticide chat             # Start AI chat
        agenticide --help           # Show all commands
      
      💡 Extension Marketplace (12+ extensions):
        security, code-analyzer, project-runner, web-search,
        test-generator, git-ops, ai-recipes, deployment,
        monitoring, cost-controller, db-analytics, ui-design
      
      📖 Documentation:
        https://github.com/ivikasavnish/agenticide-go
    EOS
  end
end
