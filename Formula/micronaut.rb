class Micronaut < Formula
  desc "Modern JVM-based framework for building modular microservices"
  homepage "https://micronaut.io/"
  url "https://github.com/micronaut-projects/micronaut-starter/archive/v3.0.3.tar.gz"
  sha256 "fe58ad20d4ac5aa6148c7743ad2a5f4f54741ab54e8b1bb1529bbe573fa3bf83"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6cb4dbc4038b8a49c476d0ec580f7e840b3b70d91719cf63ed07569352591ba1"
    sha256 cellar: :any_skip_relocation, big_sur:       "203d991d213f4824741bb1a98bb5048a71996f700daa9355033d356d1cf5e85f"
    sha256 cellar: :any_skip_relocation, catalina:      "4a1a5e946466f8220ea05696246967c8540fed62864d56cdc0796e557b533707"
    sha256 cellar: :any_skip_relocation, mojave:        "615efd96664369f68a26a0b7adcc1dc5fd9ec3c1b2dde3dfdbf8338064f97eb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53c2ae76aa612e0c7bd2e17d7a64c3bf08c8f9f7b2498f13ee6c51ae7df770ab" # linuxbrew-core
  end

  # Uses a hardcoded list of supported JDKs. Try switching to `openjdk` on update.
  depends_on "openjdk@11"

  def install
    system "./gradlew", "micronaut-cli:assemble", "-x", "test"

    mkdir_p libexec/"bin"
    mv "starter-cli/build/exploded/bin/mn", libexec/"bin/mn"
    mv "starter-cli/build/exploded/lib", libexec/"lib"

    bash_completion.install "starter-cli/build/exploded/bin/mn_completion"
    (bin/"mn").write_env_script libexec/"bin/mn", Language::Java.overridable_java_home_env("11")
  end

  test do
    system "#{bin}/mn", "create-app", "hello-world"
    assert_predicate testpath/"hello-world", :directory?
  end
end
