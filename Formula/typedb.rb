class Typedb < Formula
  desc "Distributed hyper-relational database for knowledge engineering"
  homepage "https://vaticle.com/"
  url "https://github.com/vaticle/typedb/releases/download/2.4.0/typedb-all-mac-2.4.0.zip"
  sha256 "5691486a031ed021ebb1d38f5346a7e70bceb8bd92e2e197ac585c2dfb38b3a9"
  license "AGPL-3.0-or-later"

  depends_on "openjdk@11"

  def install
    libexec.install Dir["*"]
    bin.install libexec/"typedb"
    bin.env_script_all_files(libexec, Language::Java.java_home_env("11"))
  end

  test do
    assert_match "A STRONGLY-TYPED DATABASE", shell_output("#{bin}/typedb server status")
  end
end
