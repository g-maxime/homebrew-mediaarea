class BwfmetaeditGui < Formula
  desc "Embed, validate and export Broadcast WAVE Format (BWF) metadata"
  homepage "https://mediaarea.net/BWFMetaEdit"
  url "https://mediaarea.net/download/binary/bwfmetaedit-gui/26.08/BWFMetaEdit_GUI_26.08_GNU_FromSource.tar.xz"
  sha256 "8960ee20329c7773f0979af42dbd7d2edc4dafa3584bc21815e998498d0b89fa"

  depends_on "qt"
  depends_on "rust" => :build

  def install
    dylib = buildpath/"Source/ThirdParty/c2pa-rs/target/release/libc2pa_c.dylib"
    cd "Source/ThirdParty/c2pa-rs" do
      system "cargo", "build", "--release", "--locked", "-p", "c2pa-c-ffi",
             "--no-default-features", "--features", "rust_native_crypto, http, file_io"

      MachO::Tools.change_dylib_id(dylib, "@rpath/libc2pa_c.dylib")
    end

    cd "Project/QtCreator" do
      system "#{Formula["qt"].bin}/qmake", "ENABLE_C2PA=dynamic"
      system "make"

      frameworks = Pathname.pwd/"BWF MetaEdit.app/Contents/Frameworks"
      frameworks.mkpath
      cp dylib, frameworks/"libc2pa_c.dylib"

      prefix.install "BWF MetaEdit.app"

      bin.mkpath
      ln "#{prefix}/BWF MetaEdit.app/Contents/MacOS/BWF MetaEdit", bin/"bwfmetaedit-gui"
    end
  end

  test do
    assert_path_exists bin/"bwfmetaedit-gui"
    assert_path_exists prefix/"BWF MetaEdit.app/Contents/Frameworks/libc2pa_c.dylib"
  end
end
