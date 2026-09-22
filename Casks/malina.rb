cask "malina" do
  version "0.1.2"
  sha256 "26a6e335c83f9d0f1d5b3aa39b9f9fe7622a8e447ed82850cdde19f8ce17c6b6"

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
