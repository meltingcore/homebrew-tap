cask "malina" do
  version "0.1.2"
  sha256 "36f7781c45ce98a72c7da15de53ccf1e73cc5a5b782540f37947a61dd7c876df"

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
