# This formula lives in the homebrew-semantex tap repo:
#   https://github.com/MisterTK/homebrew-semantex
#
# Install:
#   brew tap MisterTK/semantex
#   brew install semantex

class Semantex < Formula
  desc "Semantic code search — hybrid ColBERT + BM25 retrieval engine"
  homepage "https://semantex.dev"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f9dd8d7a2d9d4b631b1693f3f71cd72991aa278ea6638caf7e3f6ff005ce0cfe"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ce294108e9f28d002922ef2ebd85564e96f03e0256d7a195457e1231a50c8d71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cbca8aea74d320bcf4190774f6c28049f08100a7f223f53f096d7bd4a19c028f"
    end
    on_intel do
      url "https://github.com/MisterTK/semantex/releases/download/v#{version}/semantex-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b9dbbe9d1e03ac332858c94324daf7751b634ee549b868f8644056307815cd1b"
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
