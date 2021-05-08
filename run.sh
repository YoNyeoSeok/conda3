NAME=$USER
WORKDIR=$HOME
CUDA=11.2.2

options=$(getopt -o n:w:c: -l name:,workdir:,cuda: -- "$@")
[ $? -eq 0 ] || { 
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
	case "$1" in
		-n|--name)
			NAME="$2";
			shift 2 ;;
		-w|--workdir)
			WORKDIR="$2";
			shift 2 ;;
		-c|--cuda)
			CUDA="$2";
			shift 2 ;;
		--)
			shift; break
	esac
done

docker run -it -u $USER -w $WORKDIR -e "TERM=xterm-256color" \
	--name $NAME \
	--gpus all \
	--shm-size 32g \
	--pid host \
	-v=/home/$USER/data:/home/$USER/data:ro \
	-v=/home/$USER/research:/home/$USER/research \
	yonyeoseok/conda3:local

case $? in
	125) docker start $NAME; docker attach $NAME;;
	*) echo $ERR;;
esac
