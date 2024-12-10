# Nexus-Prover-Node
- You need to have min 4 RAM in your system (VPS)
- Recommended: 6 GB RAM
- Purchase VPS with [PQ Hosting](https://pq.hosting/?from=555778&lang=en) using cryptocurrency
---
This script is compatible with Ubuntu on the local system as well as on VPS
- If you run on VPS, you don't need to do anything after running the installation commands
- If you run on a Local system (Ubuntu), you need to open the terminal after turning on your system to start this prover, it will start running automatically again, if it is not running then use this command to run
```bash
sudo systemctl start nexus.service
```

## Installation
- use either this command
---
This script is compatible with Ubuntu on the local system as well as on VPS
- If you run on VPS, you don't need to do anything after running the installation commands
- If you run on a Local system (Ubuntu), you need to open the terminal after turning on your system to start this prover, it will start running automatically again, if it is not running then use this command to run
```bash
sudo systemctl start nexus.service
```

## Installation
- You can use either this command
```bash
curl -sSL https://raw.githubusercontent.com/BORN2COD/Nexus-Prover-Node/main/nexus.sh | bash
```
- Or this command to run this script
```bash
wget -qO - https://raw.githubusercontent.com/BORN2COD/Nexus-Prover-Node/main/nexus.sh | bash
```

## Status
- You can check prover status using this command
```bash
systemctl status nexus.service
```
- To check logs, use the below command
```bash
journalctl -u nexus.service -f -n 50
```
- You will see something like this, it means, it is fine

![Screenshot 2024-10-09 115039](https://github.com/user-attachments/assets/3d3065d8-cb88-44ca-88b8-ac072bcf9eff)
