class Shairport < Formula
  desc "Airtunes emulator"
  homepage "https://github.com/abrasive/shairport"
  url "https://github.com/abrasive/shairport/archive/1.1.1.tar.gz"
  sha256 "1b60df6d40bab874c1220d7daecd68fcff3e47bda7c6d7f91db0a5b5c43c0c72"
  license "MIT"
  revision 1
  head "https://github.com/abrasive/shairport.git", branch: "master"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "9c1716f8760f78af40db17ebbb11180312d7f89fa3c6a13dbe650e7f54879860"
    sha256 cellar: :any, big_sur:       "0c789ac825df4c2ee2caa494dd2bfc607a63e9fc5d60312587b36a5509491d99"
    sha256 cellar: :any, catalina:      "d385bd0045902de8acba7c41f7f1a1adfed5d9f13ea307af583de1b026ea0af0"
    sha256 cellar: :any, mojave:        "af28167bdd30a30511476472429673db781b9234cd4c8225a2ed3f10b869588c"
    sha256 cellar: :any, high_sierra:   "c819c407c218e35129dde1d00a0bb78e5cc85cf69cc0920f87f5a3f690e2cab5"
    sha256 cellar: :any, sierra:        "f3449bbbd695f608673ecf618c55f5d41ac8edad59772888a128185b23395b7b"
    sha256 cellar: :any, x86_64_linux:  "824288888cb2b19ec801797561ec6701f90551ac0b8843e59b29d2301377ca71" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"

  def install
    system "./configure"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/shairport", "-h"
  end
end
