local MONEY_SRV_DIR=~/wave/money-srv/
if [ -d $WAVE_INSTALL_DIR ]; then
    path+=$WAVE_INSTALL_DIR/bin
    myconfigs[wave-money-srv]=installed
else
    myconfigs[wave-money-srv]=not-installed
fi
