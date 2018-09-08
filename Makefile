C := mac
S := vpn.server.com

init:
	docker-compose run --rm openvpn ovpn_genconfig -u udp://$S
	docker-compose run --rm openvpn ovpn_initpki
	sudo chown -R $(whoami): ./openvpn-data

up:
	docker-compose up -d openvpn

down:
	docker-compose down

logs:
	docker-compose logs -f

create-client:
	docker-compose run --rm openvpn easyrsa build-client-full $C
	docker-compose run --rm openvpn ovpn_getclient $C > $C.ovpn

revoke:
	docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
