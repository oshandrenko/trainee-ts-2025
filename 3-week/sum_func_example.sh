sum () {
	local a=$1
	local b=$2
	echo $((a + b))
}


read -p "Enter a: " a

if [[ ! "$a" =~ ^-?[0-9]+$ ]]; then
    echo "a is not a number: $a"
    exit 1
fi

read -p "Enter b: " b

if [[ ! "$b" =~ ^-?[0-9]+$ ]]; then
    echo "b is not a number: $b"
    exit 1
fi


echo "$a + $b = $(sum $a $b)"
