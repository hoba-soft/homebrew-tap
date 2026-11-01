class HobaLight < Formula
  desc "Command-line backup tool"
  homepage "https://github.com/hoba-soft/hoba-light"
  version "1.1.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/hoba-soft/hoba-light/releases/download/v1.1.0/hobalight_1.1.0_darwin_arm64.tar.gz"
    sha256 "9076b51b33799797336e64dcc89756824560d36c439a7db0485fa8cb8b523995"
  end

  on_intel do
    url "https://github.com/hoba-soft/hoba-light/releases/download/v1.1.0/hobalight_1.1.0_darwin_amd64.tar.gz"
    sha256 "8074f5be6c01482f4f0ecefd8fb0c5f340f9ff521247246c2a64340b60dd1d67"
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
