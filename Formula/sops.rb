class Sops < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.7.1.tar.gz"
  sha256 "536ee140d888b53b71c1e8edd669f4c11bc573428983fbea644fbbfcd7d7079a"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6ed7327988bf2db73d4883d5c4e280cd5e576980b15cd584841175714e9a6a17"
    sha256 cellar: :any_skip_relocation, big_sur:       "786527c0a00ac74579e50623298aef7f5a996d63211c08d14b87999255f41809"
    sha256 cellar: :any_skip_relocation, catalina:      "f95b128d36ffb171695376d011dbf1fc971117152367c109f6232949b45e710a"
    sha256 cellar: :any_skip_relocation, mojave:        "edc533e3636e05deb0a854a1c3950dfdbeb01ac38f7ef6d8857426d55991a542"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15bb735ac67ddf8759c16fa420061c66607d2cb62a8fbffa15c74b7528c1a77b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"sops", "go.mozilla.org/sops/v3/cmd/sops"
    pkgshare.install "example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sops --version")

    assert_match "Recovery failed because no master key was able to decrypt the file.",
      shell_output("#{bin}/sops #{pkgshare}/example.yaml 2>&1", 128)
  end
end
