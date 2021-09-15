require "language/node"

class Vite < Formula
  desc "Next generation frontend tooling. It's fast!"
  homepage "https://vitejs.dev/"
  url "https://registry.npmjs.org/vite/-/vite-2.5.7.tgz"
  sha256 "db60140997a73657e922306a345c6081aa2545030019f866d488b651a2909fb4"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "511e68ad788f61e4ac75928166cc41882b45d6971289597c49d4d2117d0190f7"
    sha256 cellar: :any_skip_relocation, big_sur:       "216a8be12f8e2a5e20f2e2ed0db98a260452ad4702483061a8d2d988154b4370"
    sha256 cellar: :any_skip_relocation, catalina:      "216a8be12f8e2a5e20f2e2ed0db98a260452ad4702483061a8d2d988154b4370"
    sha256 cellar: :any_skip_relocation, mojave:        "216a8be12f8e2a5e20f2e2ed0db98a260452ad4702483061a8d2d988154b4370"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff4382e6dbb0119e5cf6711713276e77d42c2d09c5b21c55ef1a615bf893dd8e" # linuxbrew-core
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
    deuniversalize_machos
  end

  test do
    port = free_port
    fork do
      system bin/"vite", "preview", "--port", port
    end
    sleep 2
    assert_match "Cannot GET /", shell_output("curl -s localhost:#{port}")
  end
end
