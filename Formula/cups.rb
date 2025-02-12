class Cups < Formula
  desc "Common UNIX Printing System"
  homepage "https://github.com/OpenPrinting/cups"
  url "https://github.com/OpenPrinting/cups/releases/download/v2.3.3op2/cups-2.3.3op2-source.tar.gz"
  # This is the author's fork of CUPS. Debian have switched to this fork:
  # https://lists.debian.org/debian-printing/2020/12/msg00006.html
  sha256 "deb3575bbe79c0ae963402787f265bfcf8d804a71fc2c94318a74efec86f96df"
  license "Apache-2.0"
  head "https://github.com/OpenPrinting/cups.git", branch: "master"

  bottle do
    sha256 arm64_big_sur: "ac83d0ea52bebcdb2eff93c6ccbaf29c14369a7d2643bf3a85780ed34c13e0a4"
    sha256 big_sur:       "4943fd51e0dcd79d2f02cebe3ff007af6b69252ee6a2bb2ea9cdd2d7c0ec7ebc"
    sha256 catalina:      "eddaee8d8b01941fc65ff0689424221956c02fa98c09ba056e3f00baac63652f"
    sha256 mojave:        "a83b539b7e2f0865be0b6f0123c32c82788b8c52ecd5cf972cc15882a7ac0ba5"
    sha256 x86_64_linux:  "c4ca222a2de10b8a371de6576a7c11de8f0d81b5ddb2bcac76df3e9431b2637c" # linuxbrew-core
  end

  keg_only :provided_by_macos

  uses_from_macos "krb5"
  uses_from_macos "zlib"

  def install
    system "./configure", "--disable-debug",
                          "--with-components=core",
                          "--without-bundledir",
                          "--prefix=#{prefix}",
                          "--libdir=#{lib}"
    system "make", "install"
  end

  test do
    port = free_port.to_s
    pid = fork do
      exec "#{bin}/ippeveprinter", "-p", port, "Homebrew Test Printer"
    end

    begin
      sleep 2
      assert_match("Homebrew Test Printer", shell_output("curl localhost:#{port}"))
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
