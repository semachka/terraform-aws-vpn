#!/usr/bin/env bash
set -x

KEY_SAVE_FOLDER_PATH=$PKI_FOLDER_NAME/$KEY_SAVE_FOLDER
FULL_CLIENT_CERTIFICATE_NAME=$CLIENT_CERT_NAME.$TENANT_NAME
CLIENT_CERTIFICATE=$CLIENT_CERT_NAME.$CERT_ISSUER

aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id $CLIENT_VPN_ID --output text > $FULL_CLIENT_CERTIFICATE_NAME.ovpn --region $REGION --profile $AWSCLIPROFILE

sed -i "s/"$CLIENT_VPN_ID"/"$TENANT_NAME.$CLIENT_VPN_ID"/g" $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "<cert>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
cat $KEY_SAVE_FOLDER_PATH/$CLIENT_CERTIFICATE.crt >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "</cert>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn

echo "<key>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
cat $KEY_SAVE_FOLDER_PATH/$CLIENT_CERTIFICATE.key >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "</key>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
