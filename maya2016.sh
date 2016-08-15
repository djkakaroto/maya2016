#!/bin/bash
#Download Maya from here: http://download.autodesk.com/us/support/files/maya_2016_service_pack_4/Autodesk_Maya_2016_SP4_EN_Linux_64bit.tgz
#Get a student License from: http://www.autodesk.com/education/free-software/maya
#Log in and select maya 2016, your language and an OS. Either should work.
echo "Have you edited this script to add in your lisence, username and home folder and am running this with sudo?"
echo "[y/n]"
read ED
if [[ $ED == y* ]]; then
  mkdir maya2016_setup
  mv Autodesk_Maya_2016_SP4_EN_Linux_64bit.tgz maya2016_setup/
  cd maya2016_setup
  tar xvf Autodesk_Maya_2016_SP4_EN_Linux_64bit.tgz
  export RPM_INSTALL_PREFIX=/usr
  export LD_LIBRARY_PATH=/opt/Autodesk/Adlm/R11/lib64/
  LIBCRYPTO="/usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0"
  LIBSSL="/usr/lib/x86_64-linux-gnu/libssl.so.1.0.0"
  apt-get install -y gcc libssl1.0.0 libssl-dev libjpeg62 alien csh tcsh libaudiofile-dev libglw1-mesa elfutils libglw1-mesa-dev mesa-utils xfstt ttf-liberation xfonts-100dpi xfonts-75dpi ttf-mscorefonts-installer libfam0 libfam-dev libgstreamer-plugins-base0.10-0
  wget http://launchpadlibrarian.net/183708483/libxp6_1.0.2-2_amd64.deb
  for i in *.rpm; do
    alien -cv $i;
  done
  dpkg -i *.deb
  mkdir /usr/tmp
  chmod 777 /usr/tmp
  xset +fp /usr/share/fonts/X11/100dpi/
  xset +fp /usr/share/fonts/X11/75dpi/
  cp lib* /usr/lib/
  echo -e 'MAYA_LICENSE=unlimited\nMAYA_LICENSE_METHOD=standalone' > /usr/autodesk/maya2016/bin/License.env
  #*****LICENSE HERE*****
  /usr/autodesk/maya2016/bin/adlmreg -i S 657H1 657H1 2016.0.0.F ***-******** /var/opt/Autodesk/Adlm/Maya2016/MayaConfig.pit
  ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/autodesk/maya2016/lib/libcrypto.so.10
  ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/autodesk/maya2016/lib/libssl.so.10
  ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5.2.0 /usr/lib/libtiff.so.3
  ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so.62 /usr/lib/libjpeg.so.62
  rm /usr/lib/libfam.so.0
  ln -s /usr/lib/libfam.so.0.0.0 /usr/lib/libfam.so.0
  sh -c "echo 'setenv LC_ALL en_US.UTF-8' >> /usr/autodesk/maya2016/bin/maya2016"
  /usr/autodesk/maya2016/bin/licensechooser /usr/autodesk/maya2016/ standalone 657H1 maya
  export MAYA_LOCATION=/usr/autodesk/maya2016/
  export LD_LIBRARY_PATH=/opt/Autodesk/Adlm/R11/lib64/
  echo "int main (void) {return 0;}" > mayainstall.c
  gcc mayainstall.c
  mv /usr/bin/rpm /usr/bin/rpm_backup
  cp a.out /usr/bin/rpm
  chmod +x ./setup
  ./setup
  rm /usr/bin/rpm
  mv /usr/bin/rpm_backup /usr/bin/rpm
  gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"
  sed -n '/LIBQUICKTIME_PLUGIN_DIR/ i setenv LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjpeg.so.62' /usr/autodesk/maya2016/bin/maya
  sed -i '/Exec/c\Exec=xterm -e maya' /usr/autodesk/maya2016/desktop/Autodesk-Maya.desktop
  rm /usr/share/applications/Autodesk-Maya2016.desktop
  cp /usr/autodesk/maya2016/desktop/Autodesk-Maya.desktop /usr/share/applications/Autodesk-Maya2016.desktop
  maya
  echo "repairing permissions..."
  #****USER AND HOME HERE*****  
  chown -R ***** /home/*****
  echo "Maya is now ready to use!"
  echo "You can delete the maya2016_setup folder but not the \"Adlm\", \"maya\" and \"xgen\" folders"
else
  echo "please edit this script to add in your lisence, username and home folder"
  echo "these are located at *****LICENSE HERE***** and *****USER AND HOME HERE*****"
fi
