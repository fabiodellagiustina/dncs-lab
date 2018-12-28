# DNCS-LAB assigment (working on...)

Design of Networks and Communication Systems  
A/Y 2018-19  
University of Trento

* * *

Do you know Vagrant? No? You must check [this](https://www.vagrantup.com/)!

## Assignment by Nicola Arnoldi

Based on the _Vagrantfile​_ and the provisioning scripts available at <https://github.com/dustnic/dncs-lab>, the candidate is required to design a working network in witch any host configured and attached to​ _router-1​_ (through _switch​_) can browse a website hosted on _host-2-c_.
Subnetting must be designed to meet the following requirements (no need to create more hosts than described in the _Vagrantfile_):

-   up to 130 hosts in the same subnet of​ _host-1-a_
-   up to 25 hosts in the same subnet of _host-1-b_
-   consume as few IP addresses as possible

## Network map

         +------------------------------------------------------------+
         |                                                        eth0|
     +---+---+                  +------------+                 +------+-----+
     |       |                  |            |                 |            |
     |       +------------------+  router-1  +-----------------+  router-2  |
     |   v   |              eth0|            |eth2         eth2|            |
     |   a   |                  +-----+------+                 +------+-----+
     |   g   |                        |eth1                       eth1|
     |   r   |                        |                               |
     |   a   |                        |                           eth1|
     |   n   |                        |eth1                     +-----+----+
     |   t   |             +----------+-----------+             |          |
     |       |             |                      |             |          |
     |   m   +-------------+        switch        |             | host-2-c |
     |   a   |         eth0|                      |             |          |
     |   n   |             +---+--------------+---+             |          |
     |   a   |                 |eth2      eth3|                 +-----+----+
     |   g   |                 |              |                   eth0|
     |   e   |                 |              |                       |
     |   m   |                 |eth1      eth1|                       |
     |   e   |           +-----+----+    +----+-----+                 |
     |   n   |           |          |    |          |                 |
     |   t   |           |          |    |          |                 |
     |       +-----------+ host-1-a |    | host-1-b |                 |
     |       |       eth0|          |    |          |                 |
     |       |           |          |    |          |                 |
     +--+-+--+           +----------+    +----+-----+                 |
        | |                               eth0|                       |
        | +-----------------------------------+                       |
        +-------------------------------------------------------------+

## Network configuration

### Subnets

| Subnet | Devices (Interface)                   | Network address   | Netmask         | # of hosts |
| ------ | ------------------------------------- | ----------------- | --------------- | ---------- |
| A      | router-1 (eth1.10)<br>host-1-a (eth1) | 172.22.1.0/24     | 255.255.255.0   | 254        |
| B      | router-1 (eth1.20)<br>host-1-b (eth1) | 172.22.2.224/27   | 255.255.255.224 | 30         |
| C      | router-2 (eth1)<br>host-2-c (eth1)    | 172.22.3.252/30   | 255.255.255.252 | 2          |
| D      | router-1 (eth2)<br>router-2 (eth2)    | 172.31.255.252/30 | 255.255.255.252 | 2          |

### VLANs

| VID | [Subnet](#subnets) |
| --- | ------------------ |
| 10  | A                  |
| 20  | B                  |

### Interface-IP mapping

| Device   | Interface | IP                | [Subnet](#subnets) |
| -------- | --------- | ----------------- | ------------------ |
| host-1-a | eth1      | 172.22.1.1/24     | A                  |
| router-1 | eth1.10   | 172.22.1.254/24   | A                  |
| host-1-b | eth1      | 172.22.2.225/27   | B                  |
| router-1 | eth1.20   | 172.22.2.254/27   | B                  |
| host-2-c | eth1      | 172.22.3.253/30   | C                  |
| router-2 | eth1      | 172.22.3.254/30   | C                  |
| router-1 | eth2      | 172.31.255.253/30 | D                  |
| router-2 | eth2      | 172.31.255.254/30 | D                  |

## router-1 configuration ([router-1.sh](/router-1.sh))
