class Stirmake < Formula
  desc "Scalable true implementation of recursive make"
  homepage "https://github.com/Aalto5G/stirmake"
  url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmake-v0.4.5.tar.gz"
  sha256 "932c0feca981f075cd848e7fcf0b0587351b1951c7d5b5781a6e7fdbe6d68021"
  license "MIT"

  deny_network_access!

  conflicts_with "stirmakebin", because: "source version of stirmake"

  def install
    Dir.chdir("stirc") do
      system "./bootstrapnomake.sh"
      bin.install "stirmake"
      man1.install "stirmake.1"
    end
    bin.install_symlink bin/"stirmake" => "smka"
    bin.install_symlink bin/"stirmake" => "smkt"
    bin.install_symlink bin/"stirmake" => "smkp"
    man1.install_symlink "stirmake.1" => "smka.1"
    man1.install_symlink "stirmake.1" => "smkt.1"
    man1.install_symlink "stirmake.1" => "smkp.1"
  end

  test do
    (testpath/"Stirfile").write "@toplevel\n@strict\n@phonyrule: 'all':\n\techo STIRMAKE_WORKS\n"
    assert_match "STIRMAKE_WORKS", shell_output("#{bin}/smka")
  end
end
