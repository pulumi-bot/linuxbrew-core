class A52dec < Formula
  desc "Library for decoding ATSC A/52 streams (AKA 'AC-3')"
  homepage "https://liba52.sourceforge.io/"
  url "https://liba52.sourceforge.io/files/a52dec-0.7.4.tar.gz"
  sha256 "a21d724ab3b3933330194353687df82c475b5dfb997513eef4c25de6c865ec33"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://liba52.sourceforge.io/downloads.html"
    strategy :page_match
    regex(/href=.*?a52dec[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "a9a4752a7b6d4872abf06a725a44b94d1701e4621c0e4226002e371df53ff366"
    sha256 cellar: :any, big_sur:       "f5b95a6c1f7758e29cc04160d3635fce074c6c527cb3ac209877d8e4d1b4935c"
    sha256 cellar: :any, catalina:      "949600b627a44697bc12713538c5aed594fc8201694f5c453c8ca5f9f8cd335a"
    sha256 cellar: :any, mojave:        "a47f3248a481d224edcbec3e266793ff73f2e94bb607732df2166a0c6f442596"
    sha256 cellar: :any, x86_64_linux:  "78e0873180ff1548d213c861e9cc3fd6c61371c6c140c3be0f4f3b73c0851458" # linuxbrew-core
  end

  def install
    if OS.linux?
      # Fix error ld: imdct.lo: relocation R_X86_64_32 against `.bss' can not be
      # used when making a shared object; recompile with -fPIC
      ENV.append_to_cflags "-fPIC"
    else
      # Fixes duplicate symbols errors on arm64
      ENV.append_to_cflags "-std=gnu89"
    end

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    touch testpath/"test"
    system "#{bin}/a52dec", "-o", "null", "test"
  end
end
