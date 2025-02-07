class Ncmpc < Formula
  desc "Curses Music Player Daemon (MPD) client"
  homepage "https://www.musicpd.org/clients/ncmpc/"
  url "https://www.musicpd.org/download/ncmpc/0/ncmpc-0.45.tar.xz"
  sha256 "17ff446447e002f2ed4342b7324263a830df7d76bcf177dce928f7d3a6f1f785"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.musicpd.org/download/ncmpc/0/"
    regex(/href=.*?ncmpc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "a64c5c10fe80ddd0ed8b2be3c18b9e372d9ed4d67a2d80bd28f6190721c92b89"
    sha256 cellar: :any,                 big_sur:       "fa933f289d06e2e37bf1b94d897fe86b20f294e5910f5782fc5a2bd0be20e75c"
    sha256 cellar: :any,                 catalina:      "70b5ffcaebc6ff5cf99f6a3b2ef2c4533457fe43b62e9107be991f8367be6785"
    sha256 cellar: :any,                 mojave:        "ae2e4bb23568d6a807defe05f4d5256ca265c9aa7657b8ad073dc4f71e1c62ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9da923ffb4400c42a20a1540e0070d530b7870bd4c15491bb1dbd6e211b9645c" # linuxbrew-core
  end

  depends_on "boost" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "libmpdclient"
  depends_on "pcre"

  on_linux do
    depends_on "gcc"
  end

  fails_with gcc: "5"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dcolors=false", "-Dnls=disabled", ".."
      system "ninja", "install"
    end
  end

  test do
    system bin/"ncmpc", "--help"
  end
end
