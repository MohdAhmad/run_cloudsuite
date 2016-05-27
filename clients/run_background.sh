web_server_ip=$1

docker exec faban_client sh -c "cd /web20_benchmark/build && java -jar Usergen.jar http://$web_server_ip:8080"

docker exec faban_client sh -c "sed -i 's/<fa:scale.*/<fa:scale>200<\\/fa:scale>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:rampUp.*/<fa:rampUp>30<\\/fa:rampUp>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:rampDown.*/<fa:rampDown>30<\\/fa:rampDown>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<fa:steadyState.*/<fa:steadyState>10000<\\/fa:steadyState>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<host.*/<host>$web_server_ip<\\/host>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<port.*/<port>8080<\\/port>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<outputDir.*/<outputDir>\/faban\/output<\\/outputDir>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<delay.*/<delay>0<\\/delay>/' /web20_benchmark/deploy/run.xml"
docker exec faban_client sh -c "sed -i 's/<parallel.*/<parallel>true<\\/parallel>/' /web20_benchmark/deploy/run.xml"
docker exec -d faban_client sh -c "cd /web20_benchmark && ant run"
#docker exec faban_client sh -c "cat /faban/output/*/summary.xml" > tmp.txt 
#docker exec faban_client sh -c "cat /faban/output/*/summary.xml" > summary.xml
