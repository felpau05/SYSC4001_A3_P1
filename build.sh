if [ ! -d "bin" ]; then
    mkdir bin
else
	rm -f bin/*
fi

g++ -g -O0 -I . -o bin/interrupts_EP interrupts_101308579_101299663_EP.cpp
g++ -g -O0 -I . -o bin/interrupts_RR interrupts_101308579_101299663_RR.cpp
g++ -g -O0 -I . -o bin/interrupts_EP_RR interrupts_101308579_101299663_EP_RR.cpp