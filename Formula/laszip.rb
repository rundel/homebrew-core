class Laszip < Formula
  desc "Lossless LiDAR compression"
  homepage "https://www.laszip.org/"
  url "https://github.com/LASzip/LASzip/releases/download/3.2.0/laszip-src-3.2.0.tar.gz"
  sha256 "44f4ed0ee6bbe6584f3a4a1face2e6fc17bdc9760e91db8723513a528fb5047a"
  head "https://github.com/LASzip/LASzip.git"

  bottle do
    sha256 "4cee96706f3bc7d6e1df98010d39ecd3dd004efc81befd91c8a80caa43be7c22" => :high_sierra
    sha256 "d4fcf4c03ba5fca510b3184970247e0ceb7de130189929e4320a2c528f62a6f7" => :sierra
    sha256 "c3fe0e2e685e72d4e170d187863ba6ef9847fc47c57a4c18f6b25fd622f41c42" => :el_capitan
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "example"
  end

  test do
    system ENV.cxx, pkgshare/"example/laszipdllexample.cpp", "-L#{lib}",
                    "-llaszip", "-llaszip_api", "-Wno-format", "-o", "test"
    assert_match "LASzip DLL", shell_output("./test -h 2>&1", 1)
  end
end
