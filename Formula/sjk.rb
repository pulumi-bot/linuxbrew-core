class Sjk < Formula
  desc "Swiss Java Knife"
  homepage "https://github.com/aragozin/jvm-tools"
  url "https://search.maven.org/remotecontent?filepath=org/gridkit/jvmtool/sjk-plus/0.20/sjk-plus-0.20.jar"
  sha256 "c10aeb794137aebc1f38de0a627aaed270fc545026de216d36b8befb6c31d860"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "94b4054e1a1ad665cfc6ed8701d2b02746dfb1f099a2a688a2b945ec664c1575"
    sha256 cellar: :any_skip_relocation, big_sur:       "94b4054e1a1ad665cfc6ed8701d2b02746dfb1f099a2a688a2b945ec664c1575"
    sha256 cellar: :any_skip_relocation, catalina:      "94b4054e1a1ad665cfc6ed8701d2b02746dfb1f099a2a688a2b945ec664c1575"
    sha256 cellar: :any_skip_relocation, mojave:        "94b4054e1a1ad665cfc6ed8701d2b02746dfb1f099a2a688a2b945ec664c1575"
  end

  depends_on "openjdk"

  def install
    libexec.install "sjk-plus-#{version}.jar"
    bin.write_jar_script libexec/"sjk-plus-#{version}.jar", "sjk"
  end

  test do
    system bin/"sjk", "jps"
  end
end
