echo "installing netcat"
apk add --update --no-cache netcat-openbsd
echo "running server"
nc -l -v -p 2399
echo "serv turned off"
while true
do
:
done
