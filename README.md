# iBeacon CLI

iBeacon and AltBeacon command line scanner

## Usage

```
ibeacon: iBeacon command line utility

      -h  --help             Display this message
      -v  --version          Display 'Version 1.0.0'
      -s  --scan             Scan for iBeacons

    Scan options:
      -i  --interval         Time interval in seconds
```


### Examples

Scanning:

```
% ibeacon --scan
{ranged: []}
{entered: { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: -61}}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: -61}]}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: 0}]}
{entered: { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 9, minor: 8, rssi: -34}}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: -61},
          { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 9, minor: 8, rssi: -34}]}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: 0},
          { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 9, minor: 8, rssi: 0}]}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: -63},
          { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 9, minor: 8, rssi: 0}]}
{exited:  { uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 9, minor: 8, rssi: 0}}
{ranged: [{ uuid: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 1, rssi: -94}]}
```

# License

Copyright &copy; 2014 by Julian Cheal

This software is licensed under an adapted BSD license, the Attribution Assurance License.  See the [LICENSE](LICENSE) for details.
