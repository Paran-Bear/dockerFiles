# Environments
SLEEP_SECONDS=60

docker-compose -f ./docker-compose-solrcloud-local.yml up -d

echo "Waiting ${SLEEP_SECONDS} seconds to compose Solr ..."
sleep ${SLEEP_SECONDS}
echo 'OK.'

echo 'Copy an analyzer to nodes ...'
docker exec -it solr1 mkdir -p /opt/solr/contrib/analysis-korean/lib
docker exec -it solr2 mkdir -p /opt/solr/contrib/analysis-korean/lib
docker exec -it solr3 mkdir -p /opt/solr/contrib/analysis-korean/lib
docker cp ./korean-analyzer-ktnori-1.0.2 solr1:/opt/solr/contrib/analysis-korean/lib/korean-analyzer-ktnori-1.0.2.jar
docker cp ./korean-analyzer-ktnori-1.0.2 solr2:/opt/solr/contrib/analysis-korean/lib/korean-analyzer-ktnori-1.0.2.jar
docker cp ./korean-analyzer-ktnori-1.0.2 solr3:/opt/solr/contrib/analysis-korean/lib/korean-analyzer-ktnori-1.0.2.jar
echo 'OK.'

echo "Configure 'chat-base-config' ..."
docker cp ./solr_default solr1:/opt/solr/
docker exec -u 0 -it solr1 /opt/solr/bin/solr zk upconfig -n chat-base-config -d /opt/solr/solr_default/ -z zoo1:2181
docker exec -u 0 -it solr1 rm -rf /opt/solr/solr_default
echo 'OK.'

# Append hostnames into a local domain lookup file
# $ echo '127.0.0.1       solr1 solr2 solr3 zoo1 zoo2' >> /etc/hosts
echo 'TODO: Append hostnames into a local domain lookup file'
echo "  ex) echo '127.0.0.1       solr1 solr2 solr3 zoo1 zoo2' >> /etc/hosts"