class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.41.1.tgz"
  sha256 "2625fc90a712db380c9aea180351789bb2c93922db066e0682c3ac2cd2fde6b8"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "45b8a7aa7417fc0fee50f4e190c33276082a905342988f1bde1bcd50464709ae"
    sha256 cellar: :any_skip_relocation, big_sur:       "45b8a7aa7417fc0fee50f4e190c33276082a905342988f1bde1bcd50464709ae"
    sha256 cellar: :any_skip_relocation, catalina:      "45b8a7aa7417fc0fee50f4e190c33276082a905342988f1bde1bcd50464709ae"
    sha256 cellar: :any_skip_relocation, mojave:        "45b8a7aa7417fc0fee50f4e190c33276082a905342988f1bde1bcd50464709ae"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.scss").write <<~EOS
      div {
        img {
          border: 0px;
        }
      }
    EOS

    assert_equal "div img{border:0px}",
    shell_output("#{bin}/sass --style=compressed test.scss").strip
  end
end
