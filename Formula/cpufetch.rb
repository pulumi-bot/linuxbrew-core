class Cpufetch < Formula
  desc "CPU architecture fetching tool"
  homepage "https://github.com/Dr-Noob/cpufetch"
  url "https://github.com/Dr-Noob/cpufetch/archive/v1.00.tar.gz"
  sha256 "2254c2578435cc35c4d325b25fdff4c4b681de92cbce9a7a36e58ad58a3d9173"
  license "MIT"
  head "https://github.com/Dr-Noob/cpufetch.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a9261597d5753e1946399243d1a678ad734d04583769a7c44471f7ce9618cc82"
    sha256 cellar: :any_skip_relocation, big_sur:       "79a1430cf484b5af27898f13a6cbfa50c45c704b114dc1422f033f540b9c9fdf"
    sha256 cellar: :any_skip_relocation, catalina:      "38e7cd730de97b753d3c1cbf342d132c62dbc914e9ec17f775e55c2e8d78ad1a"
    sha256 cellar: :any_skip_relocation, mojave:        "790d979cab962161c6b4e372f67f11c756f9f2f1404f39f61997d64a5dd1215e"
  end

  def install
    system "make"
    bin.install "cpufetch"
    man1.install "cpufetch.1"
  end

  test do
    actual = shell_output("#{bin}/cpufetch -d").each_line.first.strip

    expected = if OS.linux?
      "cpufetch v#{version} (Linux #{Hardware::CPU.arch} build)"
    elsif Hardware::CPU.arm?
      "cpufetch v#{version} (macOS ARM build)"
    else
      "cpufetch is computing APIC IDs, please wait..."
    end

    assert_equal expected, actual
  end
end
