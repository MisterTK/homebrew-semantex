# This formula lives in the homebrew-semantex tap repo:
#   https://github.com/MisterTK/homebrew-semantex
#
# Install:
#   brew tap MisterTK/semantex
#   brew install semantex

class Semantex < Formula
  desc "Semantic code search — hybrid ColBERT + BM25 retrieval engine"
  homepage "https://semantex.dev"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "dcbc4591a64965fc1f388407b3473d753ad90e0224c361c51364806fec8561d8"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d71c3988cc58a923904972304d05eb2ce7c83df69127e4b926ebea0eb0793d6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2083ec1baf3c6e73c242b7c564a4e4f9a361e2a57b6d624c413a6037588f40f"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cbc9977325bf60cc04faa3f72b1650bef55b0c2313321df380d8b4dbfc79d786"
    end
  end

  def install
    bin.install "semantex"
    # ONNX Runtime dylib must live next to the binary for runtime loading
    Dir["libonnxruntime*"].each { |lib| bin.install lib }
  end

  def caveats
    <<~EOS
      To integrate with your AI coding tool, run:
        semantex install-claude-code   # Claude Code
        semantex install-codex         # Codex CLI
        semantex install-opencode      # OpenCode

      To disable anonymous usage telemetry:
        export SEMANTEX_NO_TELEMETRY=1
    EOS
  end

  test do
    system "#{bin}/semantex", "--version"
  end
end
