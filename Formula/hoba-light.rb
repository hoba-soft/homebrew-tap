class HobaLight < Formula
  desc "Command-line backup tool"
  homepage "https://github.com/hoba-soft/hoba-light"
  version "1.2.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/hoba-soft/hoba-light/releases/download/v1.2.0/hobalight_1.2.0_darwin_arm64.tar.gz"
    sha256 "74b1f86a50923eb612f42fa97300eeee4064bf3b9916d6f059c10a377a30f25c"
  end

  on_intel do
    url "https://github.com/hoba-soft/hoba-light/releases/download/v1.2.0/hobalight_1.2.0_darwin_amd64.tar.gz"
    sha256 "fd518393c91e69311b06fb7e0b683d7b7bcc04b588163efd25b8edda67c01deb"
  end

  def install
    bin.install "hobalight", "hl"
    doc.install "README.md", "LICENSE"
    pkgshare.install "configs", "docs"
  end

  test do
    assert_match "hobalight #{version}-", shell_output("#{bin}/hl --version")
    source = testpath/"source"
    source.mkpath
    (source/"note.txt").write "Homebrew backup test"
    ENV["HOBALIGHT_STORAGE"] = (testpath/"storage").to_s
    system bin/"hl", source
    assert_predicate testpath/"storage/store.yaml", :exist?
    assert_match "note.txt", shell_output("#{bin}/hobalight find note")
  end
end
