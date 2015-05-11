#PortString

Map short strings to port numbers within the “registered” port range (1024–49151).

## Description

This ruby mini class/executable takes 3-letter (or shorter) strings that match
```ruby
/[a-z_]{1}[a-z_0-9\-\+@%\^]{0,2}/
```
and unambiguously maps them to numbers within the TCP’s “registered” range (where you should be choosing you’re port numbers from).
(Shorter strings are internally padded with underscores.)

You can use it if you prefer letter-string symbols for your ports instead of numbers.

./server.rb --port `./port_string.rb lol`
./server.rb --port `./port_string.rb www`
./server.rb --port `./port_string.rb foo`
./server.rb --port `./port_string.rb bar`
./server.rb --port `./port_string.rb me`
./server.rb --port `./port_string.rb db`
./server.rb --port `./port_string.rb w@t`
