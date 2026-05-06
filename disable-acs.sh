# Disable ACS P2P redirect on all PCIe bridges. Run after every boot.

python3 -c "
import subprocess, re
out = subprocess.check_output(['lspci', '-vv'], text=True, timeout=30)
devices = out.split('\n\n')
count = 0
for dev in devices:
    lines = dev.strip().split('\n')
    if not lines or not lines[0]: continue
    bdf = lines[0].split()[0]
    acs_offset = None
    for line in lines:
        if 'Access Control Services' in line:
            m = re.search(r'\[([0-9a-fA-F]+)\s', line)
            if m: acs_offset = m.group(1)
        if 'ACSCtl:' in line and 'ReqRedir+' in line and acs_offset:
            ctrl_offset = int(acs_offset, 16) + 6
            subprocess.run(['setpci', '-s', bdf, f'{ctrl_offset:x}.w=0x0011'], check=True)
            count += 1
            print(f'  Disabled ACS on {bdf} (ctrl@0x{ctrl_offset:x})')
            break
print(f'Done. Disabled ACS on {count} devices.')
"
remaining=$(lspci -vv 2>/dev/null | grep "ACSCtl:" | grep -c "ReqRedir+")
echo "Devices with ReqRedir+ remaining: $remaining"
