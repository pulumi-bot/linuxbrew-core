class CucumberRuby < Formula
  desc "Cucumber for Ruby"
  homepage "https://cucumber.io"
  url "https://github.com/cucumber/cucumber-ruby/archive/v7.0.0.tar.gz"
  sha256 "6c0102449bf7de6f1aeb4f124f3cf61fc5bf6c09a008b57a5b922c95a1517478"
  license "MIT"
  revision 1

  bottle do
    sha256                               big_sur:      "1dd04346b06c82870dd9efb59350a4ed25ac437b7c8af28898f79d1f6986cc0c"
    sha256 cellar: :any,                 catalina:     "4cb95855cffcbae6eef87f5be2fc6aaec0173604df39ab1dacad9b3d32ecba91"
    sha256 cellar: :any,                 mojave:       "878244bcd01e75f74aaf3adc5f3d4acb0ffc410529b7261df0b0966c9b0a1e32"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e22c8852f8a878f65c6e6e34ee7ca1354d402a9f0ac1fb83530dfc49f71a5e8" # linuxbrew-core
  end

  depends_on "pkg-config" => :build

  uses_from_macos "libffi", since: :catalina
  uses_from_macos "ruby", since: :big_sur

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "cucumber.gemspec"
    system "gem", "install", "cucumber-#{version}.gem"
    bin.install libexec/"bin/cucumber"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_match "create   features", shell_output("#{bin}/cucumber --init")
    assert_predicate testpath/"features", :exist?
  end
end
