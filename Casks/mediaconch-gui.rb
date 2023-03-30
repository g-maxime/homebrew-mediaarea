cask 'mediaconch-gui' do
  version '23.03'
  sha256 'https://mediaarea.net/download/binary/mediaconch-gui/#{version}/MediaConch_GUI_#{version}_Mac.dmg'

  url "https://mediaarea.net/download/binary/mediaconch-gui/#{version}/MediaConch_GUI_#{version}_Mac.dmg"
  appcast 'https://github.com/MediaArea/MediaConch_SourceCode/releases.atom'
  name 'MediaConch'
  homepage 'https://mediaarea.net/MediaConch/'
  app 'MediaConch.app'
end
