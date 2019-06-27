# docker run -p 8088:8088 --name my-hadoop-container -d my-hadoop

# Choose 3 clusters
N=${1:-3}

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
	 docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                my-hadoop &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                my-hadoop &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
docker exec -it hadoop-master bash
