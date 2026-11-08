class Stirmake < Formula
  desc "Scalable true implementation of recursive make"
  homepage "https://github.com/Aalto5G/stirmake"
  url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
  sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
  license "MIT"

  deny_network_access!

  def install
    Dir.chdir("stirc") do
      system "./bootstrapnomake.sh"
    end
    bin.install "stirc/stirmake"
    man1.install "stirc/stirmake.1"
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
