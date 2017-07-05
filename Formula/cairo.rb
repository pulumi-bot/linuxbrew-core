class Cairo < Formula
  desc "Vector graphics library with cross-device output support"
  homepage "https://cairographics.org/"
  url "https://cairographics.org/releases/cairo-1.14.10.tar.xz"
  mirror "https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cairo-1.14.10.tar.xz"
  sha256 "7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09"
  revision 1 unless OS.mac?

  bottle do
    sha256 "0cf7f50b38512fd676b6b14f5b22961ababa3958c448f6485055bdad3a04b439" => :sierra
    sha256 "65c3e0c132f1fc0747881b5057cdc6e77a2859d061bbe88406aff1e22e42971b" => :el_capitan
    sha256 "034818691b65af1ec4d5601affc791061bf269f8e1092c57b891cdea6f47cc2d" => :yosemite
    sha256 "a52b2ceb3a35e584b9e81c716d06e06d8914cf600b98627b0f63e3c55b256b7a" => :x86_64_linux
  end

  head do
    url "https://anongit.freedesktop.org/git/cairo", :using => :git
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  keg_only :provided_pre_mountain_lion

  depends_on "pkg-config" => :build
  if OS.mac?
    depends_on :x11 => :optional
  else
    depends_on :x11 => :recommended
  end
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "libpng"
  depends_on "pixman"
  depends_on "glib"
  depends_on "zlib" unless OS.mac?

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-gobject=yes
      --enable-svg=yes
      --enable-tee=yes
    ]
    args += %w[
      --enable-quartz-image
    ] if OS.mac?

    if build.with? "x11"
      args << "--enable-xcb=yes" << "--enable-xlib=yes" << "--enable-xlib-xrender=yes"
    else
      args << "--enable-xcb=no" << "--enable-xlib=no" << "--enable-xlib-xrender=no"
    end

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <cairo.h>

      int main(int argc, char *argv[]) {

        cairo_surface_t *surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, 600, 400);
        cairo_t *context = cairo_create(surface);

        return 0;
      }
    EOS
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    libpng = Formula["libpng"]
    pixman = Formula["pixman"]
    flags = %W[
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{include}/cairo
      -I#{libpng.opt_include}/libpng16
      -I#{pixman.opt_include}/pixman-1
      -L#{lib}
      -lcairo
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
