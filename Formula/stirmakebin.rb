class Stirmakebin < Formula
  desc "Scalable true implementation of recursive make"
  homepage "https://github.com/Aalto5G/stirmake"
  url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmake-v0.4.5.tar.gz"
  sha256 "932c0feca981f075cd848e7fcf0b0587351b1951c7d5b5781a6e7fdbe6d68021"
  license "MIT"

  no_autobump! because: :requires_manual_update

  conflicts_with "stirmake", because: "binary version of stirmake"

  deny_network_access!

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-amd64-macos.10.10-v0.4.5.tar.gz"
      sha256 "015420c67c88d4848005b8dc9caebb6ec913b6aefeee9bb83f4782da2ba1ebd9"
    elsif Hardware::CPU.arm?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-arm64-macos-11-v0.4.5.tar.gz"
      sha256 "f3aba9b456c40dc2622dbe6f60ece36415936b840f7a442888718cd15ca09e2a"
    else
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmake-v0.4.5.tar.gz"
      sha256 "932c0feca981f075cd848e7fcf0b0587351b1951c7d5b5781a6e7fdbe6d68021"
    end
  end
  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-amd64-linux-glibc2.7-v0.4.5.tar.gz"
      sha256 "1e50a5ff9f05c41df83f1a2001ec5b085bd8d843bc300e5ceae596100bc9ca6f"
    elsif Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-i386-linux-glibc2.7-v0.4.5.tar.gz"
      sha256 "d83d01ef42fbc9f41ee86c6e525ccb31b5b42d269c2ae5ccc245a03e3c39655f"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-arm64-linux-glibc2.17-v0.4.5.tar.gz"
      sha256 "358d0bbd828f5f20c37b3faf5cf1bc367cb4b2cea5b8541878e275318cf6f82c"
    elsif Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmakebin-arm32hf-linux-glibc2.7-v0.4.5.tar.gz"
      sha256 "fed5624362a468646a3dccfa29486ead23f1ce2e396a882e9f727ff3b4a625c2"
    else
      url "https://github.com/Aalto5G/stirmake/releases/download/v0.4.5/stirmake-v0.4.5.tar.gz"
      sha256 "932c0feca981f075cd848e7fcf0b0587351b1951c7d5b5781a6e7fdbe6d68021"
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
