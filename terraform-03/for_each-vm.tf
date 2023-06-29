
resource "yandex_compute_instance" "base" {
  depends_on = [yandex_compute_instance.platform]
  for_each = {
 
  "main" = { cpu = 4, mem = 2 , disk = 5}
 
  "replica" = { cpu = 2, mem = 1,  disk = 6}

  }
  name        = each.key
 platform_id = "standard-v1"
  resources {
    cores         = each.value.cpu
    memory        = each.value.mem
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys           = local.file
  }

}