class StressNg < Formula
  desc "Stress test a computer system in various selectable ways"
  homepage "https://kernel.ubuntu.com/~cking/stress-ng/"
  url "https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.10.19.tar.xz"
  sha256 "0f0db52513df9c49a39af87195d27ec9db7472e641279319323d07c874c1056d"

  bottle do
    cellar :any_skip_relocation
    sha256 "901865f8c6e717a6c12868149d0ced06ed8112053ebf5c2ff6e57e5af116aae6" => :catalina
    sha256 "f43bf829019c40c326ae5c417adcd2f686748cdf018fe2df6958715332ae99a8" => :mojave
    sha256 "4ab0752bc4e68c923b03108eb35d6db68f3e357b5b465414d4cb979605dc3c89" => :high_sierra
    sha256 "6f4330f4d403a64c46f94e2a390b1ca8093f1df6c5af7cad8d90ea255a01da52" => :x86_64_linux
  end

  depends_on :macos => :sierra if OS.mac?
  uses_from_macos "zlib"

  def install
    inreplace "Makefile", "/usr", prefix
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/stress-ng -c 1 -t 1 2>&1")
    assert_match "successful run completed", output
  end
end
