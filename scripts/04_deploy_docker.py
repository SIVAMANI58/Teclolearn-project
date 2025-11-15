import paramiko
import os
from dotenv import load_dotenv

load_dotenv('./env/dev.env')

vms = {
    "vm1": os.getenv("VM1_IP"),
    "vm2": os.getenv("VM2_IP"),
    "vm3": os.getenv("VM3_IP")
}

def deploy(vm_ip, role):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(vm_ip, username=os.getenv("SSH_USER"), password=os.getenv("SSH_PASS"))

    ssh.exec_command("sudo apt update && sudo apt install -y docker.io")

    if role == "load_balancer":
        ssh.exec_command("docker run -d -p 80:80 nginx")
    else:
        ssh.exec_command("docker run -d -p 5000:5000 backend_service")

    ssh.close()

deploy(vms["vm1"], "load_balancer")
deploy(vms["vm2"], "backend")
deploy(vms["vm3"], "backend")
