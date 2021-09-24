class Bgpq3 < Formula
  desc "BGP filtering automation for Cisco, Juniper, BIRD and OpenBGPD routers"
  homepage "http://snar.spb.ru/prog/bgpq3/"
  url "https://github.com/snar/bgpq3/archive/v0.1.36.tar.gz"
  sha256 "39cefed3c4f46b07bdcb817d105964f17a756b174a3c1d3ceda26ed00ecae456"
  license "BSD-2-Clause"
  head "https://github.com/snar/bgpq3.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "472157a36cb85bb858b6687a6fccb1dc32221b93545190459c6441f8644977ba"
    sha256 cellar: :any_skip_relocation, big_sur:       "21400e8e71cc8647ec4acbf90d4dbe1ed01dc483bae6c5fd422ce7856c922bb0"
    sha256 cellar: :any_skip_relocation, catalina:      "20323444446909aa9892ea16f3a2cbdc8ce6665be3270713dc01c3cb0163d35a"
    sha256 cellar: :any_skip_relocation, mojave:        "19d8b27219ecd0988603200ad428df266bacfddea15a4570de15ddfd2a017190"
  end

  # Makefile: upstream has been informed of the patch through email (multiple
  # times) but no plans yet to incorporate it https://github.com/snar/bgpq3/pull/2
  # there was discussion about this patch for 0.1.18 and 0.1.19 as well

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/bgpq3", "AS-ANY"
  end
end
