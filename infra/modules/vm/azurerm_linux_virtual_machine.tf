# 仮想マシン作成（Linux）
resource "azurerm_linux_virtual_machine" "web_vm" {
  name                  = var.vm_name
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [var.network_interface_web_nic_id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/src/keypair.pub") # SSH鍵へのパスを適宜変更してください
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # Pythonの簡易HTTPサーバーをセットアップするためのクラウドイニット
  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y python3

    # サンプルHTMLファイル作成
    mkdir -p /var/www/html
    cat > /var/www/html/index.html <<'EOT'
    <!DOCTYPE html>
    <html>
    <head>
        <title>Terraform Web Server</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                line-height: 1.6;
            }
            h1 {
                color: #333;
            }
        </style>
    </head>
    <body>
        <h1>Hello from Terraform!</h1>
        <p>This web server was provisioned using Terraform on Azure.</p>
    </body>
    </html>
    EOT

    # Pythonの簡易HTTPサーバーを起動するサービスを作成
    cat > /etc/systemd/system/webserver.service <<'EOT'
    [Unit]
    Description=Python HTTP Server
    After=network.target

    [Service]
    Type=simple
    User=root
    WorkingDirectory=/var/www/html
    ExecStart=/usr/bin/python3 -m http.server 80
    Restart=always

    [Install]
    WantedBy=multi-user.target
    EOT

    # サービスを有効化して起動
    systemctl enable webserver
    systemctl start webserver
    EOF
  )
}
