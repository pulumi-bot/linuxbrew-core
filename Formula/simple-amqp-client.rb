class SimpleAmqpClient < Formula
  desc "C++ interface to rabbitmq-c"
  homepage "https://github.com/alanxz/SimpleAmqpClient"
  url "https://github.com/alanxz/SimpleAmqpClient/archive/v2.5.1.tar.gz"
  sha256 "057c56b29390ec7659de1527f9ccbadb602e3e73048de79594521b3141ab586d"
  license "MIT"
  head "https://github.com/alanxz/SimpleAmqpClient.git", branch: "master"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "f66fc5dd89e9899a536b516486a88484a9f6e375ff2a452c686812fe2dadbc23"
    sha256 cellar: :any, big_sur:       "f2dd44e2182fa7da6d5e9dcc255ad06138b09be9e0619ecd07135e6fc2c35405"
    sha256 cellar: :any, catalina:      "97ceed4ae134cb5f01dc3c5efdafaccf3374aee7c748217eba9bb8624edb74dc"
    sha256 cellar: :any, mojave:        "42bf1dcae157dc5e3ad6c274cfff63e0599d1c1fa2ed634696a26ec499e6b18f"
    sha256 cellar: :any, high_sierra:   "0df2d53228ce5b30d670a67b36b8440158d4773c55c206456fc2762c7e820cec"
    sha256 cellar: :any, x86_64_linux:  "96aaed121b7614924269545ce7e9b4cee653b77d39e8090e7101dd79669ae822" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "boost"
  depends_on "rabbitmq-c"

  def install
    mkdir "build" do
      system "cmake", "..", "-DCMAKE_INSTALL_LIBDIR=lib", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <SimpleAmqpClient/SimpleAmqpClient.h>
      #include <string>
      int main() {
        const std::string expected = "test body";
        AmqpClient::BasicMessage::ptr_t msg = AmqpClient::BasicMessage::Create(expected);

        if(msg->Body() != expected) return 1;

        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lSimpleAmqpClient", "-o", "test"
    system "./test"
  end
end
