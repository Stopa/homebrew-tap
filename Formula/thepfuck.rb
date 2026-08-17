class Thepfuck < Formula
  desc "Correct failed shell commands using apfel's on-device AI"
  homepage "https://github.com/Stopa/thepfuck"
  url "https://github.com/Stopa/thepfuck/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_CHECKSUM"
  license "MIT"
  head "https://github.com/Stopa/thepfuck.git", branch: "main"

  depends_on "apfel"
  depends_on xcode: ["26.4", :build]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "swift", "build",
           "--disable-sandbox",
           "--configuration", "release"

    bin.install ".build/release/thepfuck"
  end

  def caveats
    <<~EOS
      Add thepfuck to zsh by placing this in ~/.zshrc:

        eval "$(thepfuck --alias pfuck)"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/thepfuck --version")

    ENV["SHELL"] = "/bin/zsh"
    assert_match "command thepfuck --history",
                 shell_output("#{bin}/thepfuck --alias pfuck")
  end
end
