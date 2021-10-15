class Jql < Formula
  desc "JSON query language CLI tool"
  homepage "https://github.com/yamafaktory/jql"
  url "https://github.com/yamafaktory/jql/archive/v3.0.1.tar.gz"
  sha256 "fadb8341a97257b2ef19e9c4a01062d2ff533d92861963fcd7f0e14b61dd855c"
  license "MIT"
  head "https://github.com/yamafaktory/jql.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fb162a7cb247f40c52498cd3875a24d99eee60ee28328570f041bb3079f16a02"
    sha256 cellar: :any_skip_relocation, big_sur:       "c4a0acfdd953f1559b78b98a741cc1f0b6469c4c9f54af90862d7a7018542f3c"
    sha256 cellar: :any_skip_relocation, catalina:      "5ccd6b90708480e1e65dcdac74be64fcc7ee321ac4599341100cf155c1a152c7"
    sha256 cellar: :any_skip_relocation, mojave:        "36dbf0891c438b561940411f0a0d9b95bac145fd9fbb8e825d75e5967278dd08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40d17bd0618972df1aa7b1c53e6586e772e1042b5392630d3462bd018e42eb64" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"example.json").write <<~EOS
      {
        "cats": [{ "first": "Pixie" }, { "second": "Kitkat" }, { "third": "Misty" }]
      }
    EOS
    output = shell_output("#{bin}/jql --raw-output '\"cats\".[2:1].[0].\"third\"' example.json")
    assert_equal "Misty\n", output
  end
end
