echo "installing netcat"
apk add --update --no-cache netcat-openbsd
echo "running client"
while true
do 
        nc 172.18.0.2 2399
        echo "client turned off, trying again"
done
