sudo apt-get update
sudo apt-get install git unzip nodejs -y
git clone https://github.com/traceless/alist-encrypt
python3 fix_path.py
cd alist-encrypt/node-proxy || exit
export NODE_OPTIONS=--openssl-legacy-provider 
npm install
mv app.js alist_encrypt.js
cd ../..
mv alist-encrypt/node-proxy/ ./dist
ALIST_ENCRYPT_VERSION=$(cat alist-encrypt/node-proxy/src/config.js | grep -oP "version = '\K[0-9]+\.[0-9]+\.[0-9]+")
echo $ALIST_ENCRYPT_VERSION
rm -rf alist-encrypt
OLD_VERSION=$(grep -oP '^version=\K\S+' module.prop)
sed -i "s/^version=$OLD_VERSION$/version=v$ALIST_ENCRYPT_VERSION/" module.prop
zip -r Alist-Encrypt.zip * -x build.sh update.json fix_path.py .github/*
