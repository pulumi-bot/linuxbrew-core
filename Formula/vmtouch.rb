class Vmtouch < Formula
  desc "Portable file system cache diagnostics and control"
  homepage "https://hoytech.com/vmtouch/"
  url "https://github.com/hoytech/vmtouch/archive/v1.3.1.tar.gz"
  sha256 "d57b7b3ae1146c4516429ab7d6db6f2122401db814ddd9cdaad10980e9c8428c"
  head "https://github.com/hoytech/vmtouch.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6d55c8a93a6826d78dcd439155de21e3da33598bd00c022e1fb4d39635f12c53"
    sha256 cellar: :any_skip_relocation, big_sur:       "89ed86d067750e6bf19a6a79d7f3b9c3b2ad2e39795f174ba2452d11d43f650e"
    sha256 cellar: :any_skip_relocation, catalina:      "30c620a4dc06285c41c7194468de50cf0f12aab38c6441d8e1bbad6d4231ee1e"
    sha256 cellar: :any_skip_relocation, mojave:        "020d4e624a448e4e1b9a6e26b8f506bd65ab789ae1c0f23f25beda78b09bc6dd"
    sha256 cellar: :any_skip_relocation, high_sierra:   "edb14ca1ff4cbd4ab535ca9099ea113a36e280ddaf2957a65bdef10f4a7a1b88"
    sha256 cellar: :any_skip_relocation, sierra:        "7359ed3256886940e6fb1883141c495d5b3e6ab28130ed16553e0f6ab57ac3db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55ec1c830415be7e6e7b01947028f631fa3674d178f09959ae5f58b42a9594d1" # linuxbrew-core
  end

  # Upstream change broke macOS support in 1.3.1, patch submitted upstream and accepted.
  # Remove patch in next release.
  patch do
    url "https://github.com/hoytech/vmtouch/commit/75f04153601e552ef52f5e3d349eccd7e6670303.patch?full_index=1"
    sha256 "9cb455d86018ee8d30cb196e185ccc6fa34be0cdcfa287900931bcb87c858587"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man}"
  end

  test do
    system bin/"vmtouch", bin/"vmtouch"
  end
end
