class Agentmode < Formula
  desc "Keep a MacBook awake for coding agents, lid open or closed, with safety pauses"
  homepage "https://github.com/ULookLookMe/agent-mode"
  url "https://github.com/ULookLookMe/agent-mode/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0f954b3585389c4b94a646386458eff3d4fe2ca3c014f60cc28016fe66ce5a67"
  license "MIT"
  head "https://github.com/ULookLookMe/agent-mode.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :golden_gate
  uses_from_macos "swift" => :build

  def install
    # std_swift_args includes --disable-sandbox: SwiftPM's sandbox cannot run inside Homebrew's.
    system "swift", "build", *std_swift_args
    bin.install ".build/release/agentmode"
    pkgshare.install "scripts/setup-privileges.sh"
  end

  def caveats
    <<~EOS
      agentmode needs a sudoers rule for exactly two pmset commands. Run once:
        zsh #{opt_pkgshare}/setup-privileges.sh
      It shows the rule, asks for your administrator password and starts the background process.

      After every `brew upgrade agentmode`, run `agentmode install`.
      Before `brew uninstall agentmode`, run:
        zsh #{opt_pkgshare}/setup-privileges.sh --uninstall
    EOS
  end

  test do
    ENV["AGENTMODE_DRY_RUN"] = "1"
    ENV["AGENTMODE_STATE_DIR"] = testpath
    assert_equal "agentmode #{version}", shell_output("#{bin}/agentmode --version").strip
    assert_match "Mode: off", shell_output("#{bin}/agentmode status")
  end
end
