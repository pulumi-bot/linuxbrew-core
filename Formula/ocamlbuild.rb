class Ocamlbuild < Formula
  desc "Generic build tool for OCaml"
  homepage "https://github.com/ocaml/ocamlbuild"
  url "https://github.com/ocaml/ocamlbuild/archive/0.14.0.tar.gz"
  sha256 "87b29ce96958096c0a1a8eeafeb6268077b2d11e1bf2b3de0f5ebc9cf8d42e78"
  license "LGPL-2.0"
  revision 2
  head "https://github.com/ocaml/ocamlbuild.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_big_sur: "3959adfee1e78a7194faf82338106d5a281dfa14a55e37a7506dd5970f416358"
    sha256 big_sur:       "3daa705ce9d023a2679f609671d06de48e8dd1dd13ece8db46068802abbdd41f"
    sha256 catalina:      "8f6fc7e7413b24faa041b7651349a3128f9eadefae5c9aa0c50f0d1a56e010f6"
    sha256 mojave:        "04fed811edb4dd3903f742ec6678643f9959e85c4fcb763972c8779dec059515"
    sha256 high_sierra:   "e4cd0274f9657874e29add30545055af4ea8697d426ed95f799ddce63aef5cfe"
    sha256 x86_64_linux:  "ff6b9bddb52278904dd7ab0ce695da0273f9ede88920e28630c54672af98fdb6" # linuxbrew-core
  end

  depends_on "ocaml"

  def install
    system "make", "configure", "OCAMLBUILD_BINDIR=#{bin}", "OCAMLBUILD_LIBDIR=#{lib}", "OCAMLBUILD_MANDIR=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ocamlbuild --version")
  end
end
