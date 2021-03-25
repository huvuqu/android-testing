#/bin/bash
if [ -z "$1" ]
  then
    echo "Auto download from burp proxy"
    curl localhost:8080/cert -o cacert.cer
  else
    cp $1 cacert.cer
fi
adb root & adb remount
echo "Cert in cer format is generated"
echo "Convert to pem"
openssl x509 -inform DER -in cacert.cer -out cacert.pem
echo "Rename"
NAME=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem | head -1)
mv cacert.pem $NAME.0
echo "Install cert"
adb push $NAME.0 /system/etc/security/cacerts
adb shell chmod 644 /system/etc/security/cacerts/$NAME.0

adb shell mkdir /data/misc/user/0/cacerts-added
adb push $NAME.0 /data/misc/user/0/cacerts-added/cacerts
adb shell chmod 644 /data/misc/user/0/cacerts-added/cacerts/$NAME.0