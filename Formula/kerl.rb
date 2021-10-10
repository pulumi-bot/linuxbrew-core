class Kerl < Formula
  desc "Easy building and installing of Erlang/OTP instances"
  homepage "https://github.com/kerl/kerl"
  url "https://github.com/kerl/kerl/archive/2.2.1.tar.gz"
  sha256 "ce9117c0c402e676f92e1db0cc7bfd00412d5c32638d3846309c0a549c2ee685"
  license "MIT"
  head "https://github.com/kerl/kerl.git"

  def install
    bin.install "kerl"
    bash_completion.install "bash_completion/kerl"
    zsh_completion.install "zsh_completion/_kerl"
  end

  test do
    system "#{bin}/kerl", "list", "releases"
  end
end
