require "language/node"

class Bit < Formula
  desc "Distributed Code Component Manager"
  homepage "https://www.bitsrc.io"
  url "https://registry.npmjs.org/bit-bin/-/bit-bin-0.12.10.tgz"
  sha256 "e32ad338ccc97c8110bb3bd2954e37a8fe60d80c1559161ba6b0a5ad4595616a"
  head "https://github.com/teambit/bit.git"

  bottle do
    sha256 "6691bdcee45e14ff55553b5833af544bb876607a0b568b467e7b89e17e431251" => :high_sierra
    sha256 "869562b1d042fea7970804b90b78b5f9777394b1c847bece0760a9fff3c35ff7" => :sierra
    sha256 "247993bc0ef0d088aa26beb6cef7a246e82bc1c9da6f10d6f7db804f2a9556b7" => :el_capitan
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/bit init --skip-update")
    assert_match "successfully initialized", output
  end
end
