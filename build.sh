
IP_ADDRESS=192.168.1.9

echo "Always clean up first!"
echo ""

make clean

echo "Making..."
echo ""

make

echo "Make Stage..."
echo ""

make stage

echo "Make Install..."

make install