class Miniupnpc < Formula
  desc "UPnP IGD client library and daemon"
  homepage "https://miniupnp.tuxfamily.org"
  url "http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpc-2.2.3.tar.gz"
  sha256 "dce41b4a4f08521c53a0ab163ad2007d18b5e1aa173ea5803bd47a1be3159c24"
  license "BSD-3-Clause"

  # We only match versions with only a major/minor since versions like 2.1 are
  # stable and versions like 2.1.20191224 are unstable/development releases.
  livecheck do
    url "https://miniupnp.tuxfamily.org/files/"
    regex(/href=.*?miniupnpc[._-]v?(\d+\.\d+(?>.\d{1,7})*)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "c3e13a0a9a9a29ae1e11b68391c05af3502a38cc8e4c64106cab777453db5027"
    sha256 cellar: :any,                 big_sur:       "dc8464030d7e318498fbed1aa9964c925285ceb6543a09abcff42b343681b20e"
    sha256 cellar: :any,                 catalina:      "6a509044ce6d522df1c435ba211ec9cac427328bee216619f8fcd7c6de65ce0a"
    sha256 cellar: :any,                 mojave:        "03cc532eeef519bf6db64926a70d56b365eccb0e752ab791cf21683da94bddc4"
  end

  def install
    system "make", "INSTALLPREFIX=#{prefix}", "install"
  end

  test do
    output = shell_output("#{bin}/upnpc --help 2>&1", 1)
    assert_match version.to_s, output
  end
end
