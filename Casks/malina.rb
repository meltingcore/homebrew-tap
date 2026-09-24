cask "malina" do
  version "0.1.3"
  sha256 "68d3717d5297c643cb49868706904dd197fd9599912cb5e68a961cf119c066be"

  url "https://github.com/meltingcore/malina/releases/download/v#{version}/malina-#{version}-macos-universal.zip"
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
