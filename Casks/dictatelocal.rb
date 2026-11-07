cask "dictatelocal" do
  version "0.1.0"
  sha256 "3a952053388956a434a27014b43cfb1d798971ca8a0395577703457ef4bed608"

  url "https://github.com/merkLui/DictateLocal/releases/download/v#{version}/DictateLocal-#{version}.dmg"
  name "DictateLocal"
  desc "On-device dictation from the menu bar, typed into any app"
  homepage "https://github.com/merkLui/DictateLocal"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "DictateLocal.app"

  # DictateLocal is signed but not notarized by Apple, so macOS would block the first launch
  # of the downloaded app. See https://github.com/merkLui/DictateLocal#faq
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DictateLocal.app"],
        must_succeed: false
  end

  uninstall quit: "com.luismerk.DictateLocal"

  zap trash: [
    "~/Library/Application Support/DictateLocal",
    "~/Library/Application Support/FluidAudio/Models/nemotron-labs-unified-asr",
    "~/Library/Application Support/FluidAudio/Models/parakeet-ultra",
    "~/Library/Preferences/com.luismerk.DictateLocal.plist",
  ]
end
