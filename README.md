# Nexus-Prover-Node
- You need to have min 4 RAM in your system (VPS)
- Recommended: 6 GB RAM
- Purchase VPS with [PQ Hosting](https://pq.hosting/?from=555778&lang=en) using cryptocurrency
---
**Nexus Testnet CLI Command [VPS]**  

Running a Nexus on the command-line interface (CLI) is identical to the web version, with the added benefit of not requiring your PC to remain powered on, as the virtual private server (VPS) will handle the task.  

--- 

**Getting Started**  

1️⃣ Get a VPS:  
- Go with a cheap VPS you can afford.  

2️⃣ **Set up VPS and proceed with Termius.**  

---

🔧 **Update System Directory**  

```bash
sudo apt update && sudo apt upgrade
sudo apt install build-essential pkg-config libssl-dev git-all
```

- Reply with `Y` and wait for the process to complete.  

---

🐦 **Install Rust**  

```bash
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh
. "$HOME/.cargo/env"
```

---

🔄 **Reboot System**  

Wait 30 seconds, reconnect the terminal:  

```bash
reboot
```

---

⚙️ **Install Compiler**  

```bash
sudo apt install -y protobuf-compiler
```

---

🚀 **Run Command**  

```bash
curl https://cli.nexus.xyz/ | sh
```

Wait for the entire process to complete. To pause:  

`CTRL + Z`

---

🔑 **Configuring Prover ID**  

Copy the prover ID from [https://beta.nexus.xyz/](https://beta.nexus.xyz/) and replace:  

```bash
echo "YOUR_PROVER_ID" > ~/.nexus/prover-id
```

Re-run the command:  

```bash
curl https://cli.nexus.xyz/ | sh
```

---

🎉 **All Set!**  

Now you’re ready. Wait some time to see it reflected on the web interface.  

✅ Done!
```

![Screenshot 2024-10-09 115039](https://github.com/user-attachments/assets/3d3065d8-cb88-44ca-88b8-ac072bcf9eff)
