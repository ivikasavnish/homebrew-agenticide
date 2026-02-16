class Agenticide < Formula
  desc "AI-powered development CLI with API testing, SQL queries, and intelligent hints"
  homepage "https://github.com/ivikasavnish/agenticide"
  version "3.1.0"
  license "MIT"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide/releases/download/v3.1.0/agenticide-darwin-arm64.tar.gz"
      sha256 "25096b2ce939740883ecb38ef5fa1380348389126ed59210f4d470bfca4ebc45"
    else
      url "https://github.com/ivikasavnish/agenticide/releases/download/v3.1.0/agenticide-darwin-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_X64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ivikasavnish/agenticide/releases/download/v3.1.0/agenticide-linux-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_ARM64"
    else
      url "https://github.com/ivikasavnish/agenticide/releases/download/v3.1.0/agenticide-linux-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_X64"
    end
  end

  def install
    bin.install "agenticide"
    
    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
    doc.install "RELEASE_NOTES.md" if File.exist?("RELEASE_NOTES.md")
    if Dir.exist?("docs")
      doc.install "docs"
    end
  end

  def post_install
    # Create config directory in user's home
    config_dir = "#{ENV["HOME"]}/.agenticide"
    unless File.directory?(config_dir)
      system "mkdir", "-p", config_dir
      system "mkdir", "-p", "#{config_dir}/sessions"
    end
    
    # Create default config
    config_file = "#{config_dir}/config.json"
    unless File.exist?(config_file)
      File.write(config_file, <<~JSON
        {
          "version": "3.1.0",
          "extensions_enabled": true,
          "auto_hint": true
        }
      JSON
      )
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agenticide --version")
    output = shell_output("#{bin}/agenticide --help")
    assert_match "AI Coding Assistant", output
  end

  def caveats
    <<~EOS
      🎉 Agenticide has been installed!
      
      🚀 Quick Start:
        agenticide              # Start interactive chat
        agenticide --help       # See all commands
      
      💡 Features:
        • API Testing     (/api get <url>)
        • SQL Queries     (/sql connect sqlite ./db.db)
        • Smart Hints     (Press Tab for autocomplete)
        • Code Generation (/stub <name> <language>)
        • Process Manager (/process start <command>)
      
      📖 Try:
        agenticide
        You: /help
        You: /api get https://api.github.com/zen
    EOS
  end
end
