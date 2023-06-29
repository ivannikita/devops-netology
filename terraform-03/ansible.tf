resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

    { 
    databases =  yandex_compute_instance.base
    webservers =  yandex_compute_instance.platform 
    storage =  yandex_compute_instance.disk_machine
          }  )

  filename = "${abspath(path.module)}/hosts.cfg"
}