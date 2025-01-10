Multipass 是一個輕量方便使用的指令工具，其在不同的作業系統是使用不同的虛擬化技術（Linux 使用 KVM, Windows 使用 Hyper-V 而 macOS 使用 HyperKit），並且可以直接指定安裝的 Ubuntu 版本
```
sudo snap install multipass
```

#### cmd

創建虛擬機(name為k3s的範例)
```
multipass launch --name k3s --cpus 2 --memory 4G --disk 10G
```

列出存在的虛擬機
```
multipass list 
```

執行命令(ls為例)
```
multipass exec k3s -- ls -l
```

進入虛擬機
```
multipass shell k3s
```

掛載目錄
```
multipass mount ~/kubernetes/master master:~/master
```

使用ssh到mutipass虛擬機
```
multipass shell k3s
sudo apt install net-tools
vim /etc/ssh/sshd_config 
# 修改PasswordAuth, RootLogin, PubkeyAuth
passwd

# 回到主機
exit
ssh-keygen -t ras -b 4096
ssh-copy-id ubuntu@192.168.105.10 
alias k3s ='ssh ubuntu@19m2.168.105.10
```

設定ssh
```
ssh-keygen -t rsa -f ~/.ssh/multipass_key -N ""

# Copy the public key content 

PUBLIC_KEY=$(cat ~/.ssh/multipass_key.pub) 

# Add the key to each VM properly 

multipass exec k3s-master -- bash -c "mkdir -p ~/.ssh && echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh" 

multipass exec k3s-worker1 -- bash -c "mkdir -p ~/.ssh && echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh" 

multipass exec k3s-worker2 -- bash -c "mkdir -p ~/.ssh && echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"
```

安裝k3s至不同節點上（從master到worker)
``` 

multipass exec k3s-master curl -sfL https://get.k3s.io | sh -

TOKEN=$(multipass exec k3s-master sudo cat /var/lib/rancher/k3s/server/node-token)
MASTER_IP=$(multipass info k3s | grep IPv4 | awk '{print $2}')

 for f in 1 2; do  
     multipass exec k3s-worker$f -- bash -c "curl -sfL https://get.k3s.io/k3s-install.sh | K3S_URL=\"https://$MASTER_IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"  
 done
 
```