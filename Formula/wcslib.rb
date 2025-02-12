class Wcslib < Formula
  desc "Library and utilities for the FITS World Coordinate System"
  homepage "https://www.atnf.csiro.au/people/mcalabre/WCS/"
  url "https://www.atnf.csiro.au/pub/software/wcslib/wcslib-7.6.tar.bz2"
  sha256 "54bb8c92167a7f13f8aa73fc4b8a09785256d2c98213467debc7a282a431318b"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?wcslib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "1501d04bd38777379055060545973deadb4b61959291c7f86c48abf16cd20983"
    sha256 cellar: :any,                 big_sur:       "f0d3979ff121d5d7429d930f87da36df8b1f2c36c41376d63882def0c042fe05"
    sha256 cellar: :any,                 catalina:      "f6c3337cd1ea830d6f7034efefaba694a5e94d9f34e0ca79f29919e3b9128026"
    sha256 cellar: :any,                 mojave:        "765fc09c8786be17fdad63cee17bc93b6006be12f5858d38c9095a3370e5afa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e0c6108283c6aad0deaf5d1b772eb943dd33e8dd082a3de5257fd3c58873a0fd" # linuxbrew-core
  end

  depends_on "cfitsio"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-cfitsiolib=#{Formula["cfitsio"].opt_lib}",
                          "--with-cfitsioinc=#{Formula["cfitsio"].opt_include}",
                          "--without-pgplot",
                          "--disable-fortran"
    system "make", "install"
  end

  test do
    piped = "SIMPLE  =" + (" "*20) + "T / comment" + (" "*40) + "END" + (" "*2797)
    pipe_output("#{bin}/fitshdr", piped, 0)
  end
end
