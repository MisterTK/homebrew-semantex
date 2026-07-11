# This formula lives in the homebrew-semantex tap repo:
#   https://github.com/MisterTK/homebrew-semantex
#
# Install:
#   brew tap MisterTK/semantex
#   brew install semantex

class Semantex < Formula
  desc "Semantic code search — hybrid ColBERT + BM25 retrieval engine"
  homepage "https://semantex.dev"
  version "1.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "93c413dd371d38dc0fd4b2dfa2ec1279c9dc45674cf497b38fe023664c3f2b4c"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "50619a186405c06237c184b7b72e13374e05bd835e903dcff2726ea1c88668f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8f977aa76bd457688dcd72b239f91378a1b06cabf36af27fadc2028a9d1d4a39"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96a56d39b22093efbf80f886446d642e252c78bb64728ceeca775cab21b006f6"
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
