class Stirmake < Formula
  desc "Scalable true implementation of recursive make"
  homepage "https://github.com/Aalto5G/stirmake"
  url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
  sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
  license "MIT"

  deny_network_access!

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
      sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
    elsif Hardware::CPU.arm?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
      sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
    else
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
      sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
    end
  end
  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmakebin-amd64-linux-glibc2.7-v0.4.4.tar.gz"
      sha256 "650c899e80cc219b9b401112061150bd40a75c1db35cfa16027a81ee04b29ed8"
    elsif Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmakebin-i386-linux-glibc2.7-v0.4.4.tar.gz"
      sha256 "48946d95db0e6584644519f2561fc6f6c7a301073e8af5810bb704eff6fef387"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmakebin-arm64-linux-glibc2.17-v0.4.4.tar.gz"
      sha256 "37683d38aceca107d892bf3065d899f305af0ae1fb764191d77a20dea12d417f"
    elsif Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmakebin-arm32hf-linux-glibc2.7-v0.4.4.tar.gz"
      sha256 "995a8d99e0aea073395fbc4229253003cf7321460080a76d29df6343bec87bb2"
    else
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.4/stirmake-v0.4.4.tar.gz"
      sha256 "2e8d385f563a563e2526ba92c8765d90c21c013a0a5038c08c00a22c9ed17c95"
    end
  end

  def install
    if Dir.exist?("stirc")
      Dir.chdir("stirc") do
        system "./bootstrapnomake.sh"
        bin.install "stirmake"
        man1.install "stirmake.1"
      end
    else
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
