#!/bin/bash

rwidth=$1
rheight=$2

# debug 
echo Native Resolution: $rwidth $rheight

#downloads mods
mkdir drive_c/tmp
cd drive_c/tmp
wget https://deadlystream.com/files/file/1159-kotor-high-resolution-menus/?do=download&csrfKey=bd85319c3744d22bcc2889fe56d99690
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/mods/%5BK1%5D_Main_Menu_Widescreen_Fix_v1.2.7z
wget https://deadlystream.com/files/file/1457-hd-menus-and-ui-assets/?do=download&csrfKey=bd85319c3744d22bcc2889fe56d99690
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/mods/hd_pc_portraits-v1.0.7z
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/mods/hd_npc_portraits-v2.0.7z
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/mods/KoToR1IconMOD.7z
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/mods/kotor_intro_cutscenes_1920x1080.7z

# extract all 7z archives
7z x -aoa .

# install mods
mkdir -p "../GOG Games/Star Wars - KotOR/override"
cp "16-by-9/gui.1920x1080/"* "../GOG Games/Star Wars - KotOR/override"
cp "[K1]_Main_Menu_Widescreen_Fix_v1.2/For Override/"* "../GOG Games/Star Wars - KotOR/override"
cp "HD MENU AND UI Art v 1.0/"* "../GOG Games/Star Wars - KotOR/override"
cp "hd_pc_portraits/Override/"* "../GOG Games/Star Wars - KotOR/override"
cp "hd_npc_portraits/Override/"* "../GOG Games/Star Wars - KotOR/override"
cp "KoToR1IconMOD/Override/"* "../GOG Games/Star Wars - KotOR/override"
cp "movies_HD/1920x1080/"* "../GOG Games/Star Wars - KotOR/movies"

# widescreen patch
cd "../GOG Games/Star Wars - KotOR/"
wget https://github.com/legluondunet/MyLittleLutrisScripts/raw/master/Star%20Wars%20-%20Knights%20of%20the%20Old%20Republic/resolution_patchs/swkotor1_gog_ws_1920x1080.patch
cp swkotor.exe swkotor.exe.ori
LD_LIBRARY_PATH=/usr/lib patch < swkotor1_gog_ws_1920x1080.patch swkotor.exe

# config file
sed -i -e 's/Anti Aliasing=.*/Anti Aliasing=1/' -e '/\[Graphics Options\]/a Width\=1920' -e '/\[Graphics Options\]/a Height\=1080' -e '/\[Graphics Options\]/a AllowWindowedMode\=1' -e '/\[Graphics Options\]/a RefreshRate\=60' -e 's/Disable Vertex Buffer Objects=.*/Disable Vertex Buffer Objects=0/' swkotor.ini

# clean
mkdir saves
rm -f -r app commonappdata __redist __support tmp goggame-1207666283.* 'swkotor1_gog_ws_1920x1080.patch' ../../tmp ;
