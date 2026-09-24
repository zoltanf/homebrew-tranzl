cask "tranzl" do
  version "0.2.1"
  sha256 "158865ffdd8bc69aa683476a0a00c3cd1635d1033fe90e810ce24745f94d4b52"

  url "https://github.com/zoltanf/tranzl/releases/download/v#{version}/Tranzl-#{version}-arm64.zip"
  name "Tranzl"
  desc "Private, on-device LLM translator and text editor"
  homepage "https://github.com/zoltanf/tranzl"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Tranzl.app"

  # Tranzl is ad-hoc signed (not notarized); without this Gatekeeper refuses
  # to launch it. Disclosed in the caveats below.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tranzl.app"]
  end

  zap trash: [
    "~/Library/Application Support/tranzl",
  ]

  caveats <<~EOS
    Tranzl is ad-hoc signed (not notarized). This cask removes the macOS
    quarantine attribute from the installed app so it can launch; only
    install it if you trust this tap.

    On first use, Tranzl offers to download the Gemma 4 E4B model (~4.6 GB),
    which is subject to Google's Gemma Terms of Use.
  EOS
end
