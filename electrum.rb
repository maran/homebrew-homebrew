require 'formula'

class Electrum < Formula
  url 'http://ecdsa.org/electrum/Electrum-0.60.tar.gz'
  homepage 'http://ecdsa.org/electrum'
  md5 'c7d7b3b85fcbd3fc08c96ca0660f41b7'

  depends_on "python"
  depends_on "qt"
  depends_on "pyqt"
  depends_on "gettext"

  def install
    opoo "Please note that this is a Alpha package, if stuff breaks it's not on me!\n\n Electrum needs to generate translations files in /usr/share/locale and a shortcut in /usr/share/applications, there for I chmod 777 these folders. \n Im not sure if this can do any harm, use this recipe at your own risk."
    system("sudo chmod -R 777 /usr/share/locale/")
    unless File.directory?("/usr/share/applications")
      ohai "Creating /usr/share/applications"
      system("sudo mkdir /usr/share/applications")
    end
    
    unless File.directory?("/usr/share/app-install")
      ohai "Creating /usr/share/applications"
      system("sudo mkdir /usr/share/app-install")
    end

    system("sudo chmod -R 777 /usr/share/app-install")    
    system("sudo chmod -R 777 /usr/share/applications")

    ohai 'Installing pip'
    system "/usr/local/share/python/easy_install pip"

    ohai 'Installing ecdsa'
    system "/usr/local/share/python/pip install ecdsa"

    ohai 'Installing slowaes'
    system "/usr/local/share/python/pip install slowaes"

    ohai "Compiling icons"
    system "pyrcc4 icons.qrc -o lib/icons_rc.py"

    ohai "Making translations"
    system "/usr/local/bin/python mki18n.py"

    ohai "Installing Electrum"
    system "/usr/local/bin/python setup.py install"
        
    opoo "Important notice\n\n Please add the '/usr/local/share/python' to your PATH, otherwise electrum might not boot for you."
  end

  def test
    system "electrum"
  end
end
