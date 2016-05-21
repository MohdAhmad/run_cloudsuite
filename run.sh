docker exec faban_client sh -c "cd /web20_benchmark/build && java -jar Usergen.jar http://$(docker inspect --format '{{ .NetworkSettings.Networks.my_net.IPAddress }}' web_server):8080"

docker exec faban_client sh -c "sed -i 's/<fa:scale.*/<fa:scale>150<\\/fa:scale>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:rampUp.*/<fa:rampUp>10<\\/fa:rampUp>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:rampDown.*/<fa:rampDown>10<\\/fa:rampDown>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:steadyState.*/<fa:steadyState>300<\\/fa:steadyState>/' /web20_benchmark/deploy/run.xml"
WEB_SERVER_IP=$(docker inspect --format '{{ .NetworkSettings.Networks.my_net.IPAddress }}' web_server)
docker exec faban_client sh -c "sed -i 's/<host.*/<host>$WEB_SERVER_IP<\\/host>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<port.*/<port>8080<\\/port>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<outputDir.*/<outputDir>\/faban\/output<\\/outputDir>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<delay.*/<delay>0<\\/delay>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<parallel.*/<parallel>true<\\/parallel>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "cd /web20_benchmark && ant run"
docker exec faban_client sh -c "cat /faban/output/*/summary.xml" > $1
#docker exec faban_client sh -c "cat /faban/output/*/summary.xml" > summary.xml
