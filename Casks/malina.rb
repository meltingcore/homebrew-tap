cask "malina" do
  version "0.1.1"
  sha256 "b688c83cc71cb1838f98d211f2702a5f5ffbdd3f755ab6439af529a4f5cbadcb"

  url "https://github.com/meltingcore/malina/releases/download/v#{version}/malina-#{version}-macos-universal.zip",
      verified: "github.com/meltingcore/malina/"
  name "Malina"
  desc "Back up and restore Raspberry Pi systems over SSH"
  homepage "https://malina.meltingcore.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "malina-#{version}-macos-universal/Malina.app"
  binary "malina-#{version}-macos-universal/malina-cli", target: "malina"

  zap trash: "~/Library/Application Support/Malina"
end
