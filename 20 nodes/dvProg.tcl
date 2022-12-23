set ns [new Simulator]
set nr [open dv.tr w]
$ns trace-all $nr
set nf [open dv.nam w]

$ns namtrace-all $nf
        proc finish { } {
        global ns nr nf
        $ns flush-trace
        close $nf
        close $nr
        exec nam dv.nam &
	exit 0
        }

for { set i 0 } { $i < 20} { incr i 1 } {
set n($i) [$ns node]}

$ns duplex-link $n(0) $n(12) 5Mb 10ms DropTail
$ns duplex-link $n(12) $n(4) 5Mb 10ms DropTail
$ns duplex-link $n(4) $n(3) 5Mb 10ms DropTail
$ns duplex-link $n(3) $n(2) 5Mb 10ms DropTail
$ns duplex-link $n(2) $n(1) 5Mb 10ms DropTail
$ns duplex-link $n(1) $n(3) 5Mb 10ms DropTail
$ns duplex-link $n(4) $n(5) 5Mb 10ms DropTail
$ns duplex-link $n(5) $n(6) 5Mb 10ms DropTail
$ns duplex-link $n(4) $n(7) 5Mb 10ms DropTail
$ns duplex-link $n(4) $n(8) 5Mb 10ms DropTail
$ns duplex-link $n(9) $n(8) 5Mb 10ms DropTail
$ns duplex-link $n(10) $n(9) 5Mb 10ms DropTail
$ns duplex-link $n(11) $n(9) 5Mb 10ms DropTail



$ns duplex-link $n(5) $n(13) 5Mb 10ms DropTail
$ns duplex-link $n(13) $n(14) 5Mb 10ms DropTail
$ns duplex-link $n(1) $n(18) 5Mb 10ms DropTail
$ns duplex-link $n(18) $n(4) 5Mb 10ms DropTail

$ns duplex-link $n(0) $n(19) 5Mb 10ms DropTail
$ns duplex-link $n(19) $n(4) 5Mb 10ms DropTail
$ns duplex-link $n(1) $n(15) 5Mb 10ms DropTail

$ns duplex-link $n(15) $n(16) 5Mb 10ms DropTail
$ns duplex-link $n(16) $n(17) 5Mb 10ms DropTail















$n(5) shape box
$n(0) shape hexagon
$n(1) shape hexagon


set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set  interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n(5) $null0
$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$ns attach-agent $n(1) $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set  interval_ 0.005
$cbr1 attach-agent $udp1
set null0 [new Agent/Null]
$ns attach-agent $n(5) $null0
$ns connect $udp1 $null0

$ns rtproto DV 

$ns rtmodel-at 10.0 down $n(3) $n(1)
$ns rtmodel-at 15.0 down $n(12) $n(4)
$ns rtmodel-at 30.0 up $n(3) $n(1)
$ns rtmodel-at 20.0 up $n(12) $n(4)

$udp0 set fid_ 1
$udp1 set fid_ 2

$ns color 1 Red
$ns color 2 Blue

$ns at 1.0 "$cbr0 start"
$ns at 2.0 "$cbr1 start"

$ns at 45 "finish"
$ns run
