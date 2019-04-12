set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     18                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1126                      ;# X dimension of topography
set val(y)      608                      ;# Y dimension of topography
set val(stop)   20.0                         ;# time of simulation end


#Create a ns simulator
set ns [new Simulator]


#Setup topography 
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)


#trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#nam file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#node setup
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#Create nodes and setup position
set n0 [$ns node]
$n0 set X_ 462
$n0 set Y_ 363
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 653
$n1 set Y_ 240
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 1026
$n2 set Y_ 359
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 890
$n3 set Y_ 499
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 757
$n4 set Y_ 185
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 389
$n5 set Y_ 71
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 95
$n6 set Y_ 311
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 373
$n7 set Y_ 461
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 493
$n8 set Y_ 195
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 308
$n9 set Y_ 353
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 225
$n10 set Y_ 190
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 680
$n11 set Y_ 317
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 548
$n12 set Y_ 508
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 827
$n13 set Y_ 402
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 706
$n14 set Y_ 479
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 571
$n15 set Y_ 107
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n18 [$ns node]
$n18 set X_ 960
$n18 set Y_ 197
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 209
$n19 set Y_ 457
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20

#making the nodes mobile
$ns at 8 " $n1 setdest 350 350 30 " 
$ns at 5 " $n3 setdest 400 225 40 " 
$ns at 5 " $n5 setdest 450 450 40 " 
$ns at 6 " $n7 setdest 600 250 30 " 
$ns at 5 " $n8 setdest 250 400 50 " 
$ns at 2 " $n9 setdest 500 400 30 " 
$ns at 7 " $n10 setdest 900 300 40 " 
$ns at 5 " $n11 setdest 240 300 30 " 
$ns at 4 " $n13 setdest 800 500 60 " 
$ns at 3 " $n14 setdest 400 150 50 " 
$ns at 6 " $n15 setdest 300 100 30 " 
$ns at 7 " $n18 setdest 750 350 30 " 
$ns at 4 " $n19 setdest 400 400 50 " 

#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n6 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500 #in bytes

#Setup a UDP connection
set udp2 [new Agent/UDP]
$ns attach-agent $n10 $udp2
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
$ns connect $udp2 $null3
$udp2 set packetSize_ 1500


#FTP Application over TCP
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 20.0 "$ftp0 stop"

#CBR Application over UDP
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp2
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.0Mb
$cbr1 set random_ null
$ns at 4.0 "$cbr1 start"
$ns at 20.0 "$cbr1 stop"


#termination
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

#reset the nodes at 20.0
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}

#stop simulation at 20.0 and call finish
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
