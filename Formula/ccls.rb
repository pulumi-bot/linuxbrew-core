class Ccls < Formula
  desc "C/C++/ObjC language server"
  homepage "https://github.com/MaskRay/ccls"
  url "https://github.com/MaskRay/ccls/archive/0.20210330.tar.gz"
  sha256 "28c228f49dfc0f23cb5d581b7de35792648f32c39f4ca35f68ff8c9cb5ce56c2"
  license "Apache-2.0"
  revision OS.mac? ? 2 : 3
  head "https://github.com/MaskRay/ccls.git", branch: "master"

  bottle do
    sha256                               arm64_big_sur: "9bc5ac411363a166edfe6e8c92d601251603db9b652134eaed825b8307783595"
    sha256                               big_sur:       "d6d690397129043509c387611145e95fde97198430d2b0a9134449b56092cbe2"
    sha256                               catalina:      "65e953a700d4584ce4dbd2c139f9459e779c53debad7a5719fcfbf8049a7085f"
    sha256                               mojave:        "862f1c950700c8229c6594232dcab1b987863e678551c2505569114a93749c23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa975ec8f166f467c39c1352d4d213120ca4515ac75f029d1fdfdd2b64b79d1d" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "rapidjson" => :build
  depends_on "llvm"
  depends_on macos: :high_sierra # C++ 17 is required

  on_linux do
    depends_on "gcc"
  end

  fails_with gcc: "5"

  def install
    system "cmake", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"ccls", "-index=#{testpath}"
  end
end
