# This formula lives in the homebrew-semantex tap repo:
#   https://github.com/MisterTK/homebrew-semantex
#
# Install:
#   brew tap MisterTK/semantex
#   brew install semantex

class Semantex < Formula
  desc "Semantic code search — hybrid ColBERT + BM25 retrieval engine"
  homepage "https://semantex.dev"
  version "1.0.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a47caa89c504debd2dc90665336e2fb220b28130e4d3e6a323ab1753841ce3d5"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a2721cf215ecf3f9bda568c72a17f8dea193df1f692df9fc69bdb6715b467071"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "406237430fe561025af747a80859a8ef3901c7870841f73d9497a646713c145c"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ca5f53393bd30f6c240c51b2325825ce9e807726960e817899802517e61b781e"
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
